import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:successquiz/utils/constants.dart';
import '../controller/quiz_controller.dart';
import 'home/quiz_category_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List quizImages = [
    "c#",
    "ruby",
    "dart",
    "flutter",
    "java",
    "js",
    "kotlin",
    "nodejs",
    "php",
    "python"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray,
      appBar: AppBar(
        backgroundColor: purple1,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: kGradient),
        ),
        title: Text("Quiz Category",
            style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Obx(() {
                var categories = Get.find<QuizController>().categories;
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.1,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: categories.length,
                    itemBuilder: (_, index) => QuizCategoryCard(
                      categories[index],
                      image: quizImages[index % (quizImages.length)],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
