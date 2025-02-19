import 'package:flutter/material.dart';

tableRow({required String label, required String? value}) {
  return TableRow(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          '$label : ',
          style: TextStyle(
              fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          value ?? 'Not set',
          style: TextStyle(color: Colors.grey[600]),
        ),
      ),
    ],
  );
}
