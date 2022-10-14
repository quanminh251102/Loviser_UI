import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loviser/pages/reset_pass_page.dart';

class Verify_Page extends StatefulWidget {
  const Verify_Page({Key? key}) : super(key: key);

  @override
  State<Verify_Page> createState() => _Verify_PageState();
}

class _Verify_PageState extends State<Verify_Page> {
  @override
  
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final mediaHeight = !isLandscape
        ? MediaQuery.of(context).size.height
        : MediaQuery.of(context).size.height * 1.2;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.fromLTRB(0, statusBarHeight, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  children: <Widget>[
                Container(
                      width: MediaQuery.of(context).size.width *
                                          0.9,
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_ios)),
                    ),
                Container(
                child: Column(
                  children: <Widget>[
                    const Text(
                      'LOVISER',
                      style: TextStyle(
                          color: Color(0xFF356899),
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                        height: mediaHeight * 0.04),
                    const Text(
                      'Quên mật khẩu',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                        height: mediaHeight * 0.04),
                    Container(
                      width: MediaQuery.of(context).size.width *
                                          0.9,
                      child: const Text(
                        'Nhập mã xác minh của bạn từ email hoặc số điện thoại mà chúng tôi đã gửi',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                            height:
                                mediaHeight * 0.02),
                    MediaQuery.of(context).viewInsets.bottom == 0 && MediaQuery.of(context).orientation == Orientation.portrait 
                        ? Image(
                            image:
                                AssetImage('assets/images/forget_icon.png'))
                        : SizedBox(
                            height:
                                mediaHeight * 0.01),
                    SizedBox(
                        height: mediaHeight * 0.04),
                    Container(
                      height: mediaHeight * 0.1,
                      width: MediaQuery.of(context).size.width *
                                          0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.15,
                            height: mediaHeight * 0.1,
                            child: TextField(
                              inputFormatters: [
                                new LengthLimitingTextInputFormatter(1),
                              ],
                              textInputAction: TextInputAction.next,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10))),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.15,
                            height: mediaHeight * 0.1,
                            child: TextField(
                              inputFormatters: [
                                new LengthLimitingTextInputFormatter(1),
                              ],
                              textInputAction: TextInputAction.next,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10))),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.15,
                            height: mediaHeight * 0.1,
                            child: TextField(
                              inputFormatters: [
                                new LengthLimitingTextInputFormatter(1),
                              ],
                              textInputAction: TextInputAction.next,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10))),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.15,
                            height: mediaHeight * 0.1,
                            child: TextField(
                              inputFormatters: [
                                new LengthLimitingTextInputFormatter(1),
                              ],
                              textInputAction: TextInputAction.done,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10))),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: mediaHeight * 0.2,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width *
                                          0.9,
                        height: mediaHeight * 0.08,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(213, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              primary: const Color(0xFFEC1C24),
                              onPrimary: Colors.white),
                          child: const FittedBox(
                            child: Text(
                              'Xác minh',
                              style: TextStyle(
                                //height: 26,
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResetPass()),
                          );
                        },
                        ),)
                  ],
                ),
                ),
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
