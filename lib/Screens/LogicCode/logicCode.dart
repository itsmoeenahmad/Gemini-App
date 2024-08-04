import 'dart:convert';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

//Chats User Details
final user = ChatUser(
  id: '1',
  firstName: 'User',
  profileImage: 'assets/userLogo.jpg',
);
final gemini = ChatUser(
  id: '2',
  firstName: 'Gemini',
  profileImage: 'assets/geminiImage.png',
);



//List which store all the messages
List<ChatMessage> messagesList = <ChatMessage>[];

//List Which will just show a loading... effect whenever response will be under processing by Gemini
List<ChatUser> typingList = <ChatUser>[];

//Provider class for state management and Method Which will be called when user wanna to
//ask anything from a gemini
class ProviderClass extends ChangeNotifier {
  void sendMessage(ChatMessage sendingMessage,context) {
    typingList.add(gemini);
    messagesList.insert(0, sendingMessage);
    notifyListeners();

    //Request to Gemini Server

    String URL = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=AIzaSyCRXACUKuBbjfZpgyEtmbedI5GADdj6co4';
    final headers = {'Content-Type': 'application/json'};
    dynamic body = {
      "contents": [
        {
          "parts": [
            {"text": sendingMessage.text}
          ]
        }
      ]
    };

    http.post(Uri.parse(URL), headers: headers, body: jsonEncode(body)).then((responseMessage){
      if(responseMessage.statusCode==200)
        {
          dynamic result = jsonDecode(responseMessage.body.toString());
          print(result['candidates'][0]['content']['parts'][0]['text']);

          //Storing the response in a chat which will be displayed on a screen after saving in messageslist

          ChatMessage resultMessage = ChatMessage(user: gemini, createdAt: DateTime.now(),text: result['candidates'][0]['content']['parts'][0]['text']);
          messagesList.insert(0, resultMessage);
          notifyListeners();
          typingList.remove(gemini);
        }
      else
        {
          typingList.remove(gemini);
          print(responseMessage.body.toString());
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Server Error!!Try Again',style: GoogleFonts.montserrat(fontSize: 15,color: Colors.white),),backgroundColor: Colors.red,));
        }
    }).onError((error,another){
      typingList.remove(gemini);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$error',style: GoogleFonts.montserrat(fontSize: 15,color: Colors.white),),backgroundColor: Colors.red,));
      print(error);
    });
  }
}
