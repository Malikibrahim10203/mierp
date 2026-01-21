import 'package:get/get.dart';
import 'package:mierp_apps/core/routing/middleware/login_middleware.dart';
import 'package:mierp_apps/data/finance/dashboard_finance_repository.dart';
import 'package:mierp_apps/data/login/login_repository.dart';
import 'package:mierp_apps/data/transaction/services/transaction_services.dart';
import 'package:mierp_apps/domain/credential/repository/credential_repository.dart';
import 'package:mierp_apps/domain/item/repositories/item_repository.dart';
import 'package:mierp_apps/features/detail/presentation/detail_product/detail_product_binding.dart';
import 'package:mierp_apps/features/detail/presentation/detail_product_order/detail_product_order_binding.dart';
import 'package:mierp_apps/features/detail/presentation/detail_sales_order/detail_sales_order_binding.dart';
import 'package:mierp_apps/features/dashboard/presentation/finance/dashboard_finance_view.dart';
import 'package:mierp_apps/features/dashboard/presentation/finance/dashboard_finance_view_model.dart';
import 'package:mierp_apps/features/forgot_password/presentation/forgot_password_binding.dart';
import 'package:mierp_apps/features/forgot_password/presentation/forgot_password_view.dart';
import 'package:mierp_apps/features/loading/loading_binding.dart';
import 'package:mierp_apps/features/loading/loading_view.dart';
import 'package:mierp_apps/features/loading/loading_view_model.dart';
import 'package:mierp_apps/features/profile/presentation/profile_binding.dart';
import 'package:mierp_apps/features/profile/presentation/profile_view.dart';
import 'package:mierp_apps/features/register/presentation/register_binding.dart';
import 'package:mierp_apps/features/summary/presentation/summary_view_model.dart';
import 'package:mierp_apps/features/add/presentation/add_product_order/add_product_order_view.dart';
import 'package:mierp_apps/features/add/presentation/add_sales_order/add_sales_order_view.dart';
import 'package:mierp_apps/features/add/presentation/add_unit/add_unit_view.dart';
import 'package:mierp_apps/features/add/presentation/add_unit/add_unit_view_binding.dart';
import 'package:mierp_apps/features/dashboard/presentation/warehouse/dashboard_warehouse_view.dart';
import 'package:mierp_apps/features/detail/presentation/detail_product/detail_product_view.dart';
import 'package:mierp_apps/features/detail/presentation/detail_product_order/detail_product_order_view.dart';
import 'package:mierp_apps/features/detail/presentation/detail_sales_order/detail_sales_order_view.dart';
import 'package:mierp_apps/features/summary/presentation/summary_view.dart';
import 'package:mierp_apps/features/dashboard/presentation/warehouse/warehouse_view_model.dart';
import 'package:mierp_apps/features/login/presentation/login_view.dart';
import 'package:mierp_apps/features/login/presentation/login_view_model.dart';
import 'package:mierp_apps/features/onboarding/presentation/onboarding_view.dart';
import 'package:mierp_apps/features/onboarding/presentation/onboarding_view_model.dart';
import 'package:mierp_apps/features/register/presentation/register_view.dart';
import 'package:mierp_apps/features/splash/presentation/splash_view.dart';
import 'package:mierp_apps/state/item_store.dart';

class AppRoutes {
  static final pages = [
      GetPage(name: "/onboarding", page: () => OnboardingView()),
      GetPage(
          name: "/splash",
          page: () => SplashView(),
          binding: BindingsBuilder(
              () {
                  Get.put(OnboardingViewModel());
              },
          ),
      ),
      GetPage(
        name: "/login",
        page: () => LoginView(),
        binding: BindingsBuilder(
          () {
            Get.put(LoginViewModel(repo: Get.find<LoginRepository>(), credentialRepository: Get.find<CredentialRepository>()));
          },
        )
      ),
      GetPage(name: "/loading", page: () => LoadingView(), binding: LoadingBinding(),),
      GetPage(name: "/register", page: () => RegisterView(), binding: RegisterBinding()),
      GetPage(name: "/forgot", page: () => ForgotPasswordView(), binding: ForgotPasswordBinding()),
      GetPage(
        name: "/dashboard_warehouse",
        page: () => DashboardWarehouseView(),
        middlewares: [LoginMiddleware()],
        binding: BindingsBuilder(
          () {
            Get.put(WarehouseViewModel(Get.find<ItemRepository>(), Get.find<ItemStore>()));
          },
        ),
      ),
      GetPage(
        name: "/dashboard_finance",
        page: () => DashboardFinanceView(),
        middlewares: [LoginMiddleware()],
        binding: BindingsBuilder(
          () {
            Get.put(DashboardFinanceViewModel(DashboardFinanceRepository(), Get.find<ItemRepository>(), Get.find<ItemStore>(), Get.find<TransactionServices>()));
          },
        )
      ),
      GetPage(name: "/profile", page: () => ProfileView(), binding: ProfileBinding()),
      GetPage(name: "/summary",
        page: () => SummaryView(),
        binding: BindingsBuilder(
          () {
            Get.put(SummaryViewModel(Get.find<ItemRepository>(), Get.find<ItemStore>(), Get.find<TransactionServices>()));
          },
        ),
      ),

      // Warehouse
      GetPage(name: "/add_unit", page: () => AddUnitView(), binding: AddUnitViewBinding()),
      GetPage(name: "/add_sales_order", page: () => AddSalesOrder()),
      GetPage(name: "/add_product_order", page: () => AddProductOrderView()),

      GetPage(name: "/add_sales_order", page: () => AddSalesOrder()),
      GetPage(name: "/add_product_order", page: () => AddProductOrderView()),

      GetPage(name: "/detail_product/:id", page: () => DetailProductView(), binding: DetailProductBinding()),
      GetPage(name: "/detail_product_order/:id", page: () => DetailProductOrderView(), binding: DetailProductOrderBinding()),
      GetPage(name: "/detail_sales_order/:id", page: () => DetailSalesOrderView(), binding: DetailSalesOrderBinding(),),

  ];
}