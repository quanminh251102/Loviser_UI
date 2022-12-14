import 'package:flutter/material.dart';
import 'package:loviser/pages/reset_pass_confirm_page.dart';

class ResetPass extends StatefulWidget {
  const ResetPass({Key? key}) : super(key: key);

  @override
  State<ResetPass> createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  bool isPasswordVisibleOld = false;
  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final mediaHeight = !isLandscape
        ? MediaQuery.of(context).size.height
        : MediaQuery.of(context).size.height * 1.2;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
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
                      Center(
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              const Text(
                                'LOVISER',
                                style: TextStyle(
                                    color: Color(0xFF356899),
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: mediaHeight * 0.04),
                              const Text(
                                '?????t l???i m???t kh???u',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: mediaHeight * 0.04),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: const Text(
                                  'Nh???p m???t kh???u m???i c???a b???n v?? x??c nh???n m???t kh???u m???i ????? ?????t l???i m???t kh???u',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              MediaQuery.of(context).viewInsets.bottom == 0 &&
                                      MediaQuery.of(context).orientation ==
                                          Orientation.portrait
                                  ? SizedBox(height: mediaHeight * 0.15)
                                  : SizedBox(height: mediaHeight * 0.05),
                              Container(
                                height: mediaHeight * 0.2,
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height: mediaHeight * 0.1,
                                      child: TextField(
                                        obscureText: isPasswordVisibleOld,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                            hintText: 'M???t kh???u m???i',
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
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height: mediaHeight * 0.1,
                                      child: TextField(
                                        obscureText: isPasswordVisibleOld,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                            hintText: 'X??c nh???n m???t kh???u m???i',
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
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              MediaQuery.of(context).viewInsets.bottom == 0 &&
                                      MediaQuery.of(context).orientation ==
                                          Orientation.portrait
                                  ? SizedBox(height: mediaHeight * 0.2)
                                  : SizedBox(height: mediaHeight * 0.1),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: mediaHeight * 0.08,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(213, 50),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                      ),
                                      primary: const Color(0xFFEC1C24),
                                      onPrimary: Colors.white),
                                  child: FittedBox(
                                    child: const Text(
                                      '?????t l???i m???t kh???u',
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
                                          builder: (context) =>
                                              ResetPassConfirm()),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
