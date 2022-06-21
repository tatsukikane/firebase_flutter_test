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
    apiKey: 'AIzaSyAO_YXCqUkBjUPChdqP-s5Zd5tWjwdcSww',
    appId: '1:919504145012:web:cd2ef0995d4ba24c475f21',
    messagingSenderId: '919504145012',
    projectId: 'fir-flutter-sample-2ee98',
    authDomain: 'fir-flutter-sample-2ee98.firebaseapp.com',
    storageBucket: 'fir-flutter-sample-2ee98.appspot.com',
    measurementId: 'G-3BT0JCDSE3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyATKUcblv7-HBdZmLW_y5rJI4sWmzKpupg',
    appId: '1:919504145012:android:8167ed6a7f44c8ca475f21',
    messagingSenderId: '919504145012',
    projectId: 'fir-flutter-sample-2ee98',
    storageBucket: 'fir-flutter-sample-2ee98.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD0OFc2mJgsaYgcNRisiVoVWi_jbJulrnY',
    appId: '1:919504145012:ios:cc271f9a7171862f475f21',
    messagingSenderId: '919504145012',
    projectId: 'fir-flutter-sample-2ee98',
    storageBucket: 'fir-flutter-sample-2ee98.appspot.com',
    iosClientId: '919504145012-gv6024sjfuh3vdhr3hsqol72ner6li6k.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseFlutterTest',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD0OFc2mJgsaYgcNRisiVoVWi_jbJulrnY',
    appId: '1:919504145012:ios:cc271f9a7171862f475f21',
    messagingSenderId: '919504145012',
    projectId: 'fir-flutter-sample-2ee98',
    storageBucket: 'fir-flutter-sample-2ee98.appspot.com',
    iosClientId: '919504145012-gv6024sjfuh3vdhr3hsqol72ner6li6k.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseFlutterTest',
  );
}
