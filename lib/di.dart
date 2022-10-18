import 'package:get/get.dart';
import 'package:successquiz/controller/quiz_controller.dart';

void configure() {
  Get.put<QuizController>(QuizController());
}
