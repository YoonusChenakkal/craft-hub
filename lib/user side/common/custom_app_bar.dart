import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

customAppBar({required title, bool backLeading = true}) {
  return AppBar(
    title: Text(title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        )),
    toolbarHeight: 8.h,
    automaticallyImplyLeading: backLeading,
    foregroundColor: Colors.white,
    backgroundColor: Colors.cyan,
  );
}

homeAppBar({required String userName, required VoidCallback onPressed}) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Colors.cyan,
    toolbarHeight: 9.h,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hello, $userName',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'welcome',
          style: TextStyle(
            fontSize: 18,
            color: const Color.fromARGB(255, 247, 235, 230),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
    actions: [
      // IconButton(
      //     onPressed: () {},
      //     icon: Icon(
      //       Icons.search,
      //       color: Colors.white,
      //       size: 35,
      //     )),
      IconButton(
          onPressed: onPressed,
          icon: Icon(
            Icons.shopping_cart_outlined,
            color: Colors.white,
            size: 35,
          ))
    ],
  );
}
