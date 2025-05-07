import 'package:flutter/material.dart';
import 'package:fruits_hub_dashboard/core/helper/on_genrate_funcation.dart';
import 'package:fruits_hub_dashboard/features/dashboard/views/dashboard_view.dart';

void main() {
  runApp(DashBoardApp());
}

class DashBoardApp extends StatelessWidget {
  const DashBoardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: DashboardView.routeName,
      onGenerateRoute: onGenerateRoute,
    );
  }
}
