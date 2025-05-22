# 🏋️‍♂️ Three‑Screen Workout Tracker

A mobile mini-challenge app built using Flutter and Firebase that allows users to log in, view workouts, run timed sessions, and track their progress through a local history log.

## 🔗 Live Demo

📱 **Try it on Appetize:** [https://appetize.io/app/b_efluuwdhz32h3rsm4kx6cvqxki](https://appetize.io/app/b_efluuwdhz32h3rsm4kx6cvqxki)  
🔐 **Test Account**
- Email: `test-app@tswt.com`
- Password: `tswt123`

  Screenshots:
  ![Light Mode](https://github.com/user-attachments/assets/7f1032da-2355-4a7e-bd11-e48ceeabc0fb)
  ![Dark Mode](https://github.com/user-attachments/assets/430372c2-5b6f-4b23-958d-cceb05791689)
  ![workout-light](https://github.com/user-attachments/assets/f012b25a-8468-4830-ac5e-a86a0932e399)
  ![workout-dark](https://github.com/user-attachments/assets/49770f17-6b2d-4b83-86c0-8bfcc8040fb5)

---

## ✅ Implemented Features

### 1. Authentication Screen
- Login using **email/password**
- Authentication handled using **Firebase Authentication**
- Credentials securely managed by Firebase; no local storage of passwords

### 2. Home Screen
- Displays a list of **3 hard-coded workouts**
- Clean, responsive UI with intuitive navigation

### 3. Workout Detail Screen
- Shows exercises for selected workout
- **Start** button begins a **simple auto-advancing timer** through exercises

### 4. Workout History
- Logs completed workouts locally
- Renders a **weekly calendar** view to visualize workout history

---

## 🛠 Tech Stack

| Layer           | Technology Used        |
|-----------------|------------------------|
| Framework       | Flutter                |
| Authentication  | Firebase Authentication|
| State Management| Bloc (flutter_bloc)    |

---

## 🧪 Setup Instructions

1. **Clone the repo**
   ```bash
   git clone https://github.com/your-username/workout-tracker.git
   cd workout-tracker
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Set up Firebase**
   - Create a Firebase project
   - Add Android/iOS apps
   - Enable Email/Password sign-in method
   - Replace the default `google-services.json` or `GoogleService-Info.plist` in `/android/app/` or `/ios/Runner/`

4. **Run the app**
   ```bash
   flutter run
   ```

---

## 🔮 What I'd Do Next

- ✅ Add **voice TTS cues** for exercise instructions  
- ✅ Integrate with **Health Connect** to **import/export workout history from Google Fit / Apple Health**

---

## ⏱ Time Spent

Approximately **8–10 hours** from start to finish including planning, development, and testing.

---

## 📄 License

This project is for educational/demo purposes as part of a mobile mini‑challenge.
