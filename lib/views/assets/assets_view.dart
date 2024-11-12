import 'package:app_tractian/services/api_service.dart';
import 'package:app_tractian/views/assets/components/header/header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'components/tree_view.dart';

class AssetsView extends StatefulWidget {
  final String companyId;
  const AssetsView(this.companyId, {super.key});

  @override
  State<AssetsView> createState() => _AssetsViewState();
}

class _AssetsViewState extends State<AssetsView> {
  final ApiService apiService = Get.find();
  String filterStatus = "";
  String searchTerm = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assets"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Header(
              onEnergyFilter: () {
                setState(() {
                  filterStatus = "operating";
                });
              },
              onCriticalFilter: () {
                setState(() {
                  filterStatus = "alert";
                });
              },
              onClearFilter: () {
                setState(() {
                  filterStatus = "";
                });
              },
              onSearch: (term) {
                setState(() {
                  searchTerm = term;
                });
              },
            ),
            const Divider(),
            Expanded(
              child: TreeViewScreen(
                widget.companyId,
                filterStatus,
                searchTerm: searchTerm,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
