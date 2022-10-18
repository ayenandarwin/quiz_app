import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:successquiz/utils/constants.dart';
import '../controller/quiz_controller.dart';

class ScoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    QuizController _qnController = Get.put(QuizController());
    return Scaffold(
      backgroundColor: gray,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Spacer(),
            Image.asset(
              "assets/clapping.png",
              scale: 3,
            ),
            SizedBox(
              height: kDefaultPadding,
            ),
            Text(
              "Congratulations",
              style: TextStyle(
                  fontSize: 35, fontWeight: FontWeight.bold, color: purple1),
              //   style: Theme.of(context)
              //       .textTheme
              //       .headline4!
              //       .copyWith(color: kBlackColor),
            ),
            SizedBox(
              height: kDefaultPadding,
            ),
            Text(
              "You've completed the quiz successfully.",
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: kDefaultPadding,
            ),
            Text(
              "Your Score",
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: purple1, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: kDefaultPadding,
            ),
            Text(
              "${Get.find<QuizController>().score.value}",
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
