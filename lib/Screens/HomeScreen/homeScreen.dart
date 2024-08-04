import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:geminiapp/Screens/LogicCode/logicCode.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  final userRequest = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: const Color(0xff1B1B1B),
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          backgroundColor: const Color(0xff1B1B1B),
          title: Text(
            'Gemini App',
            style: GoogleFonts.montserrat(
                fontStyle: FontStyle.normal,
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),
        ),
        body: Consumer<ProviderClass>(
          builder: (context, providerClassInstance, child){
            return DashChat(
              currentUser: user,
              onSend: (sendingMessage){
                providerClassInstance.sendMessage(sendingMessage,context);
              },
              messages: messagesList,
              inputOptions: InputOptions(
                  cursorStyle: const CursorStyle(
                      color: Colors.white
                  ),
                  inputTextStyle: GoogleFonts.montserrat(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  sendOnEnter: true,
                  alwaysShowSend: true,
                  inputDecoration: InputDecoration(
                      hintText: 'Ask Anything',
                      hintStyle: GoogleFonts.montserrat(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      fillColor: Color(0xff272727),
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: width*0.06,vertical: height*0.01),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.transparent,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(30)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(30)
                      )
                  )
              ),
              messageOptions: const MessageOptions(
                  containerColor: Color(0xff272727),
                  currentUserContainerColor: Color(0xff272727),
                  currentUserTextColor: Colors.white,
                  textColor: Colors.white,
                  showOtherUsersAvatar: true,
                  showOtherUsersName: true,
              ),
              typingUsers: typingList,
            );
          },
        )
    );
  }
}
