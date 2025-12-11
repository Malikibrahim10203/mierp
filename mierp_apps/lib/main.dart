import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mierp_apps/core/controller/loading_controller.dart';
import 'package:mierp_apps/core/routing/auth_routes.dart';
import 'package:mierp_apps/core/widgets/controller/input_widget_controller.dart';
import 'package:mierp_apps/features/login/presentation/login_view_model.dart';
import 'package:mierp_apps/features/onboarding/onboarding_view_model.dart';
import 'package:mierp_apps/features/register/presentation/register_view_model.dart';
import 'package:mierp_apps/features/splash/presentation/splash_view_model.dart';
import 'firebase_options.dart';

import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(LoadingController(), permanent: true);
  Get.put(LoginViewModel(), permanent: true);
  Get.lazyPut(()=>SplashViewModel());
  Get.lazyPut(()=>RegisterViewModel());
  await Get.putAsync(() async => OnboardingViewModel());

  runApp(MierpApps());
}

class MierpApps extends StatelessWidget {
  MierpApps({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          initialRoute: '/splash',
          getPages: AuthRoutes.pages,
        );
      },
    );
  }
}
