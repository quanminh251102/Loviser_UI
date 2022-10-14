import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:loviser/pages/verify_page.dart';
import 'package:loviser/providers/login.dart';
import '../pages/login_page.dart';
import '../widgets/custom_intl_phone_field/intl_phone_field.dart';

class Forget_pass extends StatefulWidget {
  const Forget_pass({Key? key}) : super(key: key);

  @override
  State<Forget_pass> createState() => _Forget_passState();
}

class _Forget_passState extends State<Forget_pass>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final mediaHeight = !isLandscape
        ? MediaQuery.of(context).size.height
        : MediaQuery.of(context).size.height * 2;

    // handle status bar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      //color set to transperent or set your own color
      statusBarIconBrightness: Brightness.dark,
      //set brightness for icons, like dark background light icons
    ));

    final statusBarHeight = MediaQuery.of(context).viewPadding.top;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Container(
                padding: EdgeInsets.fromLTRB(0, statusBarHeight, 0, 0),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_ios)),
                    ),
                    const Text(
                      'LOVISER',
                      style: TextStyle(
                          color: Color(0xFF356899),
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: mediaHeight * 0.04),
                    const Text(
                      'Quên mật khẩu',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: mediaHeight * 0.04),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: const Text(
                        'Nhập email hoặc số điện thoại của bạn, chúng tôi sẽ gửi cho bạn mã xác minh',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: mediaHeight * 0.04),
                    Image.asset('assets/images/forget_icon.gif',
                        width: 150, height: 120),
                    SizedBox(height: mediaHeight * 0.04),
                    DefaultTabController(
                      length: 2,
                      initialIndex: 0,
                      child: Column(
                        children: <Widget>[
                          CustomCard(
                            childPadding: 10,
                            borderRadius: 25,
                            elevation: 0,
                            color: Color(0xFFF2F6FD),
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: TabBar(
                              indicator: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              labelColor: Colors.black,
                              tabs: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Tab(
                                    text: 'Email',
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Tab(
                                    text: 'Số điện thoại',
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: mediaHeight * 0.2,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: TabBarView(children: <Widget>[
                                Container(
                                  child: Center(
                                    child: CustomCard(
                                      elevation: 0,
                                      child: TextField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        textInputAction: TextInputAction.done,
                                        decoration: InputDecoration(
                                            iconColor: Colors.grey,
                                            hintText: 'Email',
                                            prefixIcon: Icon(Icons.mail),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: mediaHeight * 0.2,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: CustomCard(
                                    elevation: 0,
                                    child: Center(
                                      child: IntlPhoneField(
                                        textAlign: TextAlign.right,
                                        decoration: InputDecoration(
                                            counter: Offstage(),
                                            labelText: 'Số điện thoại',
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            )),
                                        initialCountryCode: 'VN',
                                        showDropdownIcon: true,
                                        dropdownIconPosition:
                                            IconPosition.trailing,
                                        onChanged: (phone) {
                                          print(phone.completeNumber);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: mediaHeight * 0.04),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
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
                            'Gửi mã xác minh',
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
                                builder: (context) => Verify_Page()),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
