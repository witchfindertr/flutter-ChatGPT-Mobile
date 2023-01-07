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
      decoration: InputDecoration(
        fillColor: KBotBackgroundColor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        focusedBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
        enabledBorder: InputBorder.none,
        //errorBorder: InputBorder.none,
        //disabledBorder: InputBorder.none,
        //focusColor: Colors.black,
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        prefixIcon: const Icon(
          Icons.chat_sharp,
          color: Colors.black,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            controller.clear();
          },
          icon: const Icon(
            Icons.format_clear,
            color: Colors.black,
          ),
        ),
        hintText: 'Start Typing...',
        hintStyle: const TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
