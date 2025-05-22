🏋️‍♂️ Three‑Screen Workout Tracker
A mobile mini-challenge app built using Flutter and Firebase that allows users to log in, view workouts, run timed sessions, and track their progress through a local history log.

🔗 Live Demo
📱 Try it on Appetize: https://appetize.io/app/b_efluuwdhz32h3rsm4kx6cvqxki]\

🔐 Test Account
Email: test-app@tswt.com
Password: tswt123

Screenshots:
![Light Mode](https://github.com/user-attachments/assets/ddbc1f3c-735f-4abe-822e-12e575dcbd7b)
![Dark Mode](https://github.com/user-attachments/assets/3f8aa753-7e32-4947-9b6b-3e68a867d5e0)
![workout-light](https://github.com/user-attachments/assets/3222917c-fc70-4d57-948e-9c15058bffd5)
![workout-dark](https://github.com/user-attachments/assets/b356ea65-fde5-4a3e-81e5-602a970ec47d)


✅ Implemented Features
1. Authentication Screen
Login using email/password

Authentication handled using Firebase Authentication

Credentials securely managed by Firebase; no local storage of passwords

2. Home Screen
Displays a list of 3 hard-coded workouts

Clean, responsive UI with intuitive navigation

3. Workout Detail Screen
Shows exercises for selected workout

Start button begins a simple auto-advancing timer through exercises

4. Workout History
Logs completed workouts locally

Renders a weekly calendar view to visualize workout history

🛠 Tech Stack
Layer	Technology Used
Framework	Flutter
Authentication	Firebase Authentication
State Mgmt	Bloc (flutter_bloc)

🧪 Setup Instructions
Clone the repo

bash
Copy
Edit
git clone https://github.com/your-username/workout-tracker.git
cd workout-tracker
Install dependencies

bash
Copy
Edit
flutter pub get
Set up Firebase

Create a Firebase project

Add Android/iOS apps

Enable Email/Password sign-in method

Replace the default google-services.json or GoogleService-Info.plist in /android/app/ or /ios/Runner/

Run the app

bash
Copy
Edit
flutter run
🔮 What I'd Do Next
✅ Add voice TTS cues for exercise instructions

✅ Integrate with Health Connect to import/export workout history from Google Fit / Apple Health

⏱ Time Spent
Approximately 8–10 hours from start to finish including planning, development, and testing.
