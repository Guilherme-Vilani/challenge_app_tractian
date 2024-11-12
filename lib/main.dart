import 'package:app_tractian/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/companies/companies_view.dart';

main() async {
  Get.put(ApiService());
  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CompaniesView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
