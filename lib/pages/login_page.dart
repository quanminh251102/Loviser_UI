import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loviser/pages/forget_password_page.dart';
import 'package:loviser/pages/sign_up_page.dart';
import 'package:loviser/providers/authentication.dart';
import 'package:loviser/providers/page/message_page/message_page_provider.dart';
import 'package:loviser/widgets/custom_dialog/progress_dialog.dart';
import '../widgets/custom_divider/custom_divider_widget.dart';
import '../widgets/social_icon/social_icon.dart';
import '../pages/sign_up_page.dart';
import '../main.dart';
import '../config/config.dart';
import 'package:http/http.dart';
import '../widgets/custom_dialog/success_dialog.dart';
import '../widgets/custom_dialog/fail_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isPasswordVisibleOld = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  late bool _isLoading = false;

  void validateAndSave() {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      print('Form is valid');
      print(email.text);
      print(password.text);
    } else {
      print('Form is invalid');
    }
  }

  void saveAccount(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    prefs.setString('password', password);
  }

  @override
  Widget build(BuildContext context) {
    void handleOnPressLogin() async {
      try {
        if (_isLoading) return;
        setState(() {
          _isLoading = true;
        });
        Response response = await post(
          Uri.parse(urlLogin),
          body: {'username': email.text, 'password': password.text},
        );
        if (response.statusCode == 200) {
          final extractedData =
              json.decode(response.body) as Map<String, dynamic>;
          if (extractedData == null) {
            return;
          }
          print(extractedData["userid"]);

          Provider.of<MessagePageProvider>(context, listen: false)
              .setCurrentUserId(extractedData["userid"]);

          print(email.text);
          print(password.text);
          await Future.delayed(const Duration(seconds: 1));
          if (!mounted) return;
          saveAccount(email.text, password.text);
          showDialog(
              
              context: context,
             
              builder: (BuildContext context) => LoginSuccessDialog());

          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => MainPage(),
          //   ),
          // );
        } else {
          showDialog(
              
              context: context,
             
              builder: (BuildContext context) => LoginFailDialog());
        }
        setState(() {
          _isLoading = false;
        });
      } catch (e) {
        print(e);
      }
    }

    void handleOnPressSignUp() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SignUp(),
        ),
      );
    }

    Size padding = MediaQuery.of(context).size;
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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Center(
            child: Container(
                padding: EdgeInsets.fromLTRB(0, statusBarHeight, 0, 0),
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'LOVISER',
                          style: TextStyle(
                              color: Color(0xFF356899),
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: padding.height * 0.01),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: const Text(
                          'Chào mừng đã trở lại',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, padding.height * 0.01,
                              0, padding.height * 0.02),
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: const Text(
                                'Loviser nền tảng việc làm tự do về tình cảm đầu tiên tại Việt Nam',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              )),
                        ),
                      ],
                    ),
                    Form(
                      key: _formKey,
                      child: Column(children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: mediaHeight * 0.12,
                          child: TextFormField(
                              controller: email,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                hintText: 'Email',
                                prefixIcon: Icon(Icons.mail),
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Điền email!";
                                } else {
                                  return null;
                                }
                              }),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: mediaHeight * 0.12,
                          child: TextFormField(
                              controller: password,
                              obscureText: isPasswordVisibleOld,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                  hintText: 'Mật khẩu',
                                  prefixIcon: Icon(Icons.key),
                                  suffixIcon: IconButton(
                                    icon: isPasswordVisibleOld
                                        ? const Image(
                                            color: Color(0xFF60778C),
                                            width: 24,
                                            height: 24,
                                            image: AssetImage(
                                                'assets/images/eyeOff.png'))
                                        : const Image(
                                            color: Color(0xFF60778C),
                                            width: 24,
                                            height: 24,
                                            image: AssetImage(
                                                'assets/images/eyeOn.png')),
                                    onPressed: () => setState(() =>
                                        isPasswordVisibleOld =
                                            !isPasswordVisibleOld),
                                  ),
                                  border: OutlineInputBorder()),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Điền mật khẩu!";
                                } else {
                                  return null;
                                }
                              }),
                        ),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: padding.height * 0.02),
                      child: InkWell(
                        onTap: () {
                          print(email.text);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: mediaHeight * 0.06,
                          // child: RoundedButton(
                          //   text: "Đăng nhập",
                          //   press: (){
                          //     print('lalalalalala');
                          //   },
                          //   color: Colors.red,
                          //   textColor: Colors.white,
                          // ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(213, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                primary: const Color(0xFFEC1C24),
                                onPrimary: Colors.white),
                            child: FittedBox(
                              child: _isLoading
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 4,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        const Text(
                                          'Đang tải...',
                                          style: TextStyle(
                                            //height: 26,
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    )
                                  : const Text(
                                      'Đăng nhập',
                                      style: TextStyle(
                                        //height: 26,
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                            ),
                            onPressed: handleOnPressLogin,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: mediaHeight * 0.1,
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Forget_pass()),
                            );
                          },
                          child: const Text(
                            'Quên mật khẩu?',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                        height: mediaHeight * 0.1,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: OrDivider()),
                    Container(
                      height: mediaHeight * 0.1,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SocialIcon(
                            iconSrc: "assets/images/apple.png",
                            press: () {},
                          ),
                          SocialIcon(
                            iconSrc: "assets/images/google.png",
                            press: () {},
                          ),
                          SocialIcon(
                            iconSrc: "assets/images/fb.png",
                            press: () {},
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: mediaHeight * 0.1,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'Bạn chưa có tài khoản?',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()),
                              );
                            },
                            child: const Text(
                              ' Đăng ký',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          )
        ]),
      ),
    );
  }
}
