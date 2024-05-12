import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fp14_1/screens/HomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  String? apiKey = dotenv.env['API_KEY'];
  String? appId = dotenv.env['APPID'];
  String? messagingSenderId = dotenv.env['MESSAGE_SENDER_ID'];
  String? projectId = dotenv.env['PROJECT_ID'];
  String? storageBucket = dotenv.env['STORAGE_BUCKET'];

  if (apiKey != null && appId != null && messagingSenderId != null &&
      projectId != null && storageBucket != null) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: apiKey,
        appId: appId,
        messagingSenderId: messagingSenderId,
        projectId: projectId,
        storageBucket: storageBucket,
      ),
    );
  } else {
    // ignore: avoid_print
    print("One or more environment variables are missing.");
    return; // Exit the application if environment variables are missing
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Firebase App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: HomePage(),
    );
  }
}
