# Smart-Library-Assistant-and-Management-System

# Gnosis - Library Assistant 📚🤖

*An Android app powered by a voice assistant to help users find books, get recommendations, explore authors or genres, and receive book synopses with minimal compute power.*

---

## 🛠️ Features
- **Book Search**: Quickly find any book in the library.
- **Recommendations**: Personalized suggestions for books based on genre or author.
- **Synopsis on Demand**: Voice-driven synopsis retrieval for any book.
- *Voice Interaction**: Powered by *Snips-NLU** for natural language understanding.
- **Efficient Computing**: Designed to work with low computational overhead.

---

## 📂 Tech Stack
- **Frontend**: Flutter - A powerful framework for building cross-platform mobile apps.
- **Backend**: Django - A robust Python web framework.
- **Voice Processing**: Snips-NLU - Natural Language Understanding library.
- **Database**: PostgreSQL - A powerful and open-source relational database.

---

## 🎯 Purpose
This project was developed as part of a *College Minor Project* to enhance library interaction through a user-friendly Android application.

---

## 🛠️ Installation & Setup

### Backend (Django)
1. Clone this repository
   
2. Create and activate a virtual environment:
   bash
   python3 -m venv venv
   source venv/bin/activate   # For Windows: venv\Scripts\activate
   
3. Install dependencies:
   bash
   pip install -r requirements.txt
   
4. Set up the database:
   bash
   python manage.py makemigrations
   python manage.py migrate
   
5. Run the development server:
   bash
   python manage.py runserver
   

### Frontend (Flutter)
1. Navigate to the Flutter project directory:
   bash
   cd ../gnosis
   
2. Install dependencies:
   bash
   flutter pub get
   
3. Connect a device or emulator and run the app:
   bash
   flutter run
   

---

## 📷 Screenshots
Add some screenshots or GIFs of your app here to demonstrate its features.

---

## 🚀 Future Improvements
- Integration with more advanced NLP models for deeper understanding.
- Cloud deployment for backend scalability.
- Improved recommendation algorithms.

---

## 🙌 Contributing
Contributions are welcome! Feel free to fork the repo, create a new branch, and submit a pull request.

---

## 💡 Acknowledgments
- *Snips-NLU* for the fantastic NLP framework.
- *Flutter* and *Django* communities for their support and documentation.

---
