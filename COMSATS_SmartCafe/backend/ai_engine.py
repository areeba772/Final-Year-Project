import pandas as pd
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.metrics.pairwise import cosine_similarity


def get_smart_recommendations(menu_items, last_ordered_item_name):
    """
    Hybrid Recommendation: Content-Based Filtering + Rating Boost.
    """
    df = pd.DataFrame(menu_items)
    if df.empty:
        return []

    # Ensure 'rating' column exists (default to 3.0 if missing)
    if 'rating' not in df.columns:
        df['rating'] = 3.0
    
    # Fill NaN ratings
    df['rating'] = df['rating'].fillna(3.0)

    # 1. Feature Engineering
    df['features'] = df['name'] + " " + df['category'] + " " + df['description']

    # 2. Vectorization
    cv = CountVectorizer(stop_words='english')
    try:
        matrix = cv.fit_transform(df['features'])
        similarity = cosine_similarity(matrix)
    except ValueError:
        # Fallback if vocabulary empty
        return sorted(menu_items, key=lambda x: x.get('rating', 0), reverse=True)[:5]

    # 3. Recommendations Logic
    if not last_ordered_item_name:
        # Default: Return Top Rated Items instead of random first 5
        # Assuming menu_items already has 'rating' from the app.py modified earlier
        return sorted(menu_items, key=lambda x: x.get('rating', 0), reverse=True)[:5]

    try:
        # Find index of last ordered item
        item_indices = df[df['name'] == last_ordered_item_name].index
        if len(item_indices) == 0:
             return sorted(menu_items, key=lambda x: x.get('rating', 0), reverse=True)[:5]
        
        item_index = item_indices[0]
    except IndexError:
        return sorted(menu_items, key=lambda x: x.get('rating', 0), reverse=True)[:5]

    # 4. Hybrid Scoring: (Similarity * 0.7) + (Normalized Rating * 0.3)
    # Normalize ratings to 0-1 scale (assuming 5 star max)
    df['norm_rating'] = df['rating'] / 5.0
    
    sim_scores = list(enumerate(similarity[item_index]))
    
    # Create a list of tuples: (index, final_score)
    final_scores = []
    for idx, sim_score in sim_scores:
        if idx == item_index: continue # Skip the item itself
        
        rating_score = df.iloc[idx]['norm_rating']
        # Weights: 70% Similarity, 30% Popularity (Rating)
        hybrid_score = (sim_score * 0.7) + (rating_score * 0.3)
        final_scores.append((idx, hybrid_score))

    # Sort by Hybrid Score
    final_scores = sorted(final_scores, key=lambda x: x[1], reverse=True)

    recommended_items = []
    for i in final_scores[:5]:
        idx = i[0]
        recommended_items.append(menu_items[idx])

    return recommended_items
