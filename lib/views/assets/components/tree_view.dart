import 'package:app_tractian/services/api_service.dart';
import 'package:app_tractian/utils/filter.dart';
import 'package:app_tractian/views/assets/components/tree_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/tree.dart';
import 'tree_view_widget.dart';

class TreeViewScreen extends StatefulWidget {
  final String companyId;
  final String filterStatus;
  final String searchTerm;

  const TreeViewScreen(this.companyId, this.filterStatus,
      {super.key, this.searchTerm = ""});

  @override
  State<TreeViewScreen> createState() => _TreeViewScreenState();
}

class _TreeViewScreenState extends State<TreeViewScreen> {
  final ApiService apiService = Get.find();
  TreeData? treeData;
  TreeData? filteredTree;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await apiService.getLocations(widget.companyId);
    await apiService.getAssets(widget.companyId);

    setState(() {
      treeData = buildTree(apiService.location, apiService.assets);
      applyFilters();
    });
  }

  // filtros de status e de busca
  void applyFilters() {
    if (treeData == null) return;

    setState(() {
      TreeData baseTree = treeData!;

      // filtro de status
      if (widget.filterStatus.isNotEmpty) {
        baseTree = filterByStatus(treeData!, [widget.filterStatus]);
      }

      // filtro de busca na estrutura já filtrada pelo status
      if (widget.searchTerm.isNotEmpty) {
        filteredTree = filterBySearchTerm(baseTree, widget.searchTerm);
      } else {
        filteredTree = baseTree;
      }
    });
  }

  @override
  void didUpdateWidget(TreeViewScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.filterStatus != widget.filterStatus ||
        oldWidget.searchTerm != widget.searchTerm) {
      applyFilters();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!apiService.isDataLoaded.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (filteredTree == null || filteredTree!.rootLocations.isEmpty) {
        return const Center(child: Text("Nenhum dado disponível."));
      }

      return ListView(
        children: [
          ...filteredTree!.rootLocations.values
              .map((rootLocation) => TreeViewWidget(location: rootLocation)),
          ...filteredTree!.orphanAssets.map((orphanAsset) => ListTile(
                leading: Image.asset("assets/component.png"),
                title: Text(orphanAsset.name),
                trailing: orphanAssetStatus(orphanAsset.status!),
              )),
        ],
      );
    });
  }

  orphanAssetStatus(String status) {
    String imagePath;
    switch (status) {
      case "operating":
        imagePath = "assets/bolt_green.png";
        break;
      case "alert":
        imagePath = "assets/ellipse_red.png";
        break;
      default:
        return const SizedBox();
    }
    return Image.asset(imagePath, width: 24, height: 24);
  }
}
