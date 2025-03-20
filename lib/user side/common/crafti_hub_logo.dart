import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

craftiHubLogo() {
  return CircleAvatar(
    backgroundColor: Color.fromARGB(255, 129, 63, 42),
    radius: 16.w,
    child: FittedBox(
      child: Text(
        'CRAFTI-HUB',
        style: TextStyle(
            fontSize: 19, color: Colors.white, fontWeight: FontWeight.w900),
      ),
    ),
  );
}
