import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fp14_1/screens/HomePage.dart';
import 'dart:io';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
          options: kIsWeb|| Platform.isAndroid?const FirebaseOptions(
          apiKey: "AIzaSyAurjSiBrt8LfAcy4wLx4jFG-AeoSongdI",
          appId: "1:559048637755:android:e6a6ad9acd8a057f764b1e",
          messagingSenderId: "559048637755",
          projectId: "flutterfirebase-c7d6b",
          storageBucket: "flutterfirebase-c7d6b.appspot.com",
        ): null ,);
      
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter FireBase App ",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: HomePage(),
    );
  }
}
