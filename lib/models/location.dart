import 'package:app_tractian/models/assets.dart';

class LocationModel {
  final String id;
  final String name;
  final String? parentId;
  List<AssetModel> assets;
  List<LocationModel> children;

  LocationModel({
    required this.id,
    required this.name,
    this.parentId,
    List<LocationModel>? children,
    List<AssetModel>? assets,
  })  : children = children ?? [],
        assets = assets ?? [];

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'],
      name: json['name'],
      parentId: json['parentId'],
    );
  }

  LocationModel copy() {
    return LocationModel(
      id: id,
      name: name,
      parentId: parentId,
      children: children.map((child) => child.copy()).toList(),
      assets: assets.map((asset) => asset.copy()).toList(),
    );
  }
}
