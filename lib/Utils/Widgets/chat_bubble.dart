import 'package:chatgpt/Utils/Models/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';

class ChatBubble extends StatelessWidget {
  final String textMessage;
  final ChatMessageType? messagetype;

  const ChatBubble({
    super.key,
    required this.textMessage,
    required this.messagetype,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //* circle avatar
        CircleAvatar(
          radius: 25,
          backgroundImage: messagetype == ChatMessageType.bot
              ? const AssetImage("assets/chatgpt_icon.jpg")
              : const AssetImage("assets/myprofile.jpg"),
        ),

        const SizedBox(
          width: 5,
        ),

        //* for message
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: messagetype == ChatMessageType.bot
                  ? KBotBackgroundColor
                  : Colors.white,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            child: Text(
              textMessage,
              style: GoogleFonts.notoSerif(
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
