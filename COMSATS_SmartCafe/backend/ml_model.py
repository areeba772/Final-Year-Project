import pandas as pd
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.metrics.pairwise import cosine_similarity


def get_personal_health_recommendations(menu_items, user_past_history_items, is_over_budget):
    """
    AI-Powered Personal Health Assistant:
    Content-Based Filtering tailored strictly to the current logged-in user's past history.
    If the user has exceeded their weekly calorie budget, high-calorie items are down-ranked
    and low-calorie healthy alternatives are boosted.
    """
    df = pd.DataFrame(menu_items)
    if df.empty:
        return []

    # Ensure 'calories' column exists (default to 0 if missing)
    if 'calories' not in df.columns:
        df['calories'] = 0
    else:
        df['calories'] = df['calories'].fillna(0)

    # 1. Feature Engineering
    # Combine relevant text fields for content-based similarity
    # We include ingredients, category, and description
    df['features'] = df['name'] + " " + df['category'] + " " + df['description']
    if 'ingredients' in df.columns:
        df['ingredients_clean'] = df['ingredients'].fillna("")
        df['features'] = df['features'] + " " + df['ingredients_clean']

    # 2. Vectorization
    try:
        cv = CountVectorizer(stop_words='english')
        matrix = cv.fit_transform(df['features'])
        similarity = cosine_similarity(matrix)
    except ValueError:
        # Fallback if vocabulary empty
        return df.to_dict('records')[:5]
    except Exception:
        # Generic fallback
        return df.to_dict('records')[:5]

    # 3. Recommendations Logic
    # If the user has no history, just return lowest calorie items if over budget, else random/top
    if not user_past_history_items:
        if is_over_budget:
            return sorted(menu_items, key=lambda x: x.get('calories', 0))[:5]
        else:
            return menu_items[:5]

    # Find indices of user's past ordered items in the current menu
    past_item_names = [item['name'] for item in user_past_history_items]
    past_indices = df[df['name'].isin(past_item_names)].index.tolist()
    
    if not past_indices:
        # If none of the past items are currently in the menu
        if is_over_budget:
            return sorted(menu_items, key=lambda x: x.get('calories', 0))[:5]
        else:
            return menu_items[:5]

    # Calculate average similarity to all past ordered items
    avg_similarity = similarity[past_indices].mean(axis=0)

    final_scores = []
    for idx, sim_score in enumerate(avg_similarity):
        # We can recommend items they have ordered before, or keep them out. 
        # Usually it's fine to recommend their favorites again, but let's score them
        item_calories = df.iloc[idx]['calories']
        
        # Base score is the similarity to their past orders
        final_score = sim_score
        
        # Apply Health Constraints
        if is_over_budget:
            if item_calories > 300:
                final_score *= 0.2  # Down-rank high-calorie items
            elif item_calories < 200:
                final_score *= 1.5  # Boost low-calorie items
                
        final_scores.append((idx, final_score))

    # Sort by Final Score
    final_scores = sorted(final_scores, key=lambda x: x[1], reverse=True)

    recommended_items = []
    seen = set()
    for i in final_scores:
        idx = i[0]
        item_name = df.iloc[idx]['name']
        if item_name not in seen:
            recommended_items.append(menu_items[idx])
            seen.add(item_name)
        if len(recommended_items) == 5:
            break

    return recommended_items
