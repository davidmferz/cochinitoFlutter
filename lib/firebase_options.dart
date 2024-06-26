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
    apiKey: 'AIzaSyC_HLX3u3TfhwHty-PcGUDCnoEG4fJmsIw',
    appId: '1:370438203925:web:0c9e355ab7d6b8cd803c1c',
    messagingSenderId: '370438203925',
    projectId: 'cochinito-mexico',
    authDomain: 'cochinito-mexico.firebaseapp.com',
    storageBucket: 'cochinito-mexico.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDQGc_rNSW5fPEmMHLF0LO-WblskyUMcNM',
    appId: '1:370438203925:android:85e414366cb691c9803c1c',
    messagingSenderId: '370438203925',
    projectId: 'cochinito-mexico',
    storageBucket: 'cochinito-mexico.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB57CQoXStQwnXjlEz18FBZ1Kzoo44ry34',
    appId: '1:370438203925:ios:1c0e22bea9879c53803c1c',
    messagingSenderId: '370438203925',
    projectId: 'cochinito-mexico',
    storageBucket: 'cochinito-mexico.appspot.com',
    iosBundleId: 'com.example.cochinito',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB57CQoXStQwnXjlEz18FBZ1Kzoo44ry34',
    appId: '1:370438203925:ios:058323fde0a63f35803c1c',
    messagingSenderId: '370438203925',
    projectId: 'cochinito-mexico',
    storageBucket: 'cochinito-mexico.appspot.com',
    iosBundleId: 'com.example.cochinitoFlutter.RunnerTests',
  );
}
