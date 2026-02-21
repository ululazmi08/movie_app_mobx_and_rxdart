# Movie App (MobX & RxDart)

A modern Flutter movie application demonstrating advanced state management, dependency injection, and clean architecture principles.

## 🚀 Features

- **Theming**: Seamless Light and Dark mode switching (System-based or Manual).
- **Localization (l10n)**: Multi-language support (English & Indonesian) using `.arb` files and Build Runner.
- **Search with Debounce**: High-performance search powered by **RxDart**, preventing unnecessary API calls.
- **Infinite Scroll**: Pagination on Home and Search pages.
- **Persistent Bookmarks**: Save your favorite movies locally using `LocalStorage`.
- **Global Image Handling**: Custom network image widget with error and loading states.
- **Modern Routing**: Clean navigation structure using **GoRouter** with Enum-based paths.

## 🛠️ Tech Stack & Architecture

- **State Management**: [MobX](https://pub.dev/packages/mobx) for reactive and transparent state management.
- **Reactive Extensions**: [RxDart](https://pub.dev/packages/rxdart) for handling search streams and debouncing.
- **Dependency Injection**: [GetIt](https://pub.dev/packages/get_it) & [Injectable](https://pub.dev/packages/injectable) for modular and testable code.
- **Networking**: [Dio](https://pub.dev/packages/dio) & [Retrofit](https://pub.dev/packages/retrofit) for type-safe API requests.
- **Persistence**: [LocalStorage](https://pub.dev/packages/localstorage) for saving user preferences and bookmarks.
- **Routing**: [GoRouter](https://pub.dev/packages/go_router) for declarative routing.
- **Functional Programming**: [fpdart](https://pub.dev/packages/fpdart) for handling API results with `Either`.

## 📦 Project Structure

```
lib/
├── core/            # App-wide configurations
│   ├── injection/   # DI Setup (GetIt/Injectable)
│   ├── l10n/        # Localization files & extension
│   ├── remote/      # API Clients (Retrofit)
│   ├── repository/  # Data repositories
│   └── routes/      # GoRouter configuration
├── models/          # Data models (Freezed/JsonSerializable)
├── pages/           # UI Screens
├── stores/          # MobX Stores (Logic & State)
└── widgets/         # Reusable UI components
```

## ⚙️ Setup & Installation

1. **Clone the repository**
2. **Install dependencies**:
   ```bash
   flutter pub get
   ```
3. **Run Code Generation**:
   Since this project uses MobX, Injectable, and Freezed, you need to run the build runner:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```
4. **Localization**:
   Generate l10n files:
   ```bash
   flutter gen-l10n
   ```
5. **Run the app**:
   ```bash
   flutter run
   ```

---
Built with ❤️ using Flutter.
