# Code Base

A robust, scalable, and maintainable Flutter application architecture following modern best practices and clean code principles.

## 🚀 Features

- **Clean Architecture**: Well-organized project structure with separation of concerns
- **State Management**: BLoC pattern for predictable and testable state management
- **Dependency Injection**: GetIt for efficient service management
- **Internationalization**: Multi-language support with Easy Localization
- **Responsive Design**: Adaptive UI using Flutter ScreenUtil
- **Navigation**: Declarative routing with Go Router
- **Network Layer**: Dio-based HTTP client with logging and error handling
- **Secure Storage**: Encrypted local storage for sensitive data
- **Theme System**: Dynamic theming with dark/light mode support
- **Error Handling**: Comprehensive error management and user feedback

## 📱 Tech Stack

### Core Dependencies
- **Flutter SDK**: >=3.4.0 <4.0.0 => **3.32.5**
- **State Management**: [flutter_bloc](https://pub.dev/packages/flutter_bloc) ^9.1.1
- **Routing**: [go_router](https://pub.dev/packages/go_router) ^17.0.0
- **Dependency Injection**: [get_it](https://pub.dev/packages/get_it) ^9.2.0
- **Networking**: [dio](https://pub.dev/packages/dio) ^5.9.1
- **Localization**: [easy_localization](https://pub.dev/packages/easy_localization) ^3.0.8

### UI & Utilities
- **Responsive Design**: [flutter_screenutil](https://pub.dev/packages/flutter_screenutil) ^5.9.3
- **Toast Messages**: [fluttertoast](https://pub.dev/packages/fluttertoast) ^9.0.0
- **Pull to Refresh**: [pull_to_refresh](https://pub.dev/packages/pull_to_refresh) ^2.0.0
- **Icons**: [cupertino_icons](https://pub.dev/packages/cupertino_icons) ^1.0.6

### Storage & Data
- **Local Storage**: [shared_preferences](https://pub.dev/packages/shared_preferences) ^2.5.3
- **Secure Storage**: [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage) ^10.0.0
- **Data Models**: [equatable](https://pub.dev/packages/equatable) ^2.0.8, [dartz](https://pub.dev/packages/dartz) ^0.10.1

### Development Tools
- **Code Quality**: [flutter_lints](https://pub.dev/packages/flutter_lints) ^3.0.0
- **Network Logging**: [pretty_dio_logger](https://pub.dev/packages/pretty_dio_logger) ^1.4.0

## 🏗️ Project Structure

```
lib/
├── main.dart                 # App entry point
└── src/
    ├── core/                 # Core utilities and shared components
    │   ├── components/       # Reusable UI components
    │   ├── constants/        # App constants and configurations
    │   ├── extensions/       # Dart extensions
    │   ├── helpers/          # Helper utilities
    │   ├── language/         # Internationalization setup
    │   ├── navigation/       # Routing configuration
    │   ├── network/          # API and network layer
    │   └── utils/            # Utility functions and DI
    └── features/             # Feature modules
        ├── app.dart          # Main app widget
        └── layout/           # Layout components
```

## 🛠️ Architecture Overview

### Clean Architecture Principles
- **Separation of Concerns**: Each layer has distinct responsibilities
- **Dependency Inversion**: High-level modules don't depend on low-level modules
- **Single Responsibility**: Each class has one reason to change
- **Open/Closed Principle**: Open for extension, closed for modification

### Key Components

#### Network Layer
- **Dio Manager**: Centralized HTTP client configuration
- **API Helper**: Simplified API communication
- **Error Handling**: Comprehensive error model and handling
- **Logging**: Request/response logging for debugging

#### State Management
- **BLoC Pattern**: Reactive state management with clear separation
- **Bloc Observer**: Centralized state change monitoring
- **Event-Driven**: Predictable state transitions

#### Navigation
- **Declarative Routing**: Type-safe navigation with Go Router
- **Route Guards**: Protected routes and navigation control
- **Deep Linking**: Support for deep linking and navigation persistence

#### Localization
- **Multi-language Support**: Easy translation management
- **Dynamic Language Switching**: Runtime language changes
- **Fallback Support**: Graceful handling of missing translations

## 🚀 Getting Started

### Prerequisites
- Flutter SDK >=3.4.0
- Dart SDK compatible with Flutter version
- Android Studio / VS Code with Flutter extensions

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd code_base
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Available Commands

```bash
# Run in debug mode
flutter run

# Run in release mode
flutter run --release

# Run tests
flutter test

# Analyze code
flutter analyze

# Format code
dart format .

# Build APK
flutter build apk

# Build iOS
flutter build ios
```

## 📱 Platform Support

- ✅ Android
- ✅ iOS

## 🧪 Testing

The project follows test-driven development principles:

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/widget_test.dart

# Generate test coverage
flutter test --coverage
```

## 📝 Code Quality

### Linting Rules
- **flutter_lints**: Official Flutter linting rules
- **Custom Rules**: Project-specific quality gates
- **Prefer Const**: Immutable widget construction
- **Single Quotes**: Consistent code formatting

### Code Style
- **Effective Dart**: Following official Dart style guide
- **Clean Code**: Readable and maintainable code
- **Documentation**: Comprehensive API documentation

## 🔧 Configuration

### Environment Setup
1. **Translation Files**: Add translations to `assets/translations/`
2. **API Configuration**: Set up base URLs and endpoints
3. **Theme Customization**: Modify app themes in `core/utils/app_theme/`
4. **DI Setup**: Register dependencies in `core/utils/di.dart`

### Build Configuration
- **Development**: Debug mode with logging enabled
- **Production**: Optimized release builds
- **Environment-specific**: Different configs per environment

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Guidelines
- Follow the existing code style
- Write tests for new features
- Update documentation
- Ensure all tests pass

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Contributors and the open-source community
- Package authors for their valuable libraries

## 📞 Support

For support and questions:
- Create an issue on GitHub
- Check the documentation
- Review existing issues and discussions
- Phone 01156750391 || 01500029701 || 01064503827
- Email ahmed.elghareeb1166@gmail.com

---

**Built with ❤️ using Flutter**