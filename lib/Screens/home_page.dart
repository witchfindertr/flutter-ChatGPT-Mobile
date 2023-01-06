import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../Views/text_chat_screen.dart';
import '../Views/tts_screen.dart';
import '../Views/info_screen.dart';
import '../constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  List<Widget> views = const [
    TTSScreen(),
    TextToChat(),
    InfoScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //* backgroud Color
      backgroundColor: KScaffoldBackgroundColor,

      //* App bar
      appBar: AppBar(
        //backgroundColor: KAppBackgroundColor,
        backgroundColor: Colors.black,
        title: Text(
          "OpenAI  ChatGPT III",
          style: GoogleFonts.notoSerif(),
        ),
        centerTitle: true,
        elevation: 5,
      ),

      body: views[_selectedIndex],

      //* Bottom NAvi bar
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(29),
          ),
          child: GNav(
            iconSize: 25,
            tabBackgroundColor: Colors.black12,
            tabActiveBorder: Border.all(color: Colors.white, width: 2),
            padding: const EdgeInsets.all(20),
            haptic: true,
            gap: 8,
            color: Colors.grey,
            activeColor: Colors.white,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            tabs: [
              GButton(
                icon: Icons.speaker,
                text: 'Speech to Text',
                textStyle: GoogleFonts.notoSerif(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
              GButton(
                icon: Icons.chat,
                text: 'Chat',
                textStyle: GoogleFonts.notoSerif(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
              GButton(
                icon: Icons.info_outline,
                text: 'Info',
                textStyle: GoogleFonts.notoSerif(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
