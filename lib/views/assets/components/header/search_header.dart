import 'package:flutter/material.dart';

class SearchHeader extends StatefulWidget {
  final ValueChanged<String>? onSearch;

  const SearchHeader({
    super.key,
    this.onSearch,
  });

  @override
  State<SearchHeader> createState() => _SearchHeaderState();
}

class _SearchHeaderState extends State<SearchHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 234, 239, 243),
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextField(
        onSubmitted: widget.onSearch,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Buscar Ativo ou Local",
          hintStyle: const TextStyle(
            fontSize: 14.0,
            color: Color.fromARGB(255, 142, 152, 163),
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Image.asset(
              "assets/search.png",
              height: 20,
              width: 20,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}
