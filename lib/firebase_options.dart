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
    apiKey: 'AIzaSyBi2oFowomkDKvDAb19zs0eCJLABZLlZr4',
    appId: '1:1046304511786:web:7751b58b20d9b402077053',
    messagingSenderId: '1046304511786',
    projectId: 'zium-6081b',
    authDomain: 'zium-6081b.firebaseapp.com',
    storageBucket: 'zium-6081b.appspot.com',
    measurementId: 'G-CGLPRKTNGX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAwPqQNasLqtLx6hEYo-4vZvH2qdp6xOp8',
    appId: '1:1046304511786:android:5c2e33a8608756d4077053',
    messagingSenderId: '1046304511786',
    projectId: 'zium-6081b',
    storageBucket: 'zium-6081b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB1JcGzkfafyXHjbhvYqYJK21kxpNDyodA',
    appId: '1:1046304511786:ios:24512a95283011c0077053',
    messagingSenderId: '1046304511786',
    projectId: 'zium-6081b',
    storageBucket: 'zium-6081b.appspot.com',
    iosClientId: '1046304511786-kqo3s67jo3v7l66g1orrilj8h6v1l7v3.apps.googleusercontent.com',
    iosBundleId: 'dev.jh.zium',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB1JcGzkfafyXHjbhvYqYJK21kxpNDyodA',
    appId: '1:1046304511786:ios:968a8b87b3190aca077053',
    messagingSenderId: '1046304511786',
    projectId: 'zium-6081b',
    storageBucket: 'zium-6081b.appspot.com',
    iosClientId: '1046304511786-e075s4kuvequngum0begsvnrvngbs787.apps.googleusercontent.com',
    iosBundleId: 'com.example.zium',
  );
}
