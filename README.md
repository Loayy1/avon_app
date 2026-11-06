<div align="center">

  <img src="assets/images/app_icon.png" alt="Avon Cosmetics Logo" width="110" style="border-radius: 22px; box-shadow: 0 8px 24px rgba(215, 93, 114, 0.25);" />

  # ✨ Avon Cosmetics App
  ### Modern E-Commerce Mobile Application

  <p align="center">
    <strong>A high-performance, enterprise-grade cosmetics shopping application built with Flutter & Dart, following Clean Architecture principles and powered by BLoC/Cubit state management.</strong>
  </p>

  <!-- Badges -->
  <p align="center">
    <a href="https://flutter.dev"><img src="https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter"></a>
    <a href="https://dart.dev"><img src="https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart"></a>
    <a href="https://bloclibrary.dev"><img src="https://img.shields.io/badge/State_Management-BLoC%20%2F%20Cubit-8A2BE2?style=for-the-badge&logo=bloc&logoColor=white" alt="BLoC"></a>
    <a href="https://pub.dev/packages/dio"><img src="https://img.shields.io/badge/Networking-Dio%20REST%20Client-2C3E50?style=for-the-badge&logo=fastapi&logoColor=white" alt="Dio"></a>
    <a href="https://github.com/Loayy1/Avon_app/releases"><img src="https://img.shields.io/badge/Platform-Android-3DDC84?style=for-the-badge&logo=android&logoColor=white" alt="Android"></a>
    <a href="#"><img src="https://img.shields.io/badge/Architecture-Clean%20Architecture-D75D72?style=for-the-badge" alt="Clean Arch"></a>
  </p>

  <!-- CTA Buttons -->
  <p align="center">
    <a href="https://github.com/Loayy1/Avon_app/releases/download/v1.0.0/app-release.apk">
      <img src="https://img.shields.io/badge/📲_Download_APK-v1.0.0_(52MB)-2ea44f?style=for-the-badge&logo=android&logoColor=white" alt="Download APK" height="40"/>
    </a>
    &nbsp;&nbsp;
    <a href="https://www.linkedin.com/in/loay-mohamed-621b7a33a">
      <img src="https://img.shields.io/badge/Connect_on-LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn" height="40"/>
    </a>
  </p>

</div>

---

## 📑 Table of Contents

- [📱 APK Release & Quick Download](#-apk-release--quick-download)
- [📸 Application Showcase](#-application-showcase)
- [🌟 Overview & Design Philosophy](#-overview--design-philosophy)
- [✨ Core Features](#-core-features)
- [🏗️ Engineering & Clean Architecture](#️-engineering--clean-architecture)
- [🛠️ Tech Stack & Dependencies](#️-tech-stack--dependencies)
- [👨‍💻 Author & Connect](#-author--connect)

---

## 📱 APK Release & Quick Download

A production-ready release build is pre-compiled, optimized with R8 code shrinking, and ready for installation on any physical Android device.

<div align="center">

| Specification | Technical Detail |
| :--- | :--- |
| **Package Name** | `com.example.cosmetics_app` |
| **Version** | `v1.0.0` (Build `1`) |
| **Artifact Type** | Android Standalone Package (`.apk`) |
| **Build Optimization** | Release Mode (Tree-shaken, Minified, Optimized R8) |
| **Binary Size** | `~52.8 MB` |
| **Compatibility** | Android 5.0 (API Level 21) &rarr; Android 14 (API Level 34) |

</div>

<p align="center">
  <a href="https://github.com/Loayy1/Avon_app/releases/download/v1.0.0/app-release.apk">
    <img src="https://img.shields.io/badge/Direct_Download-app--release.apk-238636?style=for-the-badge&logo=googleplay&logoColor=white" alt="Direct APK Download"/>
  </a>
  &nbsp;&nbsp;
  <a href="https://github.com/Loayy1/Avon_app/releases">
    <img src="https://img.shields.io/badge/GitHub-All_Releases-181717?style=for-the-badge&logo=github&logoColor=white" alt="GitHub Releases"/>
  </a>
</p>

> [!TIP]
> **Android Direct Install:** If installing outside the Play Store, ensure that **"Install Unknown Apps"** is enabled in your Android Security settings for your browser or file manager.

---

## 📸 Application Showcase

<div align="center">

| 💎 **Splash & Brand Identity** | 🔐 **Authentication & Security** | 🛍️ **Home & Dynamic Catalog** | 🛒 **Smart Cart & Invoice** |
| :---: | :---: | :---: | :---: |
| <img src="assets/screenshots/splash.jpg" width="225" style="border-radius: 16px; border: 1px solid #E2E8F0; box-shadow: 0 10px 25px rgba(0,0,0,0.12);" alt="Splash Screen"/> | <img src="assets/screenshots/login.jpg" width="225" style="border-radius: 16px; border: 1px solid #E2E8F0; box-shadow: 0 10px 25px rgba(0,0,0,0.12);" alt="Login Screen"/> | <img src="assets/screenshots/home.jpg" width="225" style="border-radius: 16px; border: 1px solid #E2E8F0; box-shadow: 0 10px 25px rgba(0,0,0,0.12);" alt="Home Screen"/> | <img src="assets/screenshots/cart.jpg" width="225" style="border-radius: 16px; border: 1px solid #E2E8F0; box-shadow: 0 10px 25px rgba(0,0,0,0.12);" alt="Cart Screen"/> |
| *Smooth branding entrypoint* | *Phone number & password validation* | *Promotions, discounts & product cards* | *Real-time totals, quantities & checkout* |

</div>

---

## 🌟 Overview & Design Philosophy

**Avon Cosmetics App** is crafted to provide a seamless, modern shopping experience for cosmetics and beauty products. Engineered with scalability, clean code practices, and strict architectural boundaries in mind:

- 🎯 **Domain-Driven Clarity**: Zero business logic inside presentation widgets.
- ⚡ **Zero-Latency Feel**: Employs optimistic UI updates on cart interactions, giving immediate visual feedback before API responses resolve.
- 🛡️ **Defensive Error Handling**: Comprehensive failure management with custom Dio interceptors, auto token loading, and graceful error states.
- 🎨 **Pixel-Perfect UI**: Fully responsive layouts built with custom design tokens, vector typography, and smooth transitions.

---

## ✨ Core Features

### 🔐 1. Authentication & Session Security
- **Dynamic Registration & Sign-in**: Validates international phone formats, passwords, and user information.
- **OTP Verification Flow**: 4-digit verification code mechanism with resend countdown timers.
- **Password Lifecycle**: Complete self-service Forgot Password and Reset Password flows.
- **JWT Session Persistence**: Automatic token injection into HTTP headers and secure local caching via `SharedPreferences`.

### 🛍️ 2. Dynamic Catalog & Discovery
- **Marketing Sliders & Carousels**: Cloud-driven hero banners with promotional codes and seasonal deals.
- **Categorized Browsing**: Instant navigation through cosmetics, skincare, and fragrance collections.
- **Rich Product Cards**: High-res product images, real-time pricing in EGP, inventory status, and quick add-to-cart actions.

### 🛒 3. High-Performance Shopping Cart
- **Optimistic State Updates**: Items increment, decrement, and delete immediately on screen with background synchronization.
- **Isolated Widget Rebuilds**: Uses granular Bloc listeners (`buildWhen`) so tapping "Add to Cart" animates only that specific button without re-rendering the whole page.
- **Automated Price Computation**: Real-time evaluation of:
  $$\text{Total} = \text{Subtotal} + \text{Shipping} + \text{Taxes} - \text{Discounts}$$

### 💳 4. Checkout & Payment Summary
- **Detailed Invoice Breakdown**: Itemized pricing, delivery calculation, and subtotal review.
- **Payment Method Diversity**: Built-in support for Meeza debit cards, digital wallets, and Cash on Delivery.

### 👤 5. User Profile & Settings
- Personal profile viewer with user avatar and account details.
- Order history tracking and preferences management.
- Secure session sign-out with cache cleanup.

---

## 🏗️ Engineering & Clean Architecture

The project strictly adheres to **Feature-First Clean Architecture**, ensuring strict separation of concerns, testability, and modularity:

```
                      ┌────────────────────────────────────────┐
                      │          PRESENTATION LAYER            │
                      │   Widgets • Screens • Cubit • States   │
                      └───────────────────┬────────────────────┘
                                          │ depends on
                                          ▼
                      ┌────────────────────────────────────────┐
                      │             DOMAIN LAYER               │
                      │    Repository Interfaces • Entities    │
                      └───────────────────▲────────────────────┘
                                          │ implements
                                          │
                      ┌───────────────────┴────────────────────┐
                      │              DATA LAYER                │
                      │ Data Sources • Models • Repositories   │
                      └────────────────────────────────────────┘
```

### 📂 Directory Organization:

```
lib/
├── core/                                # Enterprise Core Infrastructure
│   ├── error/                           # Custom failures & exceptions
│   ├── logic/                           # DioHelper, Global Navigation Key & Helpers
│   ├── network/                         # Remote Endpoints & Interceptor Configs
│   └── storage/                         # CacheHelper (SharedPreferences wrapper)
│
└── features/                            # Self-contained Feature Modules
    ├── auth/                            # Login, Register, OTP & Passwords
    │   ├── data/                        # Models, DataSources & Repo Implementations
    │   ├── domain/                      # Abstract Repository Contracts
    │   └── presentation/                # Cubits, States & Views
    ├── cart/                            # Shopping Cart & Invoice Engine
    ├── categories/                      # Product Categorization
    ├── home/                            # Marketing Sliders & Product Feed
    ├── main/                            # Main Navigation Coordinator
    └── profile/                         # User Profile & Account Data
```

### 🧠 Clean Architecture Benefits Realized:
- **Independent of Frameworks**: Domain logic doesn't depend on Flutter UI libraries.
- **Testable in Isolation**: Repositories and Cubits can be unit-tested without mocking the UI.
- **Interchangeable Data Sources**: Swapping the REST API with a local database or GraphQL requires zero changes to the UI layer.

---

## 🛠️ Tech Stack & Dependencies

| Category | Tool / Package | Role & Responsibility |
| :--- | :--- | :--- |
| **Language** | [Dart 3.x](https://dart.dev) | Modern, soundly typed language with pattern matching & records |
| **Framework** | [Flutter 3.x](https://flutter.dev) | High-performance compiled native UI toolkit |
| **State Management** | [flutter_bloc / Cubit](https://pub.dev/packages/flutter_bloc) | Predictable, unidirectional state streams with state immutability |
| **Networking** | [dio](https://pub.dev/packages/dio) | Robust HTTP client with interceptors, timeouts & token headers |
| **Local Storage** | [shared_preferences](https://pub.dev/packages/shared_preferences) | Fast asynchronous local persistence for session tokens |
| **Vector Graphics** | [flutter_svg](https://pub.dev/packages/flutter_svg) | Scalable, lossless SVG vector icon rendering |
| **Asset Tooling** | [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) | Automated multi-density app icon generation for Android & iOS |

---

## 👨‍💻 Author & Connect

<div align="center">

### **Loay Mohamed Nader**
**Flutter Mobile Application Engineer**

<p align="center">
  <a href="https://www.linkedin.com/in/loay-mohamed-621b7a33a">
    <img src="https://img.shields.io/badge/LinkedIn-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn"/>
  </a>
  &nbsp;
  <a href="https://github.com/Loayy1">
    <img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white" alt="GitHub"/>
  </a>
</p>

<sub>Passionate about crafting polished, resilient mobile experiences with Clean Code & Pragmatic Architecture.</sub>

</div>

---

<div align="center">
  <sub>⭐️ If you like this project or find the Clean Architecture implementation helpful, please give it a star! ⭐️</sub>
</div>
