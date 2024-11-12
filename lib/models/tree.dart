import 'package:app_tractian/models/assets.dart';
import 'package:app_tractian/models/location.dart';

class TreeData {
  final Map<String, LocationModel> rootLocations;
  final List<AssetModel> orphanAssets;

  TreeData({required this.rootLocations, required this.orphanAssets});

  // Método de cópia profunda para preservar a estrutura original
  TreeData copy() {
    return TreeData(
      rootLocations: rootLocations.map((key, loc) => MapEntry(key, loc.copy())),
      orphanAssets: orphanAssets.map((asset) => asset.copy()).toList(),
    );
  }
}
