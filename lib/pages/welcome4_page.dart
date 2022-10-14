import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:loviser/pages/job_type_freelancer_page.dart';
import 'package:loviser/pages/job_type_problem_page.dart';
import 'package:loviser/pages/login_page.dart';
import 'package:loviser/values/app_color.dart';

class Welcome4Page extends StatelessWidget {
  const Welcome4Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizesceen = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Expanded(
            child: Column(
              children: [
                Image.asset('assets/images/Ellipse.png'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Image.asset('assets/images/welcome4.gif'),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Lựa chọn freelancer phù hợp với bạn',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins-Regular',
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'Bạn sẽ xem tất cả những hồ sơ đăng kí được các freelancer gửi về và chọn ra một người để phỏng vấn',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 1.5,
                      fontFamily: 'Poppins-Regular',
                      fontSize: 15,
                      fontWeight: FontWeight.w100,
                      color: AppColor.describetextcolor,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Image.asset('assets/images/Indexing_4.png',
                    width: 78, height: 8),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 7, 30),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Color.fromRGBO(236, 28, 36, 1),
                              minimumSize: Size(295, 56),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                              );
                            },
                            child: const Text(
                              'Bắt đầu',
                              style: TextStyle(
                                fontFamily: 'Poppins-Regular',
                                fontSize: 16,
                                color: AppColor.whitecolor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
