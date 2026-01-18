import 'package:get/get.dart';
import 'package:mierp_apps/core/models/product.dart';
import 'package:mierp_apps/data/warehouse/add/add_unit_repository.dart';

class AddUnitServices extends GetxService {

  final AddUnitRepository addUnitRepository;
  AddUnitServices({required this.addUnitRepository});

  Future<void> postDataProduct(Product product) async {
    try {
      await addUnitRepository.addUnitToFirebase("products", product);
    } catch(e) {
      rethrow;
    }
  }
}