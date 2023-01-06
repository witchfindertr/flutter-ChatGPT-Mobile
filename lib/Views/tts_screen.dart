import 'package:avatar_glow/avatar_glow.dart';
import 'package:chatgpt/Utils/Models/chat_model.dart';
import 'package:chatgpt/Utils/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../Utils/Widgets/chat_bubble.dart';
import '../constants.dart';

class TTSScreen extends StatefulWidget {
  const TTSScreen({super.key});

  @override
  State<TTSScreen> createState() => _TTSScreenState();
}

class _TTSScreenState extends State<TTSScreen> {
  //* var audioText
  var audioText = "Hold to record your text";

  //* ui action bool value
  var isListening = false;

  //* loading screen
  late bool isLoading;

  //* object of TTS package
  SpeechToText speechToText = SpeechToText();

  //* list to hold all tpyes of message
  final List<ChatMessage> messages = [];

  var scrollController = ScrollController();

  scrollMethod() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  //* initilise loadding to false
  @override
  void initState() {
    super.initState();
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),

          //* TTS converted text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              audioText,
              style: GoogleFonts.notoSerif(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: KTextColor,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          //* UI for chat screen
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 1.1,
                  height: MediaQuery.of(context).size.height * 0.7,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                  decoration: BoxDecoration(
                    color: KChatScreenBackground,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      controller: scrollController,
                      shrinkWrap: true,
                      itemCount: messages.length,
                      itemBuilder: (BuildContext context, int index) {
                        var chat = messages[index];
                        return ChatBubble(
                          textMessage: chat.text.toString(),
                          messagetype: chat.type,
                        );
                      }),
                ),
              ),

              //* loading screen
              Visibility(
                visible: isLoading,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              //* MIc Button
              Positioned(
                bottom: -30,
                right: -5,
                child: GestureDetector(
                  onTapDown: (details) async {
                    HapticFeedback.vibrate();
                    if (!isListening) {
                      //* check if you can listen to audio -> return bool value
                      bool avail = await speechToText.initialize();

                      if (avail) {
                        setState(() {
                          isListening = true;

                          //* start listening and append result to var
                          speechToText.listen(onResult: (res) {
                            setState(() {
                              audioText = res.recognizedWords;
                            });
                          });
                        });
                      }
                    }
                  },
                  onTapUp: (details) async {
                    HapticFeedback.vibrate();
                    setState(() {
                      isListening = false;
                      isLoading = true;
                    });

                    //* stop listening once tapped away from screen
                    speechToText.stop();

                    //* add the recorded message to list
                    messages.add(ChatMessage(
                        text: audioText, type: ChatMessageType.user));

                    //* call api SErvice
                    var msg = await ApiService.sendMessage(audioText);

                    //* store bot's reply into message list
                    setState(() {
                      messages.add(
                          ChatMessage(text: msg, type: ChatMessageType.bot));
                      isLoading = false;
                    });
                  },
                  child: AvatarGlow(
                    endRadius: 85.0,
                    animate: isListening ? true : false,
                    duration: const Duration(milliseconds: 2000),
                    repeat: true,
                    glowColor: Colors.white30,
                    showTwoGlows: true,
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Icon(
                        isListening ? Icons.mic : Icons.mic_off,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
