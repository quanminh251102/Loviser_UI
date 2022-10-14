import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:loviser/providers/page/message_page/message_page_provider.dart';
import '../../../providers/page/message_page/user.dart';
import '../../../utils/handle_string.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, required this.received_user}) : super(key: key);

  final User received_user;
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

/*
  List messages = [
    {
      "text": 'Hello',
      "isMe": false,
      "createdAt": '2:30 PM',
    },
    {
      "text": 'How are you?',
      "isMe": true,
      "createdAt": '2:31 PM',
    },
    {
      "text": 'ok, cool 😀',
      "isMe": false,
      "createdAt": '2:32 PM',
    }
  ];
  */

  @override
  Widget build(BuildContext context) {
    final messages = Provider.of<MessagePageProvider>(context, listen: true)
        .getMessagesForChatID_json(widget.received_user.chatID);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Row(
          children: [
            const CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1657299170222-1c67dc056b70?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHw2fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=800&q=60'),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  HandleString.validateForLongStringWithLim(
                    widget.received_user.name,
                    10,
                  ),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                Text(
                  'Online',
                  style: TextStyle(
                    color: Color(0xFF7C7C7C),
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.call,
              color: Color(0xFF229D1F),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.video_call_sharp,
              color: Color(0xFF229D1F),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20,
        ),
        child: ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: messages.length,
          itemBuilder: (context, index) {
            return messages[index]["isMe"]
                ? Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 250),
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xff1972F5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        messages[index]["text"],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  )
                : Row(
                    children: [
                      const CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1657299170222-1c67dc056b70?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHw2fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=800&q=60'),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        constraints: const BoxConstraints(maxWidth: 250),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 225, 231, 236),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          messages[index]["text"],
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  );
          },
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
          ),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Color(0xFFE8EAF3),
              ),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 100,
                decoration: BoxDecoration(
                    color: const Color(0xFFE8FDF2),
                    borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.all(12),
                child: const Text(
                  'Bắt đầu tư vấn',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0E9D57),
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Viết tin nhắn',
                  ),
                ),
              ),
              IconButton(
                splashRadius: 20,
                icon: const Icon(
                  Icons.send,
                  color: Colors.blue,
                ),
                onPressed: () {
                  setState(() {
                    /*
                    messages.add({
                      "isMe": true,
                      "text": _controller.text,
                    });
                    */
                    Provider.of<MessagePageProvider>(context, listen: false)
                        .sendMessage(
                            _controller.text, widget.received_user.chatID);

                    _controller.text = "";
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
