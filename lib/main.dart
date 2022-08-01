import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_crud/firebase_options.dart';
import 'package:test_crud/service/firebase_service.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:manybooks_admin/firebase_options.dart';
// import 'package:manybooks_admin/models/stb.dart';
// import 'package:manybooks_admin/services/firebase_auth_methods.dart';
// import 'package:manybooks_admin/views/user_dashboard.dart';
// import 'package:states_rebuilder/states_rebuilder.dart';

// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:test_crud/firebase_options.dart';
// import './services/firebase_auth_methods.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ManyBooks",
      initialRoute: '/',
      // routes: {'/dashboard': (context) => UserDashboard()},
      home: Scaffold(
        appBar: AppBar(
          title: Text("Manybooks"),
        ),
        body: FirebaseAuthMethod().handleAuthState(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              var abc = await FirebaseAuthMethod().signInWithGoogle();
              print(":");
            },
            child: Text("Sign in with Google"),
          ),
          ElevatedButton(
            onPressed: () {
              FirebaseAuthMethod().logOut();
            },
            child: Text('Sign out'),
          )
        ],
      ),
    );
  }
}
