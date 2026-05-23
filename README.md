# Smart Cafe Management System (FYP)

An AI-powered, multi-role cafe management web application specifically tailored for **COMSATS University Islamabad, Vehari Campus**. This system optimizes campus dining by streamlining real-time ordering, automated table reservations, and digital food authority compliance.

---

## 🧠 Updated AI Recommendation Logic
The system features an intelligent recommendation engine powered by **Scikit-learn**. Instead of generic global ratings, the AI provides personalized, context-aware suggestions for each user based on:
1. **Personal Past Order History:** Tailoring recommendations to individual taste preferences and frequent choices.
2. **Health-Conscious Filter (Calorie Tracking):** Dynamically analyzing calorie counts to actively promote healthy food choices when a user's previous selection patterns reflect high caloric intake.

---

## 🚀 Key Modules & Role-Based Features

### 👤 1. User Module (Students & Teachers)
- **Personalized AI Suggestions:** Get customized food item recommendations based on past consumption history and health metrics.
- **Table Reservation:** Pre-book dine-in slots by selecting available Time Slots (8 AM - 5 PM) and specifying the number of guests.
- **Real-time Orders:** Browse the dynamic menu, manage a persistent shopping cart, and checkout using JazzCash or Cash on Delivery (COD).
- **Interactive Feedback:** Rate and review dishes to constantly train and improve the personal AI recommendation model.

### 🛠️ 2. Admin Module
- **Dynamic Menu Management:** Add, update, or remove menu options seamlessly with real-time price tags, descriptions, and item images.
- **Live Order Tracking:** Monitor and transition active order statuses (`Pending` ➡️ `Cooking` ➡️ `Completed`) while validating digital payments.
- **Analytics Dashboard:** Keep track of business performance with high-level statistics on total revenue, pending operations, and active users.
- **Governance & Support:** Respond directly to user help tickets and resolve formal complaints or warnings raised by the Food Authority.

### ⚖️ 3. Food Authority Module
- **Price Monitoring:** Ensure complete compliance with university-mandated pricing policies by reviewing the digital menu catalog.
- **Quality Assurance & Hygiene:** Directly audit customer reviews and feedback trends to track cafeteria hygiene standards.
- **Warning Dispatch System:** Issue official, trackable policy violation notices directly to the Admin dashboard.

---

## 💻 Tech Stack
- **Frontend:** HTML5, Custom CSS3 Styling, JavaScript (Asynchronous data fetching via Fetch API)
- **Backend:** Python (Flask Framework)
- **Database:** MySQL (Relational Database Management System)
- **AI Engine:** Scikit-learn (Machine Learning - Recommendation System)

---

## 📸 System Screenshots

### 🌐 User Portal
#### Landing Page
![Landing Page](https://github.com/user-attachments/assets/32338614-7a66-4e43-8abd-8251dbc8c48e)

#### User Authentication
| Login Page | Signup Page |
| :---: | :---: |
| ![User-Login](https://github.com/user-attachments/assets/44a8aca8-0f0f-4ef2-975d-2a3bdb23db0c) | ![User-signup](https://github.com/user-attachments/assets/c2349c11-f8f2-4ddd-9bca-b51fc0b2cab1) |

#### User Home & AI Panel
![User Home Page](<img width="1918" height="982" alt="image" src="https://github.com/user-attachments/assets/0fbb34f2-0148-4bea-9265-0404738ed956" />

![AI Food Recommendation]<img width="1917" height="981" alt="image" src="https://github.com/user-attachments/assets/e245a014-daf8-44f6-b8b8-ba0158a552c8" />


#### Ordering & Reservation Flow
* **Interactive Menu:** ![Menu Page](https://github.com/user-attachments/assets/238b22d4-9116-4f68-a566-fd2fb4aa8b96)
* **Seat Reservation:** ![Reserve Seat Page](https://github.com/user-attachments/assets/d12ccfac-6e87-46c3-a882-78b59d3168f2)
* **Checkout & Past History:** ![Checkout Page](https://github.com/user-attachments/assets/08473302-a1d8-4d88-9691-394a4db5f48f)
  ![Past Order Detail Page](https://github.com/user-attachments/assets/383683a2-a398-4f5e-999d-2e782f241c9d)

#### Support
![Contact Us Page](https://github.com/user-attachments/assets/6ae7cad7-63fc-476d-b2fb-94765c1a13ad)

---

### 🛠️ Admin Dashboard
#### Admin Login & Analytics Dashboard
![Admin Login Page](https://github.com/user-attachments/assets/692105d1-73c8-4939-8446-6fbe0f24176f)
![Admin Dashboard](https://github.com/user-attachments/assets/d6722f5a-2004-487e-95a4-f4d687144901)

#### Operations & Management
* **Order Tracking:** ![Order Management Page](https://github.com/user-attachments/assets/9cfedfd9-4067-456b-88d0-6c4528a9e6a5)
* **Menu Editing:** <img width="1918" height="997" alt="image" src="https://github.com/user-attachments/assets/66bfbd34-4cce-46b1-85ee-08d3f830d476" />

* **Table Logs:** ![Table Management Page](https://github.com/user-attachments/assets/d1871e4c-a88a-46c3-a9d9-dd7bf47431eb)

#### Feedback & Compliance Alerts
![Customer Review Page](https://github.com/user-attachments/assets/9d320b8e-d16a-46da-ae90-6efb63e1aa43)
![Notification Page](https://github.com/user-attachments/assets/8d3bdc39-4cf7-4568-8f94-ac5495a4f381)

---

### ⚖️ Food Authority Console
#### Portal Authentication & Main Analytics
![Authority Login Page](https://github.com/user-attachments/assets/af37cdfb-d88f-46a5-be81-18f5adc74e26)
![Authority Dashboard](https://github.com/user-attachments/assets/e9b71489-7210-4de2-8ea2-df8f43909dbc)

#### Quality Audits & Infractions
* **Review Auditing:** ![User Review Page](https://github.com/user-attachments/assets/48375e52-1a0d-4400-8e39-97dfd05e66af)
* **Price Checks:** ![Check Price Page](https://github.com/user-attachments/assets/95b5c288-c6ad-4af6-abb5-71dff7e1616d)
* **Issuing Violations:** ![Send Notification Page](https://github.com/user-attachments/assets/0a67b100-111a-4cec-8db0-743a90072138)

---

## ⚙️ Local Installation Guide

1. **Clone the Repository:**
   ```bash
   git clone [https://github.com/your-username/your-repo-name.git](https://github.com/your-username/your-repo-name.git)
   cd your-repo-name
