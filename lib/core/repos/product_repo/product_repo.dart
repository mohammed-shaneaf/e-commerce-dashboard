import 'package:fruits_hub_dashboard/features/add_product/domain/entities/add_product_entity.dart';

abstract class ProductRepo {
  Future<void> addProduct(AddProductEntity addProductEntity);
}
