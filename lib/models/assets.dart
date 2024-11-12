class AssetModel {
  final String id;
  final String name;
  final String? locationId;
  final String? parentId;
  final String? sensorType;
  final String? status;
  List<AssetModel> children;

  AssetModel({
    required this.id,
    required this.name,
    this.locationId,
    this.parentId,
    this.sensorType,
    this.status,
    List<AssetModel>? children,
  }) : children = children ?? [];

  factory AssetModel.fromJson(Map<String, dynamic> json) {
    return AssetModel(
      id: json['id'],
      name: json['name'],
      locationId: json['locationId'],
      parentId: json['parentId'],
      sensorType: json['sensorType'],
      status: json['status'],
    );
  }

  AssetModel copy() {
    return AssetModel(
      id: id,
      name: name,
      locationId: locationId,
      parentId: parentId,
      status: status,
      children: children.map((child) => child.copy()).toList(),
    );
  }
}
