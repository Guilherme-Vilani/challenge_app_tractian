import 'package:flutter/material.dart';
import 'package:app_tractian/views/assets/components/header/search_header.dart';

class Header extends StatefulWidget {
  final VoidCallback onEnergyFilter;
  final VoidCallback onCriticalFilter;
  final VoidCallback onClearFilter;
  final ValueChanged<String> onSearch;

  const Header({
    super.key,
    required this.onEnergyFilter,
    required this.onCriticalFilter,
    required this.onClearFilter,
    required this.onSearch,
  });

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool energy = false;
  bool critical = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
      child: Column(
        children: [
          SearchHeader(onSearch: widget.onSearch),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    energy = !energy;
                    critical = false;
                  });
                  if (energy) {
                    widget.onEnergyFilter();
                  } else {
                    widget.onClearFilter();
                  }
                },
                child: _buildFilterButton(
                  isSelected: energy,
                  label: "Sensor de Energia",
                  iconPath: "assets/bolt.png",
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    critical = !critical;
                    energy = false;
                  });
                  if (critical) {
                    widget.onCriticalFilter();
                  } else {
                    widget.onClearFilter();
                  }
                },
                child: _buildFilterButton(
                  isSelected: critical,
                  label: "Crítico",
                  iconPath: "assets/critical.png",
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildFilterButton({
    required bool isSelected,
    required String label,
    required String iconPath,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 8, right: 8),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
      decoration: BoxDecoration(
        color:
            isSelected ? const Color.fromARGB(255, 33, 136, 255) : Colors.white,
        border: Border.all(
            width: 1, color: const Color.fromARGB(255, 216, 223, 230)),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Row(
        children: [
          Image.asset(iconPath, color: isSelected ? Colors.white : null),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : null,
            ),
          ),
        ],
      ),
    );
  }
}
