import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:loviser/pages/follow_the_post_page.dart';
import 'package:loviser/pages/job_edit_page.dart';
import 'package:loviser/values/app_color.dart';
import '../pages/job_edit_page.dart';

class PostSuccess extends StatefulWidget {
  const PostSuccess({Key? key}) : super(key: key);

  @override
  State<PostSuccess> createState() => _PostSuccessState();
}

class _PostSuccessState extends State<PostSuccess> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final PreferredSizeWidget appBar = AppBar(
        centerTitle: true,
        title: const Text('XÁC NHẬN',
            style: TextStyle(
                color: Color(0xFF0D0D26),
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        elevation: 0.0,
        backgroundColor: const Color(0xFFF9F9F9),
        leading: Container(
          margin: const EdgeInsets.fromLTRB(24, 0, 0, 0),
          child: IconButton(
            padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
            alignment: Alignment.center,
            onPressed: () {
              print('Exit Job Type Freelancer page');
              Navigator.pop(context);
            },
            icon: const Image(
                image: AssetImage('assets/images/searchResult_left.png')),
          ),
        ));
    return Scaffold(
      backgroundColor: const Color(0xFFFFAFAFD),
      appBar: appBar,
      body: Column(
        children: [
          Container(
            color: Color(0xffFFFFFF),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/avt_nltn.png'),
                    radius: 20,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Trọng Nhân',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Thất tình',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'Giá: 200k/tuần',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: Image(image: AssetImage('assets/images/done.gif')),
                ),
                const SizedBox(height: 5),
                const Text(
                  'CHÚC MỪNG!',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Bài đăng tìm freelancer tư vấn cho vấn đề của bạn đã được đăng thành công. Hãy theo dõi bài đăng của bạn thường xuyên để chọn ra freelancer phù hợp nhất!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 30),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: AppColor.primarycolor,
                    minimumSize: Size(400, 56),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const FollowPost(),
                      ),
                    );
                  },
                  child: const Text(
                    'Theo dõi bài đăng',
                    style: TextStyle(
                      fontFamily: 'Poppins-Regular',
                      fontSize: 16,
                      color: AppColor.whitecolor,
                    ),
                  ),
                ),
                const SizedBox(height: 9),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xffF5F7FA),
                    minimumSize: Size(400, 56),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Xem bài đăng',
                    style: TextStyle(
                      fontFamily: 'Poppins-Regular',
                      fontSize: 16,
                      color: Color(0xff243656),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
