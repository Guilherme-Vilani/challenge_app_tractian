import 'package:app_tractian/models/assets.dart';
import '../models/location.dart';
import '../models/tree.dart';

TreeData filterByStatus(TreeData treeData, List<String> statuses) {
  TreeData copiedTree = treeData.copy();

  bool filterAssetTree(AssetModel asset) {
    bool hasMatchingDescendant = asset.children.any(filterAssetTree);
    bool matches = statuses.contains(asset.status) || hasMatchingDescendant;

    if (matches) {
      asset.children.removeWhere((child) => !filterAssetTree(child));
    }
    return matches;
  }

  bool filterLocationTree(LocationModel location) {
    location.assets.removeWhere((asset) => !filterAssetTree(asset));
    location.children.removeWhere((child) => !filterLocationTree(child));
    return location.assets.isNotEmpty || location.children.isNotEmpty;
  }

  final filteredRootLocations = Map<String, LocationModel>.fromEntries(
    copiedTree.rootLocations.values
        .where(filterLocationTree)
        .map((loc) => MapEntry(loc.id, loc)),
  );

  final filteredOrphanAssets =
      copiedTree.orphanAssets.where(filterAssetTree).toList();

  return TreeData(
    rootLocations: filteredRootLocations,
    orphanAssets: filteredOrphanAssets,
  );
}

TreeData filterBySearchTerm(TreeData treeData, String searchTerm) {
  // Cria uma cópia completa da estrutura de TreeData para preservar treeData original
  TreeData copiedTree = treeData.copy();

  // Função auxiliar para verificar se o nome corresponde ao termo de busca
  bool matchesSearch(String? name) =>
      searchTerm.isEmpty ||
      (name?.toLowerCase().contains(searchTerm.toLowerCase()) ?? false);

  // Função recursiva para filtrar a árvore de assets e incluir a família completa
  bool filterAssetTree(AssetModel asset) {
    // Verifica se o próprio asset ou qualquer um dos filhos corresponde ao termo de busca
    bool matches = matchesSearch(asset.name);

    if (matches) {
      // Mantém todos os filhos para preservar a família completa
      return true;
    } else {
      // Filtra filhos recursivamente e remove aqueles que não correspondem
      asset.children = asset.children.where(filterAssetTree).toList();
      return asset.children
          .isNotEmpty; // Mantém o item se houver filhos correspondentes
    }
  }

  // Função recursiva para filtrar a árvore de locations e incluir a família completa
  bool filterLocationTree(LocationModel location) {
    // Verifica se a própria localização ou algum dos assets corresponde ao termo de busca
    bool matches = matchesSearch(location.name);

    if (matches) {
      // Inclui todos os assets e filhos para preservar a família completa
      return true;
    } else {
      // Filtra assets e children recursivamente
      location.assets = location.assets.where(filterAssetTree).toList();
      location.children = location.children.where(filterLocationTree).toList();
      return location.assets.isNotEmpty ||
          location.children
              .isNotEmpty; // Mantém a localização se houver filhos correspondentes
    }
  }

  // Cria o map de root locations filtradas
  final filteredRootLocations = Map<String, LocationModel>.fromEntries(
    copiedTree.rootLocations.values
        .where(filterLocationTree)
        .map((loc) => MapEntry(loc.id, loc)),
  );

  // Filtra os orphanAssets para incluir apenas aqueles que correspondem ao filtro de busca
  final filteredOrphanAssets =
      copiedTree.orphanAssets.where(filterAssetTree).toList();

  return TreeData(
    rootLocations: filteredRootLocations,
    orphanAssets: filteredOrphanAssets,
  );
}
