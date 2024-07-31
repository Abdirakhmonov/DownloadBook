import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  CategoryChip({required this.label, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(label, style: const TextStyle(color: Colors.grey),),
        selected: isSelected,
        onSelected: (bool selected) {},
        selectedColor: const Color(0xff404066),
      ),
    );
  }
}
