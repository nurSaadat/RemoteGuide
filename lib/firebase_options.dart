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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCxkj46-__p9uEkRK2l0Hy8tA8q49QTLEY',
    appId: '1:451322406270:web:35ab63b12c3ac0cf3e3f2f',
    messagingSenderId: '451322406270',
    projectId: 'remote-guide',
    authDomain: 'remote-guide.firebaseapp.com',
    storageBucket: 'remote-guide.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAGCfHwDMrvqeJ5prETl4VQhSgeNSQHrVo',
    appId: '1:451322406270:android:6fd41e1e55a60dbd3e3f2f',
    messagingSenderId: '451322406270',
    projectId: 'remote-guide',
    storageBucket: 'remote-guide.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCECMrNpr4YjcHDmxEecOyVLp0614t-tqw',
    appId: '1:451322406270:ios:8a20edbece06b4dd3e3f2f',
    messagingSenderId: '451322406270',
    projectId: 'remote-guide',
    storageBucket: 'remote-guide.appspot.com',
    androidClientId: '451322406270-9j0kv3kbenh0hsqb59t8loh60knsumgk.apps.googleusercontent.com',
    iosClientId: '451322406270-l4ccks8ij549e6uvs6tckcol3idi9up1.apps.googleusercontent.com',
    iosBundleId: 'com.example.remoteGuideFirebase',
  );
}
