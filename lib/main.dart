import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crud/pages/home_page.dart';
import 'package:flutter/material.dart';




void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyD6D_0Pz8UEd11qTKfARLHfJlK9UzLeqGM", // current key in google-services.json file
          appId: "1:203371811326:android:fccb0622f87a4cdb1470af", // mobilesdk_app_id in google-services.json file
          messagingSenderId: "203371811326", // project_number in google-services.json file
          projectId: "fluttercrud-29051")); // project_id in google-services.json file
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}

