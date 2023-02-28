import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_vazotsika/app/modules/home/controllers/home_controller.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/modules/home/controllers/player_controller.dart';
import 'app/routes/app_pages.dart';
import 'app_controller.dart';

Future main() async {
  await GetStorage.init();
  await dotenv.load(fileName: '.env');
  Get.put(AppController());
  Get.put(PlayerController());
  runApp(
    GetMaterialApp(
      key: Get.find<AppController>().scaffoldMessenger,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
