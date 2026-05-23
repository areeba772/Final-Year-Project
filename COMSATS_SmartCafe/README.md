# Smart Cafe

## Run
```bash
pip install -r requirements.txt
cd backend
python app.py
```

## Database
Import `backend/database_schema_v2.sql` into MySQL (`smart_cafe_health_db`).

## Default logins (from schema)
- User: `user@cafe.com` / `123456`
- Admin: `admin@cafe.com` / `admin123`
- **Food Authority:** `authority@cafe.com` / `authority123` (use this — not the old fake `food@gmail.com` login)

## Authority flow
1. Login → Check Prices (mark High Price → auto warning to admin)
2. Send Notification → compose hygiene/price complaints
3. Admin → Notifications → Reply to Authority
4. Authority → Send Notification page → Inbox shows admin replies
