import 'package:flutter/material.dart';
import 'package:mainproject1/services/db_service.dart';

import 'moduls/auth/login.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await DbService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white,
          ),
      home: LoginScreen(),
    );
  }
}
