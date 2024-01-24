import 'package:flutter/material.dart';
import 'package:flutter_mysql/dependency_Injection.dart';
import 'package:flutter_mysql/first.dart';
import 'package:flutter_mysql/form.dart';
import 'package:flutter_mysql/login.dart';
import 'package:get/get.dart';

Future<void>  main() async {

  runApp(const MyApp());
  dependencyInjection.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      //title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const login(),
    );
  }
}



