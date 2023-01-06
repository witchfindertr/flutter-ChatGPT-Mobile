import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;

  const MyTextField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      autocorrect: true,
      controller: controller,
      textCapitalization: TextCapitalization.sentences,
      style: GoogleFonts.notoSerif(color: Colors.black),
      decoration: const InputDecoration(
        fillColor: KBotBackgroundColor,
        filled: true,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        focusColor: Colors.black,
        labelStyle: TextStyle(
          color: Colors.black,
        ),
        hintText: 'Start Typing...',
        hintStyle: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
