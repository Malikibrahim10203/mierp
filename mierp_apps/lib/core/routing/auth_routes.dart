import 'package:get/get.dart';
import 'package:mierp_apps/core/routing/middleware/login_middleware.dart';
import 'package:mierp_apps/features/dashboard/presentation/dashboard_view.dart';
import 'package:mierp_apps/features/dashboard/presentation/finance/dashboard_finance_view.dart';
import 'package:mierp_apps/features/dashboard/presentation/warehouse/dashboard_warehouse_view.dart';
import 'package:mierp_apps/features/login/presentation/login_view.dart';
import 'package:mierp_apps/features/onboarding/onboarding_view.dart';
import 'package:mierp_apps/features/register/presentation/register_view.dart';
import 'package:mierp_apps/features/splash/presentation/splash_view.dart';

class AuthRoutes {
  static final pages = [
      GetPage(name: "/onboarding", page: () => OnboardingView()),
      GetPage(name: "/splash", page: () => SplashView()),
      GetPage(name: "/login", page: () => LoginView()),
      GetPage(name: "/register", page: () => RegisterView()),
      GetPage(
        name: "/dashboard_warehouse",
        page: ()=>DashboardWarehouseView(),
        middlewares: [LoginMiddleware()]
      ),
      GetPage(
        name: "/dashboard_finance",
        page: ()=>DashboardFinanceView(),
        middlewares: [LoginMiddleware()]
      )
  ];
}