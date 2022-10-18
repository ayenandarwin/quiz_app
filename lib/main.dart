import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:successquiz/pages/home.dart';
import '../utils/constants.dart';

//import 'di.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: Flash(),
    //routes: {'/': ((context) => Flash()), '/home': ((context) => HomePage())},
  ));
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//     );
//   }
// }

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
      // Navigator.pushReplacementNamed(context, '/home');
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
            "assets/choose.png",
            scale: 4.5,
          ))),
    );
  }
}
