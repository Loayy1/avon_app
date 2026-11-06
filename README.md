<div align="center">

  <img src="assets/images/app_icon.png" alt="Avon Cosmetics Logo" width="120" style="border-radius: 24px; box-shadow: 0 4px 12px rgba(0,0,0,0.15);" />

  # 💄 Avon Cosmetics — Shopping Mobile App

  <p align="center">
    <strong>A modern, production-grade cross-platform e-commerce application built with Flutter & Dart, powered by Clean Architecture and BLoC/Cubit.</strong>
  </p>

  <!-- Badges -->
  <p align="center">
    <a href="https://flutter.dev"><img src="https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter"></a>
    <a href="https://dart.dev"><img src="https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart"></a>
    <a href="https://bloclibrary.dev"><img src="https://img.shields.io/badge/State_Management-Cubit_%2F_BLoC-blueviolet?style=for-the-badge" alt="BLoC"></a>
    <a href="https://pub.dev/packages/dio"><img src="https://img.shields.io/badge/Networking-Dio-orange?style=for-the-badge" alt="Dio"></a>
    <a href="https://github.com/Loayy1/Avon_app/releases"><img src="https://img.shields.io/badge/Platform-Android-3DDC84?style=for-the-badge&logo=android&logoColor=white" alt="Android"></a>
    <a href="https://github.com/Loayy1/Avon_app/blob/main/LICENSE"><img src="https://img.shields.io/badge/License-MIT-green?style=for-the-badge" alt="License"></a>
  </p>

  <!-- APK Download CTA -->
  <p align="center">
    <a href="https://github.com/Loayy1/Avon_app/releases/latest">
      <img src="https://img.shields.io/badge/📱_Download-Latest_APK_(v1.0.0)-2ea44f?style=for-the-badge&logo=android&logoColor=white" alt="Download APK" height="38"/>
    </a>
  </p>

</div>

---

## 📑 Table of Contents

- [📱 APK Download & Installation](#-apk-download--installation)
- [✨ Key Features](#-key-features)
- [🏗️ Architectural Overview (Clean Architecture)](#️-architectural-overview-clean-architecture)
- [🛠️ Tech Stack & Libraries](#️-tech-stack--libraries)
- [📂 Project Structure](#-project-structure)
- [🔌 REST API Integration](#-rest-api-integration)
- [🚀 Getting Started](#-getting-started)
- [👨‍💻 Author & Connect](#-author--connect)

---

## 📱 APK Download & Installation

The production release APK is compiled and ready for testing on Android devices.

| Specification | Details |
| :--- | :--- |
| **App Name** | Avon Cosmetics |
| **Current Version** | `v1.0.0` (Build `1`) |
| **Package Format** | Android Application Package (`.apk`) |
| **File Size** | `~52.8 MB` |
| **Min Android SDK** | `API 21` (Android 5.0 Lollipop or higher) |
| **Build Configuration** | Release Mode (R8 tree-shaken & minified) |

### 📥 Download Links:
* 🚀 **[Download Latest APK directly (v1.0.0)](https://github.com/Loayy1/Avon_app/releases/download/v1.0.0/app-release.apk)**
* 📦 **[View All Releases on GitHub](https://github.com/Loayy1/Avon_app/releases)**
* 📁 **Local Build Artifact**: `build/app/outputs/flutter-apk/app-release.apk`

> **Note on Installation:**
> When installing the APK directly on Android, make sure to enable **"Install unknown apps"** in your phone settings for your browser or file manager.

---

## ✨ Key Features

### 🔐 1. Authentication & Security
- **User Registration**: Real-time validation for phone numbers, email, and user credentials.
- **OTP Verification**: Secure 4/6-digit SMS/email OTP verification flow with resend countdown timer.
- **Login & Token Management**: JWT-based session handling with automatic Bearer token injection and token refresh.
- **Password Recovery**: Complete forgot password and password reset workflows.

### 🛍️ 2. Catalog & Discovery
- **Dynamic Banners & Sliders**: Remote marketing carousel with smooth paging.
- **Categorized Browsing**: Fast category filtering with real-time API queries.
- **Product Details**: High-resolution image galleries, description, dynamic pricing, and stock status.

### 🛒 3. Advanced Shopping Cart
- **Optimistic UI Updates**: Immediate response when adding, updating quantity, or removing items for zero UI lag.
- **Isolated Rebuilds**: Add-to-cart actions isolate button state animations without triggering whole-screen redraws.
- **Real-time Price & Invoice Calculations**: Automatic calculation of **Subtotal**, **Tax**, **Shipping**, and **Total Amount**.

### 💳 4. Checkout & Orders
- **Order Review**: Itemized breakdown with dynamic fee calculations.
- **Multiple Payment Methods**: Support for cards (Meeza), digital wallets, and cash on delivery.

### 👤 5. User Profile & Settings
- **Profile Management**: View and edit personal info, delivery address, and account settings.
- **Order History**: Track active and past cosmetics orders.
- **Session Control**: Clean logout with local credential purging.

---

## 🏗️ Architectural Overview (Clean Architecture)

The codebase strictly adheres to **Feature-First Pragmatic Clean Architecture**, separating business logic, domain contracts, and presentation components:

```
lib/
├── core/                        # Global & Shared Infrastructure
│   ├── error/                   # Failures & Exception types
│   ├── logic/                   # Network helper (DioHelper) & utilities
│   ├── network/                 # API Endpoints & interceptors
│   └── storage/                 # Local Cache / SharedPreferences
│
└── features/                    # Feature Modules
    ├── auth/                    # Login, Register, OTP, Password Reset
    ├── cart/                    # Cart items, Quantity controls & Invoice
    ├── categories/              # Category browsing & filters
    ├── home/                    # Banners, Top picks, Discounts
    ├── main/                    # Root bottom navigation coordinator
    └── profile/                 # User data, Orders, Settings
```

### 🧩 Layer Breakdown per Feature:

```
feature/
├── data/
│   ├── datasources/             # Remote & Local API data providers (Dio)
│   ├── models/                  # JSON serialization (fromJson / toJson)
│   └── repositories/            # Repository implementation (data transformation)
├── domain/
│   └── repositories/            # Abstract contracts (pure Dart interfaces)
└── presentation/
    ├── cubit/                   # BLoC / Cubit state managers
    ├── states/                  # Distinct immutable state classes
    └── views/                   # UI Screens & atomic widgets
```

---

## 🛠️ Tech Stack & Libraries

| Dependency | Purpose |
| :--- | :--- |
| **[Flutter](https://flutter.dev)** | UI toolkit for cross-platform native compilation |
| **[Dart](https://dart.dev)** | Modern client-optimized programming language |
| **[flutter_bloc](https://pub.dev/packages/flutter_bloc)** | Predictable state management with separation of UI & business logic |
| **[dio](https://pub.dev/packages/dio)** | Powerful HTTP networking client with interceptors and token headers |
| **[shared_preferences](https://pub.dev/packages/shared_preferences)** | Persistent key-value storage for JWT tokens and user preferences |
| **[flutter_svg](https://pub.dev/packages/flutter_svg)** | Crisp vector icon rendering across all screen densities |
| **[flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons)** | Automated generation of native app launcher icons |

---

## 🔌 REST API Integration

The app connects to the official backend via `DioHelper` configured with base URL `https://cosmatics.growfet.com`:

| Domain | Endpoints |
| :--- | :--- |
| **Auth** | `/api/Auth/register`<br>`/api/Auth/verify-otp`<br>`/api/Auth/resend-otp`<br>`/api/Auth/login`<br>`/api/Auth/forgot-password`<br>`/api/Auth/reset-password`<br>`/api/Auth/profile`<br>`/api/Auth/refresh-token` |
| **Catalog** | `/api/Products`<br>`/api/Categories`<br>`/api/Sliders`<br>`/api/Countries` |
| **Cart** | `/api/Cart`<br>`/api/Cart/add`<br>`/api/Cart/update`<br>`/api/Cart/remove` |

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (`^3.12.0` or higher)
- [Dart SDK](https://dart.dev/get-dart)
- Android Studio or VS Code with Flutter extensions installed
- Connected physical device or Android Emulator

### Installation & Run

1. **Clone the repository:**
   ```bash
   git clone https://github.com/Loayy1/Avon_app.git
   cd Avon_app
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run static analysis to verify code health:**
   ```bash
   dart analyze
   ```

4. **Launch the app in debug mode:**
   ```bash
   flutter run
   ```

5. **Build the production release APK:**
   ```bash
   flutter build apk --release
   ```
   *The generated APK will be located at: `build/app/outputs/flutter-apk/app-release.apk`*

---

## 👨‍💻 Author & Connect

**Loay Mohamed Nader**  
*Flutter Mobile Developer*

- 💼 **LinkedIn**: [loay-mohamed](https://www.linkedin.com/in/loay-mohamed-621b7a33a)
- 🐙 **GitHub**: [@Loayy1](https://github.com/Loayy1)

---

<div align="center">
  <sub>Built with ❤️ using Flutter & Dart. Star ⭐ this repository if you find it helpful!</sub>
</div>
