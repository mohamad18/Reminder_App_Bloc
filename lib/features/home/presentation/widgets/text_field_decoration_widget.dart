import 'package:flutter/material.dart';

textFiledDecoration({required String label, required String hint}) {
  return InputDecoration(
    label: Text(label),
    contentPadding: const EdgeInsets.all(15),
    hintText: hint,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  );
}
