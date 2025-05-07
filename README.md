Quote App

A motivational quote application built with Flutter, integrated with Firebase for authentication, Firestore for data storage, and designed for web deployment in Chrome. The app allows users to browse quotes categorized by themes like Motivation, Study, and more, with features to mark quotes as read, bookmark them, and rate them.

Features





User authentication (login/register) using Firebase Auth.



Display of categorized quotes from Firestore.



Interactive features: mark as read, bookmark, and rate quotes.



Responsive design optimized for web (Chrome).



Search functionality (placeholder implemented).



Help screen with usage instructions.

Prerequisites





Flutter SDK (version 3.19.0 or later recommended).



Firebase account and project setup.



Node.js and npm (for Firebase CLI, if deploying).



Internet connection for Firestore and authentication.

Installation

1. Clone the Repository

git clone https://github.com/your-username/quote-app.git
cd quote-app

2. Set Up Flutter





Ensure Flutter is installed and configured:

flutter --version
flutter doctor



If needed, install Flutter: Flutter Installation Guide.

3. Configure Firebase





Create a Firebase project at Firebase Console.



Enable Firestore and Authentication in the Firebase Console.



Add the following collections manually via the Firestore Database:





categories: Documents with field name (e.g., { name: "Motivation" } for 12 categories: Motivation, Study, Workout, Tough Times, Inspiration, Success, Happiness, Wisdom, Love, Friendship, Courage, Dreams).



quotes: Documents with fields content, author, and category (e.g., { content: "Believe you can and you're halfway there.", author: "Theodore Roosevelt", category: "Motivation" } for 13 sample quotes).



Download google-services.json (Android) and GoogleService-Info.plist (iOS) if targeting those platforms, or use firebase_options.dart for web.



Update lib/firebase_options.dart with your Firebase configuration:

static const FirebaseOptions web = FirebaseOptions(
  apiKey: 'YOUR_API_KEY',
  appId: 'YOUR_APP_ID',
  messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
  projectId: 'quote-app-abdo',
  authDomain: 'quote-app-abdo.firebaseapp.com',
  storageBucket: 'quote-app-abdo.appspot.com',
);

4. Install Dependencies

flutter pub get

5. Run the App





Start the app in Chrome:

flutter run -d chrome



Log in with a test user (e.g., register with test@example.com and a password).

Usage





Home Screen: View categorized quote buttons. Click a category to see a quote.



Quote Display: View the quote, author, and options to mark as read, bookmark, or rate (1-5).



Search: Use the search bar to filter quotes (feature to be expanded).



Help: Access the help screen via the app bar for usage tips.



Logout: Sign out from the app bar.

Deployment





Build for web:

flutter build web --release



Deploy to Firebase Hosting:





Install Firebase CLI: npm install -g firebase-tools



Log in: firebase login



Initialize Firebase: firebase init (select Hosting)



Deploy: firebase deploy



Access at the provided URL (e.g., https://quote-app-abdo.web.app).

Contributing





Fork the repository.



Create a feature branch: git checkout -b feature-name.



Commit changes: git commit -m "Description".



Push to the branch: git push origin feature-name.



Open a pull request.

Issues





Report bugs or suggest features by opening an issue on GitHub.



Include details like error logs or screenshots for debugging.

License

This project is licensed under the MIT License - see the LICENSE.md file for details.

Acknowledgments





Built with Flutter.



Powered by Firebase.



Inspired by motivational quote collections online.
