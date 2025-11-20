
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyCqk6oXj-SO4zlLxb-sdnx1xMBvtI5hlCQ',
    appId: '1:236320031118:web:1bdc8ac67449571683a4df',
    messagingSenderId: '236320031118',
    projectId: 'alburhaniya-bda8c',
    authDomain: 'alburhaniya-bda8c.firebaseapp.com',
    storageBucket: 'alburhaniya-bda8c.appspot.com',
    measurementId: 'G-1DY2PJ4GKT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCJQJqtaKETrOABCOXhIUbHCT5ajOA_QM4',
    appId: '1:236320031118:android:2efb3dc4020a9e1c83a4df',
    messagingSenderId: '236320031118',
    projectId: 'alburhaniya-bda8c',
    storageBucket: 'alburhaniya-bda8c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAoXltlYLOjwkIsdXcyv9zA14NWkBIY_z8',
    appId: '1:236320031118:ios:1d2161e9c94cfdbd83a4df',
    messagingSenderId: '236320031118',
    projectId: 'alburhaniya-bda8c',
    storageBucket: 'alburhaniya-bda8c.appspot.com',
    iosBundleId: 'com.example.myapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAoXltlYLOjwkIsdXcyv9zA14NWkBIY_z8',
    appId: '1:236320031118:ios:1d2161e9c94cfdbd83a4df',
    messagingSenderId: '236320031118',
    projectId: 'alburhaniya-bda8c',
    storageBucket: 'alburhaniya-bda8c.appspot.com',
    iosBundleId: 'com.example.myapp',
  );
}
