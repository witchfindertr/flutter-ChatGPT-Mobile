import 'package:chatgpt/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  String subTitle =
      "A trained a model called ChatGPT which interacts in a conversational way. The dialogue format makes it possible for ChatGPT to answer followup questions, admit its mistakes, challenge incorrect premises, and reject inappropriate requests. ChatGPT is a sibling model to InstructGPT, which is trained to follow an instruction in a prompt and provide a detailed response.";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 15, bottom: 5),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.95,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: Colors.white24,
            width: 1.5,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //* logo
              Image.asset(
                'assets/chatgpt_icon.jpg',
                height: 180,
              ),

              //* Title
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
                child: Text(
                  textAlign: TextAlign.left,
                  "OpenAI",
                  style: GoogleFonts.notoSerif(
                    fontSize: 28,
                    color: KTextColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),

              //* subtitle
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                child: Text(
                  textAlign: TextAlign.justify,
                  subTitle,
                  style: GoogleFonts.notoSerif(
                    fontSize: 20,
                    color: KTextColor,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
