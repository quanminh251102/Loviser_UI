import 'package:flutter/material.dart';

class ColorInPage {
  static const blackColor = Color(0xFF0D0D26);
  static const backgroudColor = Color(0xFFF9F9F9);
  // static const backgroudColor = Color(0xFFFAFAFD);
  static const textColor = Color(0xFF150B3D);
}

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({Key? key}) : super(key: key);

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  late bool isPasswordVisibleOld;
  TextEditingController controllerOld = TextEditingController();

  bool isPasswordVisibleNew = false;
  TextEditingController controllerNew = TextEditingController();

  bool isPasswordVisibleRepeat = false;
  TextEditingController controllerRepeat = TextEditingController();

  @override
  void initState() {
    super.initState();

    controllerOld.text = '123456';
    controllerNew.text = '123456';
    controllerRepeat.text = '123456';

    isPasswordVisibleOld = true;
    isPasswordVisibleNew = true;
    isPasswordVisibleRepeat = true;

    print('Init Update Password Page');
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = AppBar(
        elevation: 0.0,
        backgroundColor: ColorInPage.backgroudColor,
        leading: Container(
          margin: const EdgeInsets.fromLTRB(24, 0, 0, 0),
          child: IconButton(
            padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
            alignment: Alignment.centerLeft,
            onPressed: () {
              print('Exit update password page');
              Navigator.pop(context);
            },
            icon: const Image(image: AssetImage('assets/images/arrow.png')),
          ),
        ));

    return Scaffold(
      backgroundColor: ColorInPage.backgroudColor,
      // backgroundColor: Colors.green,
      appBar: appBar,
      body: SingleChildScrollView(
          child: Container(
        margin: const EdgeInsets.fromLTRB(24, 12, 24, 24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            'Đổi mật khẩu',
            style: TextStyle(
                color: Color(0xFF150A33),
                fontSize: 20,
                fontFamily: 'DMSans',
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'Mật khẩu cũ',
            style: TextStyle(
                color: Color(0xFF150A33),
                fontSize: 15,
                fontFamily: 'DMSans',
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            style: const TextStyle(color: Color(0xFF524B6B), wordSpacing: 2),
            cursorColor: ColorInPage.textColor,
            controller: controllerOld,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (text) {
              if (text == null || text.isEmpty) {
                return 'Vui lòng nhập mật khẩu';
              }
              if (text.length < 4) {
                return 'Mật khẩu phải có ít nhất 4 kí tự';
              }
              return null;
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              suffixIcon: IconButton(
                icon: isPasswordVisibleOld
                    ? const Image(
                        color: Color(0xFF60778C),
                        width: 24,
                        height: 24,
                        image: AssetImage('assets/images/eyeOff.png'))
                    : const Image(
                        color: Color(0xFF60778C),
                        width: 24,
                        height: 24,
                        image: AssetImage('assets/images/eyeOn.png')),
                onPressed: () => setState(
                    () => isPasswordVisibleOld = !isPasswordVisibleOld),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            obscureText: isPasswordVisibleOld,
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'Mật khẩu mới',
            style: TextStyle(
                color: Color(0xFF150A33),
                fontSize: 15,
                fontFamily: 'DMSans',
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            style: const TextStyle(color: Color(0xFF524B6B), wordSpacing: 2),
            cursorColor: ColorInPage.textColor,
            controller: controllerNew,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (text) {
              if (text == null || text.isEmpty) {
                return 'Vui lòng nhập mật khẩu';
              }
              if (text.length < 4) {
                return 'Mật khẩu phải có ít nhất 4 kí tự';
              }
              return null;
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              suffixIcon: IconButton(
                icon: isPasswordVisibleNew
                    ? const Image(
                        color: Color(0xFF60778C),
                        width: 24,
                        height: 24,
                        image: AssetImage('assets/images/eyeOff.png'))
                    : const Image(
                        color: Color(0xFF60778C),
                        width: 24,
                        height: 24,
                        image: AssetImage('assets/images/eyeOn.png')),
                onPressed: () => setState(
                    () => isPasswordVisibleNew = !isPasswordVisibleNew),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            obscureText: isPasswordVisibleNew,
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'Xác nhận mật khẩu',
            style: TextStyle(
                color: Color(0xFF150A33),
                fontSize: 15,
                fontFamily: 'DMSans',
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            style: const TextStyle(color: Color(0xFF524B6B), wordSpacing: 2),
            cursorColor: ColorInPage.textColor,
            controller: controllerRepeat,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (text) {
              if (text == null || text.isEmpty) {
                return 'Vui lòng nhập mật khẩu';
              }
              if (text.length < 4) {
                return 'Mật khẩu phải có ít nhất 4 kí tự';
              }
              return null;
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              suffixIcon: IconButton(
                icon: isPasswordVisibleRepeat
                    ? const Image(
                        color: Color(0xFF60778C),
                        width: 24,
                        height: 24,
                        image: AssetImage('assets/images/eyeOff.png'))
                    : const Image(
                        color: Color(0xFF60778C),
                        width: 24,
                        height: 24,
                        image: AssetImage('assets/images/eyeOn.png')),
                onPressed: () => setState(
                    () => isPasswordVisibleRepeat = !isPasswordVisibleRepeat),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            obscureText: isPasswordVisibleRepeat,
          ),
          !isLandscape
              ? const SizedBox(height: 200)
              : const SizedBox(height: 100),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  shadowColor: Colors.transparent,
                  minimumSize: const Size(213, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  primary: const Color(0xFFEC1C24),
                  onPrimary: Colors.white),
              child: const FittedBox(
                child: Text(
                  'THAY ĐỔI',
                  style: TextStyle(
                      //height: 26,
                      letterSpacing: 2,
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'DMSans',
                      fontWeight: FontWeight.w700),
                ),
              ),
              onPressed: () {
                print('Event: Change password');
                print('Old password: ${controllerOld.text}');
                print('New password: Change password ${controllerNew.text}');
                print(
                    'Repeat new pass word: Change password ${controllerRepeat.text}');
              },
            ),
          ),
        ]),
      )),
    );
  }
}
