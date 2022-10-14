import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:loviser/providers/authentication.dart';
import 'dart:convert';
import 'dart:io';
import './user.dart';
import './message.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../config/config.dart';
import 'package:http/http.dart' as http;

import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart';

import 'dart:convert';
import 'package:provider/provider.dart';

class MessagePageProvider with ChangeNotifier {
  List<User> users = [
    // User('IronMan', '111'),
    // User('Captain America', '222'),
    // User('Antman', '333'),
    // User('Hulk', '444'),
    // User('Thor', '555'),
  ];
  //late User currentUser;
  late List<User> friendList = [];
  late List<Message> messages = [];
  late IO.Socket socket;
  late String current_user_id = ''; //''63283a8550714dd6a28d1478';

  Future<void> fetchAndSetUsers() async {
    final url = Uri.parse(urlGetAlUser);
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      //print(extractedData["message"]);
      final List<User> loadedProducts = [];

      users = extractedData["message"].map<User>((prodData) {
        print(prodData["name"]);
        return User(
          prodData["username"],
          prodData["_id"],
        );
      }).toList();

      friendList =
          users.where((user) => user.chatID != current_user_id).toList();

      // print('list user');
      //print(users[0].name);
      //print(users[0].chatID);

      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> fetchAndSetMessages() async {
    final url = Uri.parse(urlGetAllMessage);
    try {
      Response response = await post(
        Uri.parse(urlGetAllMessage),
        body: {'userid': current_user_id},
      );

      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      print(extractedData["message"]);
      final List<Message> loadedProducts = [];

      messages = extractedData["message"].map<Message>((prodData) {
        return Message(
          prodData["message"],
          prodData["from"],
          prodData["to"],
        );
      }).toList();

      print("Message data");
      print(messages);

      //print(users[0].name);
      //print(users[0].chatID);

      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  void setCurrentUserId(String userid) {
    current_user_id = userid;
    notifyListeners();
  }

  void init() {
    //currentUser = users[1];

    //friendList = users.where((user) => user.chatID != current_user_id).toList();

    socket = IO.io(
      urlSocket_deploy,
      IO.OptionBuilder().setTransports(['websocket']).setQuery(
          {'chatID': '${current_user_id}'}).build(),
    );

    print('init message page provider');

    socket.onConnect((_) {
      print('connect');
    });

    socket.on('receive_message', (jsonData) {
      print('get message from another');
      print(jsonData);
      // Map<String, dynamic> data = json.decode(jsonData) as Map<String, dynamic>;
      print(json.encode(jsonData));
      final new_t = json.encode(jsonData);
      final data = json.decode(new_t) as Map<String, dynamic>;
      messages.add(Message(
        data['content'],
        data['senderChatID'],
        data['receiverChatID'],
      ));
      notifyListeners();
    });
  }

  void sendMessage(String text, String receiverChatID) {
    messages.add(Message(text, current_user_id, receiverChatID));

    print(
      json.encode({
        'receiverChatID': receiverChatID,
        'senderChatID': current_user_id,
        'content': text,
      }),
    );
    socket.emit(
      'send_message',
      json.encode({
        'receiverChatID': receiverChatID,
        'senderChatID': current_user_id,
        'content': text,
      }),
    );
    notifyListeners();
  }

  List<Message> getMessagesForChatID(String chatID) {
    return messages
        .where((msg) => msg.senderID == chatID || msg.receiverID == chatID)
        .toList();
  }

  List getMessagesForChatID_json(String chatID) {
    List message = [];

    messages.forEach((msg) {
      if (msg.senderID == chatID || msg.receiverID == chatID) {
        message.add({
          "text": msg.text,
          "isMe": (current_user_id == msg.senderID),
          "createdAt": '2:30 PM',
        });
      }
    });

    return message;
  }
}
