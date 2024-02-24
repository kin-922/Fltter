import 'package:flutter/material.dart';
import 'package:flashchat/screens/chat_screen.dart';
import 'package:flashchat/screens/welcome_screen.dart';
import 'package:flashchat/screens/login_screen.dart';
import 'package:flashchat/screens/registration_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



/// Requires that a Firebase local emulator is running locally.
// /// See https://firebase.flutter.dev/docs/auth/start/#optional-prototype-and-test-with-firebase-local-emulator-suite
// bool shouldUseFirebaseEmulator = false;

late final FirebaseApp app;
late final FirebaseAuth auth;
late final FirebaseFirestore store;
// Requires that the Firebase Auth emulator is running locally
// e.g via `melos run firebase:emulator`.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // FirebaseFirestore.instance.settings = const Settings(
  //   persistenceEnabled: true,
  // );
  // We're using the manual installation on non-web platforms since Google sign in plugin doesn't yet support Dart initialization.
  // See related issue: https://github.com/flutter/flutter/issues/96391

  // // We store the app and auth to make testing with a named instance easier.
   app =  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    auth = FirebaseAuth.instanceFor(app: app);
   store = FirebaseFirestore.instanceFor(app: app);


  // if (shouldUseFirebaseEmulator) {
  //   await auth.useAuthEmulator('localhost', 9099);
  // }
  //
  // if (!kIsWeb && Platform.isWindows) {
  //   await GoogleSignInDart.register(
  //     clientId:
  //     '406099696497-g5o9l0blii9970bgmfcfv14pioj90djd.apps.googleusercontent.com',
  //   );
  // }

//   runApp(const AuthExampleApp());
// }
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white10),
        ),
      ),
      home: WelcomeScreen(),
      initialRoute: WelcomeScreen.id,
      routes:{
        WelcomeScreen.id: (context) => WelcomeScreen(),
        ChatScreen.id: (context) => ChatScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        LoginScreen.id: (context) => LoginScreen(),
      },

    );
  }
}
