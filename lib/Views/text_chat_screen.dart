// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';

import '../Utils/Models/chat_model.dart';
import '../Utils/Widgets/chat_bubble.dart';
import '../Utils/Widgets/input_field.dart';
import '../Utils/api_service.dart';
import '../constants.dart';

class TextToChat extends StatefulWidget {
  const TextToChat({super.key});

  @override
  State<TextToChat> createState() => _TextToChatState();
}

class _TextToChatState extends State<TextToChat> {
  //* loading screen
  late bool isLoading;

  var scrollController = ScrollController();

  //* list to hold all tpyes of message
  final List<ChatMessage> messages = [];

  //* text controller to enter messgae
  TextEditingController _controller = TextEditingController();

  //* initilise loadding to false
  @override
  void initState() {
    super.initState();
    isLoading = false;
  }

  scrollMethod() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),

          //* full functional chat screen
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              //* chat ui screen background
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                child: Container(
                  width: MediaQuery.of(context).size.width * 1.1,
                  height: MediaQuery.of(context).size.height * 0.76,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                  decoration: BoxDecoration(
                    color: KChatScreenBackground,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),

              //* chat list
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 1.1,
                    height: MediaQuery.of(context).size.height * 0.7,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 18),
                    decoration: BoxDecoration(
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
              ),

              //* loading screen
              Visibility(
                visible: isLoading,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),

              //* text field & submit method
              Positioned(
                bottom: 20,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.1,
                  color: Colors.transparent,
                  child: Positioned(
                    bottom: 50,
                    child: Row(
                        //todo input filed

                        children: [
                          //* chat field
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.70,
                            child: MyTextField(
                              controller: _controller,
                            ),
                          ),
                          //* send button
                          mySubmitButton()
                        ]),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget mySubmitButton() {
    return Visibility(
      visible: !isLoading,
      child: Container(
          child: IconButton(
        icon: const Icon(
          Icons.send_rounded,
          color: Colors.white,
        ),
        onPressed: () {
          //* display user input
          setState(() {
            messages.add(
              ChatMessage(text: _controller.text, type: ChatMessageType.user),
            );
            isLoading = true;
          });
          var input = _controller.text;
          _controller.clear();

          Future.delayed(const Duration(milliseconds: 50))
              .then((value) => scrollMethod());

          //* call chatbot api
          ApiService.sendMessage(input).then((value) {
            setState(() {
              isLoading = false;
              messages.add(ChatMessage(text: value, type: ChatMessageType.bot));
            });
          });

          //* clear controller
          _controller.clear();
          Future.delayed(const Duration(milliseconds: 50))
              .then((value) => scrollMethod());
        },
      )),
    );
  }
}
