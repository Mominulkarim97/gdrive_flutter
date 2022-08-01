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
    apiKey: 'AIzaSyATuu2BK_Kd_Hi8IrW3S_VVzMBAYt9u4pU',
    appId: '1:305336831299:web:dd6b0554ddca32da7033f6',
    messagingSenderId: '305336831299',
    projectId: 'flutter-gdrive-dace3',
    authDomain: 'flutter-gdrive-dace3.firebaseapp.com',
    storageBucket: 'flutter-gdrive-dace3.appspot.com',
    measurementId: 'G-TZ589HMRZQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD85E6wcQNZWrpT5D8U-nMNiZ8I1QdhrpA',
    appId: '1:305336831299:android:875477d95d669a617033f6',
    messagingSenderId: '305336831299',
    projectId: 'flutter-gdrive-dace3',
    storageBucket: 'flutter-gdrive-dace3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA1BEClK-YasmbEFHVhMB7h97PQtz113hg',
    appId: '1:305336831299:ios:030c9960a3070b8a7033f6',
    messagingSenderId: '305336831299',
    projectId: 'flutter-gdrive-dace3',
    storageBucket: 'flutter-gdrive-dace3.appspot.com',
    iosClientId: '305336831299-im7ojafjnpcrnso8do733vog7grcq917.apps.googleusercontent.com',
    iosBundleId: 'com.example.testCrud',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA1BEClK-YasmbEFHVhMB7h97PQtz113hg',
    appId: '1:305336831299:ios:030c9960a3070b8a7033f6',
    messagingSenderId: '305336831299',
    projectId: 'flutter-gdrive-dace3',
    storageBucket: 'flutter-gdrive-dace3.appspot.com',
    iosClientId: '305336831299-im7ojafjnpcrnso8do733vog7grcq917.apps.googleusercontent.com',
    iosBundleId: 'com.example.testCrud',
  );
}