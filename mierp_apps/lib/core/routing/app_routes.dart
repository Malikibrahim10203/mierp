import 'package:get/get.dart';
import 'package:mierp_apps/core/routing/middleware/login_middleware.dart';
import 'package:mierp_apps/features/dashboard/presentation/dashboard_view.dart';
import 'package:mierp_apps/features/dashboard/presentation/finance/dashboard_finance_view.dart';
import 'package:mierp_apps/features/dashboard/presentation/profile/profile_view.dart';
import 'package:mierp_apps/features/dashboard/presentation/warehouse/add/add_product_order/add_product_order_view.dart';
import 'package:mierp_apps/features/dashboard/presentation/warehouse/add/add_sales_order/add_sales_order_view.dart';
import 'package:mierp_apps/features/dashboard/presentation/warehouse/add/add_unit/add_unit_view.dart';
import 'package:mierp_apps/features/dashboard/presentation/warehouse/dashboard_warehouse_view.dart';
import 'package:mierp_apps/features/dashboard/presentation/warehouse/detail/detail_product/detail_product_view.dart';
import 'package:mierp_apps/features/dashboard/presentation/warehouse/detail/detail_product_order/detail_product_order_view.dart';
import 'package:mierp_apps/features/dashboard/presentation/warehouse/detail/detail_sales_order/detail_sales_order_view.dart';
import 'package:mierp_apps/features/dashboard/presentation/warehouse/summary/summary_view.dart';
import 'package:mierp_apps/features/login/presentation/login_view.dart';
import 'package:mierp_apps/features/onboarding/onboarding_view.dart';
import 'package:mierp_apps/features/register/presentation/register_view.dart';
import 'package:mierp_apps/features/splash/presentation/splash_view.dart';

class AppRoutes {
  static final pages = [
      GetPage(name: "/onboarding", page: () => OnboardingView()),
      GetPage(name: "/splash", page: () => SplashView()),
      GetPage(name: "/login", page: () => LoginView()),
      GetPage(name: "/register", page: () => RegisterView()),
      GetPage(
        name: "/dashboard_warehouse",
        page: () => DashboardWarehouseView(),
        middlewares: [LoginMiddleware()]
      ),
      GetPage(
        name: "/dashboard_finance",
        page: () => DashboardFinanceView(),
        middlewares: [LoginMiddleware()]
      ),

      GetPage(name: "/profile", page: () => ProfileView()),

      // Warehouse
      GetPage(name: "/summary", page: () => SummaryView()),

      GetPage(name: "/add_unit", page: () => AddUnitView()),
      GetPage(name: "/add_sales_order", page: () => AddSalesOrder()),
      GetPage(name: "/add_product_order", page: () => AddProductOrderView()),

      GetPage(name: "/detail_product", page: () => DetailProductView()),
      GetPage(name: "/add_sales_order", page: () => AddSalesOrder()),
      GetPage(name: "/add_product_order", page: () => AddProductOrderView()),

      GetPage(name: "/detail_product_order", page: () => DetailProductOrderView()),
      GetPage(name: "/detail_sales_order", page: () => DetailSalesOrderView()),
  ];
}