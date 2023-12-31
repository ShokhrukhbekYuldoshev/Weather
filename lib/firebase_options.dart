// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDaW-Unq32fn3T7slt7C0nsXrTY3lmyZXc',
    appId: '1:972504275090:web:60b779256d39f088f9ae4b',
    messagingSenderId: '972504275090',
    projectId: 'weather-service-9d21f',
    authDomain: 'weather-service-9d21f.firebaseapp.com',
    storageBucket: 'weather-service-9d21f.appspot.com',
    measurementId: 'G-ZDC05P4WHB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBWSjm0b5Bd4qrx6PkzJ6U5QBh15_cwDzQ',
    appId: '1:972504275090:android:ca4b5c8ae2acbe7df9ae4b',
    messagingSenderId: '972504275090',
    projectId: 'weather-service-9d21f',
    storageBucket: 'weather-service-9d21f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBDe8WjpCvok8fjE1a4LxP-8qWK-GMyG_c',
    appId: '1:972504275090:ios:368db943fc824ae0f9ae4b',
    messagingSenderId: '972504275090',
    projectId: 'weather-service-9d21f',
    storageBucket: 'weather-service-9d21f.appspot.com',
    iosClientId: '972504275090-m250g93pa97oj8nilh0c6k15p7l3io2g.apps.googleusercontent.com',
    iosBundleId: 'com.shokhrukhbek.weatherService',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBDe8WjpCvok8fjE1a4LxP-8qWK-GMyG_c',
    appId: '1:972504275090:ios:53869a68d7de18ecf9ae4b',
    messagingSenderId: '972504275090',
    projectId: 'weather-service-9d21f',
    storageBucket: 'weather-service-9d21f.appspot.com',
    iosClientId: '972504275090-fhbu977feu26gh9bebp04db7fi7n4daa.apps.googleusercontent.com',
    iosBundleId: 'com.shokhrukhbek.weatherService.RunnerTests',
  );
}
