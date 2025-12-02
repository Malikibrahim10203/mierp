import 'package:get/get.dart';
import 'package:mierp_apps/core/routing/middleware/login_middleware.dart';
import 'package:mierp_apps/features/dashboard/presentation/dashboard_view.dart';
import 'package:mierp_apps/features/login/presentation/login_view.dart';
import 'package:mierp_apps/features/splash/presentation/splash_view.dart';

class AuthRoutes {
  static final pages = [
      GetPage(name: "/splash", page: () => SplashView()),
      GetPage(name: "/login", page: () => LoginView()),
      GetPage(
        name: "/dashboard",
        page: () => DashboardView(),
        middlewares: [LoginMiddleware()]
    )
  ];
}