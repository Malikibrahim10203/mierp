import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:mierp_apps/core/routing/auth_routes.dart';
import 'package:mierp_apps/features/login/presentation/login_view_model.dart';
import 'firebase_options.dart';

import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(LoginViewModel(), permanent: true);
  runApp(
    GetMaterialApp(
      initialRoute: "/splash",
      getPages: AuthRoutes.pages,
    )
  );
}