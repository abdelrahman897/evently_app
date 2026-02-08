# evently_app

Evently App 📅Evently is a comprehensive event management and discovery application built using Flutter and Firebase. It allows users to create, explore, and join various events with full support for personalization through themes and multi-language support.🚀 Key FeaturesRobust Authentication System: Supports secure Email/Password registration and login with Email Verification logic.Google Sign-In Integration: Quick access using Google accounts via google_sign_in.Dynamic Theming: Seamless switching between Light Mode and Dark Mode, persisted across the app using the Provider pattern.Internationalization (i18n): Multi-language support (Arabic & English) using Flutter's localization (L10n).Interactive Onboarding: A smooth introduction for new users featuring an onboarding walkthrough.Profile Management: A dedicated profile screen to manage settings, theme preferences, and secure logout.🛠 Tech StackFramework: Flutter (Dart)Backend: FirebaseAuthentication: For user identity and email verification.Cloud Firestore: For storing and syncing event data in real-time.State Management: Provider for managing app settings and theme states.Local Storage: Shared Preferences to store user preferences like onboarding status.UI Utilities: * flutter_easyloading for global loading indicators.flutter_bounceable for interactive button animations.flutter_svg for high-quality vector icons.📁 Project StructurePlaintextlib/
├── core/                # Reusable components (Theme, Routes, Widgets, Utils)
│   ├── theme/           # App color palettes and typography
│   ├── widget/          # Custom reusable UI components
│   └── utils/           # Helper classes and Firebase utilities
├── modules/             # Feature-based modules
│   ├── home/            # Main layout and Profile screens
│   ├── login/           # Authentication UI
│   └── onboarding/      # Walkthrough screens
├── providers/           # AppSettingsProvider for global state
└── main.dart            # Entry point of the application
⚙️ Getting StartedPrerequisitesFlutter SDK installed.A Firebase project created in the Firebase Console.InstallationClone the repository:Bashgit clone https://github.com/abdelrahman897/evently_app.git
Install dependencies:Bashflutter pub get
Firebase Setup:Add your google-services.json (Android) and GoogleService-Info.plist (iOS).Enable Email/Password and Google providers in the Firebase Authentication tab.Run the app:Bashflutter run
📸 ScreenshotsOnboarding WalkthroughSign In ScreenProfile (Dark Mode)🤝 ContributionContributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are greatly appreciated.Fork the Project.Create your Feature Branch (git checkout -b feature/AmazingFeature).Commit your Changes (git commit -m 'Add some AmazingFeature').Push to the Branch (git push origin feature/AmazingFeature).Open a Pull Request.Developed by: Abdelrahmantter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
