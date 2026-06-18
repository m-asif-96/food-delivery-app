A full-featured, production-ready **Food Delivery Mobile Application** built with **Flutter**, following clean architecture principles using the **Stacked** framework. Designed with a professional, scalable codebase that demonstrates real-world app development practices.
---
## 📱 Screenshots
> The app features a clean, modern UI with an orange brand palette, shimmer loading, and smooth navigation.
---
## ✨ Features
### 🔐 Authentication
- Google Sign-In via Firebase Authentication
- Persistent session management
- Graceful sign-in error handling
### 🏠 Home Screen
- Browse all food items in a responsive grid
- Filter products by **category** (All, Pizza, Burger, Drinks, Dessert, etc.)
- In-memory product caching to avoid redundant Firestore reads
- Pull-to-refresh with error retry
### 🛒 Shopping Cart
- Add / remove items with quantity controls
- Real-time cart badge counter on the navigation bar
- Persistent cart state across screens
### 💳 Payment (Stripe)
- Integrated **Stripe Payment Sheet** for secure checkout
- Full error handling for failed or cancelled payments
- On successful payment, order is created in Firestore automatically
### 📦 Order History
- Real-time order list using Firestore Streams
- Color-coded status badges (Pending, Preparing, Out for Delivery, Delivered)
### 🗺️ Order Tracking
- Live order status tracking via Firestore Stream
- Visual step-by-step tracking timeline
### 🔔 Notifications
- Firebase Cloud Messaging (FCM) integration
- Real-time notification stream from Firestore
- Mark notifications as read
- Badge counter on the nav bar
---
## 🏗️ Architecture
This project follows **Clean Architecture** using the [Stacked](https://pub.dev/packages/stacked) framework.
```
lib/
├── app/
│   ├── app.dart              # Route & dependency registration
│   ├── app.locator.dart      # Auto-generated DI locator
│   └── app.router.dart       # Auto-generated router
│
├── models/
│   ├── product_model.dart    # Product with thumbnailUrl support
│   ├── order_model.dart
│   ├── cart_item_model.dart
│   ├── notification_model.dart
│   └── user_model.dart
│
├── services/
│   ├── auth_service.dart         # Firebase Auth + Google Sign-In
│   ├── product_service.dart      # Firestore products + in-memory cache
│   ├── cart_service.dart         # ValueNotifier-based cart state
│   ├── order_service.dart        # Firestore order CRUD
│   ├── notification_service.dart # FCM + Firestore notifications
│   ├── stripe_service.dart       # Stripe Payment Sheet integration
│   └── firestore_service.dart    # Base Firestore helper
│
└── ui/
    ├── common/
    │   ├── app_colors.dart       # Centralized color constants
    │   └── app_typography.dart   # Centralized text styles
    │
    ├── views/
    │   ├── startup/              # Auth check & routing
    │   ├── login/                # Google Sign-In screen
    │   ├── navigation/           # Bottom navigation shell
    │   ├── home/                 # Product grid + category filter
    │   ├── cart/                 # Cart items + Stripe checkout
    │   ├── orders/               # Order history list
    │   ├── order_tracking/       # Live order status tracking
    │   └── notifications/        # FCM notifications list
    │
    └── widgets/                  # Reusable widgets
        ├── app_network_image.dart  # Cached image + shimmer skeleton
        ├── custom_app_bar.dart
        ├── custom_button.dart
        ├── empty_state.dart
        ├── error_state.dart
        ├── loading_indicator.dart
        ├── order_card.dart
        ├── product_card.dart
        └── status_badge.dart
```
### Pattern
|
 Layer 
|
 Technology 
|
|
---
|
---
|
|
 State Management 
|
 Stacked (ViewModel + ReactiveViewModel) 
|
|
 Dependency Injection 
|
`get_it`
 via Stacked locator 
|
|
 Navigation 
|
 Stacked Router (code-gen) 
|
|
 Reactive Data 
|
`StreamViewModel`
 for real-time Firestore 
|
---
## 🛠️ Tech Stack
|
 Category 
|
 Technology 
|
|
---
|
---
|
|
 Framework 
|
 Flutter 3.x 
|
|
 Language 
|
 Dart 
|
|
 Architecture 
|
 Stacked (MVVM + Clean Architecture) 
|
|
 Backend 
|
 Firebase (Auth, Firestore, Cloud Messaging) 
|
|
 Payments 
|
 Stripe (flutter_stripe) 
|
|
 Image Loading 
|
 CachedNetworkImage + Shimmer 
|
|
 Responsive UI 
|
 flutter_screenutil 
|
|
 Navigation 
|
 Stacked Router 
|
|
 DI 
|
 get_it (via Stacked) 
|
|
 Environment 
|
 flutter_dotenv 
|
---
## 🚀 Getting Started
### Prerequisites
- Flutter SDK `^3.9.2`
- Dart SDK `^3.x`
- A Firebase project
- A Stripe account (test mode)
### 1. Clone the Repository
```bash
git clone https://github.com/your-username/food_delivery_app.git
cd food_delivery_app
```
### 2. Install Dependencies
```bash
flutter pub get
```
### 3. Firebase Setup
1. Create a project at [Firebase Console](https://console.firebase.google.com)
2. Enable **Authentication** → Google Sign-In
3. Enable **Cloud Firestore**
4. Enable **Cloud Messaging**
5. Download `google-services.json` (Android) and place it in `android/app/`
6. Run `flutterfire configure` if using FlutterFire CLI
### 4. Environment Variables
Create a `.env` file in the project root:
```env
STRIPE_PUBLISHABLE_KEY=pk_test_your_key_here
STRIPE_SECRET_KEY=sk_test_your_key_here
```
> ⚠️ **Never commit your `.env` file.** It is already listed in `.gitignore`.
### 5. Firestore Data Structure
Seed your `products` collection with documents in this format:
```json
{
  "name": "Pepperoni Pizza",
  "description": "Cheesy pepperoni pizza",
  "price": 15.99,
  "imageUrl": "https://...",
  "thumbnailUrl": "https://..._200x200",
  "category": "Pizza"
}
```
> 💡 **Tip:** Use the [Firebase Resize Images](https://firebase.google.com/products/extensions/firebase-resize-images) extension to auto-generate `thumbnailUrl` values.
### 6. Run the App
```bash
flutter run
```
### 7. Regenerate Stacked Code (if needed)
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```
---
## 🎨 Design System
### Colors — `app_colors.dart`
|
 Token 
|
 Value 
|
 Usage 
|
|
---
|
---
|
---
|
|
`AppColors.primary`
|
`Colors.orange`
|
 Brand, buttons, accents 
|
|
`AppColors.background`
|
`#FAFAFA`
|
 Screen backgrounds 
|
|
`AppColors.textPrimary`
|
`Colors.black87`
|
 Headings, body text 
|
|
`AppColors.textSecondary`
|
`Colors.black54`
|
 Subtitles, captions 
|
|
`AppColors.error`
|
`Colors.red`
|
 Error states 
|
### Typography — `app_typography.dart`
|
 Token 
|
 Size 
|
 Weight 
|
 Usage 
|
|
---
|
---
|
---
|
---
|
|
`AppTypography.h1`
|
`32.sp`
|
 Bold 
|
 Page titles 
|
|
`AppTypography.h3`
|
`24.sp`
|
 Bold 
|
 Section headers 
|
|
`AppTypography.bodyLarge`
|
`16.sp`
|
 Normal 
|
 Body text 
|
|
`AppTypography.bodySmall`
|
`12.sp`
|
 Normal 
|
 Captions, timestamps 
|
---
## 🔑 Key Implementation Highlights
### ✅ Image Optimization
- `AppNetworkImage` widget combines `CachedNetworkImage` + `shimmer` for skeleton loading
- `thumbnailUrl` served in grids; full `imageUrl` reserved for detail screens
- Graceful fallback icon if image fails to load
### ✅ Error Handling
- All ViewModels use `try/catch` + Stacked's `setError()` / `hasError`
- `ErrorState` widget with retry button shown on all data screens
- Inline error messages in Cart and Login for field-level feedback
### ✅ Real-time Data
- Orders, Order Tracking, and Notifications use `StreamViewModel` — data updates live without any manual refresh
### ✅ Caching Strategy
- Products are cached in-memory after first load; re-fetched only on `forceRefresh`
- Images are disk-cached by `CachedNetworkImage` across app sessions
---
## 📦 Key Packages
```yaml
stacked: ^3.5.0                  # MVVM architecture
stacked_services: ^1.6.0         # Navigation & dialogs
firebase_core: ^4.x              # Firebase core
firebase_auth: ^6.x              # Authentication
cloud_firestore: ^6.x            # Database
firebase_messaging: ^16.x        # Push notifications
google_sign_in: ^7.x             # Google OAuth
flutter_stripe: ^13.x            # Stripe payments
cached_network_image: ^3.x       # Image caching
shimmer: ^3.x                    # Skeleton loading
flutter_screenutil: ^5.x         # Responsive sizing
flutter_dotenv: ^6.x             # Environment variables
```
---
## 📄 License
This project is for educational and portfolio purposes.
---
## 👨‍💻 Author
**Muhammad Asif**  
Flutter Developer  
[GitHub](https://github.com/m-asif-96) • [LinkedIn](https://linkedin.com/in/your-profile)
