import 'package:flutter/material.dart';
import 'package:fruits_hub_dashboard/features/add_product/presentation/add_product_view.dart';
import 'package:fruits_hub_dashboard/features/dashboard/views/dashboard_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AddProductView.routeName:
      return MaterialPageRoute(builder: (context) => const AddProductView());

    case DashboardView.routeName:
      return MaterialPageRoute(builder: (context) => const DashboardView());
    default:
      return MaterialPageRoute(
        builder:
            (context) =>
                const Scaffold(body: Center(child: Text("Page Not Found"))),
      );
  }
}
