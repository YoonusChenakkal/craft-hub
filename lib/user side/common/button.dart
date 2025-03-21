import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

customButton(
    {required VoidCallback onPressed,
    required String buttonName,
    required Color color,
    bool isLoading = false}) {
  return SizedBox(
    width: 70.w,
    height: 50,
    child: ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(color),
        foregroundColor: WidgetStatePropertyAll(Colors.white),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      child: isLoading
          ? CircularProgressIndicator(
              color: Colors.white,
            )
          : Text(
              buttonName,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
    ),
  );
}

customRoundButton({
  required VoidCallback onPressed,
  required Widget textWidget,
  bool isLoading = false,
}) {
  return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 129, 63, 42),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: isLoading
          ? CircularProgressIndicator(
              color: Colors.white,
            )
          : textWidget);
}
