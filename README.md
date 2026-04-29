# Weather

Flutter Weather App using OpenWeatherMap API and Bloc Pattern.

## Platforms

| Android | iOS | Web | MacOS | Linux | Windows |
| :-----: | :-: | :-: | :---: | :---: | :-----: |
|   ✔️    | ✔️  | ✔️  |  ✔️   |  ✔️   |   ✔️    |

## Installation

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install)
- [Android Studio](https://developer.android.com/studio) or [Xcode](https://developer.apple.com/xcode/)
- [OpenWeatherMap](https://openweathermap.org/) API key

### Building and running

In order to build and run the project, follow these steps:

1. Clone the project

```bash
git clone https://github.com/shokhrukhbekyuldoshev/weather.git
```

2. Open the project

```bash
cd weather
```

3. Add your OpenWeatherMap API key to the `lib/secrets.dart` file.

```dart
const String openWeatherMapApiKey = {YOUR_API_KEY};
```

4. Install dependencies

```bash
dart pub get
```

5. Run the app

```bash
flutter run
```

## Permissions

### Android

Before running the project, you need to add the following permissions to the `AndroidManifest.xml` file located in the `android/app/src/main` directory.

```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
```

### iOS

Before running the project, you need to add the following permissions to the `Info.plist` file located in the `ios/Runner` directory.

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs access to location when open.</string>
```

### MacOS

1. Before running the project, you need to add the following permissions to the `Info.plist` file located in the `macos/Runner` directory.

```xml
  <key>NSLocationWhenInUseUsageDescription</key>
  <string>This app needs access to location when open.</string>
```

2. Add the following permissions to the `macos/Runner/DebugProfile.entitlements` file.

```xml
  <key>com.apple.security.personal-information.location</key>
  <true />
```

3. Add the following permissions to the `macos/Runner/Release.entitlements` file.

```xml
  <key>com.apple.security.personal-information.location</key>
  <true />
```

## Contributing

Contributions, issues and feature requests are welcome!

## License

This project is [MIT](LICENSE) licensed.

## Author

**Shokhrukhbek Yuldoshev**

- Github: [@ShokhrukhbekYuldoshev](https://github.com/ShokhrukhbekYuldoshev)
