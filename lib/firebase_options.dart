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
    apiKey: 'AIzaSyCRMbz9MuPv3kN3LuEcDcdTjodquA_kPsA',
    appId: '1:718695730255:web:f4ee4779d2dae2c85bae3a',
    messagingSenderId: '718695730255',
    projectId: 'amai-af4b2',
    authDomain: 'amai-af4b2.firebaseapp.com',
    storageBucket: 'amai-af4b2.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBfW-BLf11xTWFbruvZb1h0-e1iP7MAcZw',
    appId: '1:718695730255:android:cfc392e00f1fa31a5bae3a',
    messagingSenderId: '718695730255',
    projectId: 'amai-af4b2',
    storageBucket: 'amai-af4b2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDETyfK5v4n77nVgPqQZYkQTdv7hI9pC0s',
    appId: '1:718695730255:ios:848712801337f41c5bae3a',
    messagingSenderId: '718695730255',
    projectId: 'amai-af4b2',
    storageBucket: 'amai-af4b2.appspot.com',
    iosBundleId: 'com.example.bakery',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDETyfK5v4n77nVgPqQZYkQTdv7hI9pC0s',
    appId: '1:718695730255:ios:a81b38cddf8651595bae3a',
    messagingSenderId: '718695730255',
    projectId: 'amai-af4b2',
    storageBucket: 'amai-af4b2.appspot.com',
    iosBundleId: 'com.example.bakery.RunnerTests',
  );
}