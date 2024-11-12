import 'package:app_tractian/models/assets.dart';
import 'package:app_tractian/models/location.dart';
import 'package:flutter/material.dart';

class TreeViewWidget extends StatelessWidget {
  final LocationModel location;
  final int level;

  const TreeViewWidget({super.key, required this.location, this.level = 0});

  @override
  Widget build(BuildContext context) {
    final hasChildren =
        location.assets.isNotEmpty || location.children.isNotEmpty;

    return Padding(
      padding: EdgeInsets.only(left: level * 16.0),
      child: hasChildren
          ? ExpansionTile(
              leading: _buildLeadingIcon(isLocation: true),
              title: Text(
                location.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              children: [
                ...location.assets
                    .map((asset) => _buildAssetTile(asset, level + 1)),
                ...location.children.map((childLocation) => TreeViewWidget(
                      location: childLocation,
                      level: level + 1,
                    )),
              ],
            )
          : ListTile(
              leading: _buildLeadingIcon(isLocation: true),
              title: Text(
                location.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
    );
  }

  Widget _buildAssetTile(AssetModel asset, int level) {
    final hasChildren = asset.children.isNotEmpty;

    return Padding(
      padding: EdgeInsets.only(left: level * 16.0),
      child: hasChildren
          ? ExpansionTile(
              leading: _buildLeadingIcon(isLocation: false, hasChildren: true),
              title: Text(asset.name),
              trailing: _buildStatusIcon(asset.status),
              children: asset.children
                  .map((childAsset) => _buildAssetTile(childAsset, level + 1))
                  .toList(),
            )
          : ListTile(
              leading: _buildLeadingIcon(isLocation: false, hasChildren: false),
              title: Text(asset.name),
              trailing: _buildStatusIcon(asset.status),
            ),
    );
  }

  // escolhe o ícone de status com base no status do asset
  Widget _buildStatusIcon(String? status) {
    String imagePath;
    if (status == 'operating') {
      imagePath = 'assets/bolt_green.png';
    } else if (status == 'alert') {
      imagePath = 'assets/ellipse_red.png';
    } else {
      return const SizedBox();
    }
    return Image.asset(imagePath, width: 24, height: 24);
  }

  // seleciona o ícone principal do item
  Widget _buildLeadingIcon(
      {required bool isLocation, bool hasChildren = false}) {
    String imagePath;
    if (isLocation) {
      imagePath = 'assets/location.png';
    } else if (hasChildren) {
      imagePath = 'assets/actives.png';
    } else {
      imagePath = 'assets/component.png';
    }
    return Image.asset(imagePath, width: 24, height: 24);
  }
}
