import 'package:flutter/material.dart';
import 'package:fruits_hub_dashboard/features/add_product/presentation/widgets/add_product_view_body.dart';

class AddProductView extends StatelessWidget {
  const AddProductView({super.key});

  static const String routeName = 'add-product';

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: AddProductViewBody());
  }
}
