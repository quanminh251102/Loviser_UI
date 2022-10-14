import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:loviser/pages/job_type_freelancer_page.dart';
import 'package:loviser/pages/login_page.dart';
import 'package:loviser/pages/welcome3_page.dart';
import 'package:loviser/values/app_color.dart';

class Welcome2Page extends StatelessWidget {
  const Welcome2Page({Key? key}) : super(key: key);

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
                  child: Image.asset('assets/images/welcome2.gif'),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Công việc đa dạng',
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
                    'Danh sách công việc bao gồm rất nhiều nhiệm vụ của người thuê vì vậy bạn có thể tìm được công việc tốt nhất cho mình.',
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
                const SizedBox(height: 30),
                Image.asset('assets/images/Indexing_2.png',
                    width: 78, height: 8),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(7, 0, 0, 30),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              minimumSize: Size(158, 56),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                              );
                            },
                            child: const Text(
                              'Bỏ qua',
                              style: TextStyle(
                                fontFamily: 'Poppins-Regular',
                                fontSize: 16,
                                color: AppColor.titletextcolor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 7, 30),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: AppColor.primarycolor,
                              minimumSize: Size(158, 56),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Welcome3Page()),
                              );
                            },
                            child: const Text(
                              'Tiếp tục',
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
