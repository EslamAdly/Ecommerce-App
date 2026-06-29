# Flutter E-Commerce App

## Overview
This is a simple e-commerce mobile application built with Flutter and Firebase. It demonstrates core e-commerce functionalities, including user authentication, product browsing, shopping cart management, favorites list, and user profile management. The app uses Firebase Authentication for user registration/login and Firebase Firestore for real-time data storage and retrieval.

## Features
- **Email/Password Authentication**: Secure user registration and login using Firebase Authentication.
- **Product Catalog**: Browse a list of products with options to add items to the cart or favorites.
- **Shopping Cart**: Add, remove, and manage items in the cart for purchase.
- **Favorites List**: Save preferred products for quick access.
- **User Profile**: View and edit basic user information.
- **Home Screen**: A welcoming dashboard with quick access to app features.

## Prerequisites
- **Flutter SDK**: Version 3.0.0 or higher.
- **Dart**: Version 2.17.0 or higher.
- **Firebase Account**: Set up a Firebase project with Authentication and Firestore enabled.
- **IDE**: Android Studio, VS Code, or any IDE with Flutter support.
- **Emulator/Device**: For testing the app on iOS or Android.

## Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/EslamAdly/Ecommerce-App.git
   ```
2. Navigate to the project directory:
   ```bash
   cd flutter-ecommerce-app
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Set up Firebase:
   - Create a Firebase project in the [Firebase Console](https://console.firebase.google.com/).
   - Enable **Email/Password Authentication** in the Authentication section.
   - Enable **Firestore Database** and set up the database rules.
   - Download the `google-services.json` (for Android) or `GoogleService-Info.plist` (for iOS) and place it in the appropriate directory:
     - Android: `android/app/`
     - iOS: `ios/Runner/`
   - Add Firebase dependencies to `pubspec.yaml`:
     ```yaml
     firebase_core: ^2.4.0
     firebase_auth: ^4.2.0
     cloud_firestore: ^4.3.0
     ```
5. Run the app:
   ```bash
   flutter run
   ```

## Project Structure
```
flutter-ecommerce-app/
├── android/               # Android-specific files
├── ios/                   # iOS-specific files
├── lib/                   # Main Flutter source code
│   ├── models/            # Data models (e.g., Product, User)
│   ├── screens/           # UI screens (Home, Product Catalog, Cart, Favorites, Profile)
│   ├── services/          # Firebase and other service integrations
│   ├── widgets/           # Reusable UI components
│   └── main.dart          # App entry point
├── assets/                # Images, fonts, and other static assets
├── pubspec.yaml           # Flutter dependencies and configuration
└── README.md              # This file
```

## Usage
1. Launch the app on an emulator or physical device.
2. Register a new account or log in using email and password.
3. Browse the product catalog, add items to the cart or favorites.
4. View and manage items in the shopping cart.
5. Save favorite products for quick access.
6. Update user information in the profile section.
7. Navigate back to the home screen for an overview of app features.

## Technologies Used
- **Flutter**: For cross-platform mobile app development.
- **Dart**: Programming language for Flutter.
- **Firebase Authentication**: For secure user registration and login.
- **Firebase Firestore**: For real-time data storage and retrieval.
- (Optional) Add any additional packages used, such as `provider` for state management.

## Contributing
1. Fork the repository.
2. Create a new branch for your feature or bug fix:
   ```bash
   git checkout -b feature-name
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add feature or fix description"
   ```
4. Push to your branch:
   ```bash
   git push origin feature-name
   ```
5. Open a pull request with a detailed description of your changes.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact
For questions or feedback, please contact [your-email@example.com](mailto:your-email@example.com).
