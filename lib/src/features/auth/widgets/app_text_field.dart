import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthInputWidget extends StatelessWidget {
  const AuthInputWidget({
    super.key,
    this.title,
    required this.hinText,
    this.keyboardType,
    this.onTap,
    this.suffixIcon,
    this.prefixIcon, required this.controller,
  });

  final String? title;
  final TextEditingController controller;
  final String hinText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Text(
              "",
              style: GoogleFonts.sen(fontSize: 13, fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(height: 8),
          Container(
            height: 62,

            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: TextField(
              controller: controller,
              readOnly: onTap != null,
              onTap: onTap,
              keyboardType: keyboardType,
              style: GoogleFonts.sen(fontSize: 14, color: Colors.black),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hinText,
                hintStyle: GoogleFonts.sen(fontSize: 14, color: Colors.grey),
                suffixIcon: suffixIcon,
                prefixIcon: prefixIcon,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
