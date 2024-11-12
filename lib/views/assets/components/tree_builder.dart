import 'package:app_tractian/models/assets.dart';
import 'package:app_tractian/models/location.dart';

import '../../../models/tree.dart';

// constroi arvore de location
TreeData buildTree(
    List<LocationModel> locationsData, List<AssetModel> assetsData) {
  final locations = {for (var loc in locationsData) loc.id: loc};
  final assets = {for (var asset in assetsData) asset.id: asset};
  final List<AssetModel> orphanAssets = [];

  // associa cada asset a uma location, se tiver locationId
  for (var asset in assets.values) {
    if (asset.locationId != null && locations.containsKey(asset.locationId)) {
      locations[asset.locationId]!.assets.add(asset);
    } else if (asset.parentId != null && assets.containsKey(asset.parentId)) {
      assets[asset.parentId]!.children.add(asset);
    } else {
      orphanAssets.add(asset);
    }
  }

  for (var location in locations.values) {
    if (location.parentId != null && locations.containsKey(location.parentId)) {
      locations[location.parentId]!.children.add(location);
    }
  }

  // coloca todos os locations sem parentId para a raiz
  final rootLocations = locations.values
      .where((loc) => loc.parentId == null)
      .fold<Map<String, LocationModel>>({}, (map, loc) => map..[loc.id] = loc);

  return TreeData(rootLocations: rootLocations, orphanAssets: orphanAssets);
}
