import 'package:flutter/material.dart';
import 'package:loviser/modules/profile/pages/chat_page.dart';
import 'package:loviser/providers/page/message_page/message_page_provider.dart';
import 'package:loviser/widgets/item_message.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../config/config.dart';
import 'package:provider/provider.dart';

class MessagePage extends StatefulWidget {
  MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    print('Init message page');
    /*
    IO.Socket socket = IO.io(
      urlSocket_test_local_kiet,
      IO.OptionBuilder()
          .setTransports(['websocket']).setQuery({'username': '1'}).build(),
    );

    socket.onConnect((_) {
      print('connect');
      socket.emit('msg', 'test');
    });

    socket.on('event', (data) => print(data));
    socket.onDisconnect((_) => print('disconnect'));
    socket.on('fromServer', (_) => print(_));
    */
    Provider.of<MessagePageProvider>(context, listen: false).init();
  }

  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<MessagePageProvider>(context).fetchAndSetUsers().then((_) {
        setState(() {
          _isLoading = false;
        });
      });

      setState(() {
        _isLoading = true;
      });

      Provider.of<MessagePageProvider>(context).fetchAndSetMessages().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final friendList =
        Provider.of<MessagePageProvider>(context, listen: true).friendList;

    final pageBody_old = SizedBox(
      width: double.infinity,
      child: StreamBuilder(
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: [
                Row(
                  children: [
                    const Text(
                      'Tin nhắn',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
                // ListView.builder(
                //   itemCount: 1,
                //   itemBuilder: (context, index) {
                //     return ItemMessage(
                //       received_user: friendList[index],
                //     );
                //   },
                // ),
              ],
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListView(
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Tin nhắn',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/images/Search.png',
                          color: Colors.red,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/images/edit-square.png',
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: const Color(0xFFAFB0B6),
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/Search.png',
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Search a chat or message',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  // InkWell(
                  //   onTap: () => Navigator.of(context).push(
                  //     MaterialPageRoute(
                  //       builder: (_) => const ChatPage(),
                  //     ),
                  //   ),
                  //   child: ItemMessage(),
                  // ),

                  // ItemMessage(
                  //   received_user: friendList[0],
                  // ),

                  // ListView.builder(
                  //   itemCount: friendList.length,
                  //   itemBuilder: (context, index) {
                  //     return ItemMessage(
                  //       received_user: friendList[index],
                  //     );
                  //   },
                  // ),
                ],
              ),
            );
            // return Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Image.asset('assets/images/no_message.png'),
            //     const SizedBox(height: 25),
            //     const Text(
            //       'Không có tin nhắn',
            //       style: TextStyle(
            //         fontSize: 16,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //     const SizedBox(height: 30),
            //     const Text(
            //       'Bạn hiện không có tin nhắn đến',
            //       style: TextStyle(
            //         fontSize: 15,
            //       ),
            //     ),
            //     const SizedBox(height: 30),
            //     ElevatedButton(
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor: Colors.red,
            //       ),
            //       onPressed: () {},
            //       child: const Padding(
            //         padding: EdgeInsets.symmetric(
            //           horizontal: 8.0,
            //           vertical: 12,
            //         ),
            //         child: Text('SOẠN TIN NHẮN MỚI'),
            //       ),
            //     ),
            //   ],
            // );
          }
        }),
      ),
    );

    final pageBody_new = SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Tin nhắn',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    'assets/images/Search.png',
                    color: Colors.red,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    'assets/images/edit-square.png',
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(
                  color: const Color(0xFFAFB0B6),
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/Search.png',
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search a chat or message',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            for (int index = 0; index < friendList.length; index++) ...[
              ItemMessage(received_user: friendList[index]),
            ],
          ],
        ),
      ),
    );

    return Scaffold(
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : pageBody_new);
  }
}
