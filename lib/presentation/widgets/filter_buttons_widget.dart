import 'package:flutter/material.dart';

class FilterButtons extends StatelessWidget {
  const FilterButtons(
      {super.key,
      required this.tags,
      required this.onTap,
      required this.includedTags});

  final List<dynamic> tags;
  final Function(dynamic e) onTap;
  final List<String> includedTags;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 3.0,
      children: tags
          .map((e) => GestureDetector(
                onTap: () => onTap(e),
                child: Chip(
                  label: Text(
                    e["name"],
                    style: TextStyle(
                        color: includedTags.contains(e["value"])
                            ? Colors.black
                            : null),
                  ),
                  backgroundColor: includedTags.contains(e["value"])
                      ? Colors.orangeAccent
                      : null,
                ),
              ))
          .toList(),
    );
  }
}
