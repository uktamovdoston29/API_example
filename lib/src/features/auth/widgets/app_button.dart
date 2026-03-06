import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class AppButtonWidget extends StatelessWidget {
  const AppButtonWidget({super.key, required this.onPressed, required this.text});
  final VoidCallback onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        fixedSize: Size(400, 62),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(12),
        ),
      ), child: Text(
        text,
        style: GoogleFonts.sen(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: Colors.white
        ),
      ),
     
    );
  }
}
