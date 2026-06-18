import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final String hint;

  const SearchField({super.key, this.hint = "Search..."});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(prefixIcon: const Icon(Icons.search), hintText: hint),
    );
  }
}
