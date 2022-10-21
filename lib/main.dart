import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:successquiz/di.dart';
import 'package:successquiz/pages/home.dart';
import '../utils/constants.dart';

void main() {
  configure();
  //WidgetsFlutterBinding.ensureInitialized();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Quiz App',
    home: Flash(),
  ));
}

class Flash extends StatefulWidget {
  const Flash({super.key});

  @override
  State<Flash> createState() => _FlashState();
}

class _FlashState extends State<Flash> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      Get.to(HomePage());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [purple2, purple1],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight)),
          child: Center(
              child: Image.asset(
            "assets/images/choose.png",
            scale: 5,
          ))),
    );
  }
}
