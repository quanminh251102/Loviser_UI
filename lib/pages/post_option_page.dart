import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:loviser/pages/job_type_problem_page.dart';
import 'package:loviser/pages/post_to_find_page.dart';
import 'package:loviser/utils/color.dart';
import 'package:loviser/values/app_color.dart';

class RowContent {
  bool isSelected = false;
  String iconLeadingURL;
  String content;
  Function itemFunction;
  RowContent(
      {required this.isSelected,
      required this.iconLeadingURL,
      required this.content,
      required this.itemFunction});
}

int count1 = 0;
int count0 = 0;
bool isFreePost = true;
final allRowContent = [
  RowContent(
      isSelected: false,
      iconLeadingURL: 'assets/images/free.png',
      content: 'Đăng bài nhờ cộng đồng hỗ trợ miễn phí',
      itemFunction: (ctxRoot) {
        print('chose to post free');
      }),
  RowContent(
      isSelected: false,
      iconLeadingURL: 'assets/images/PosttoFindFreelancers.png',
      content: 'Đăng bài tìm freelancer tư vấn',
      itemFunction: (ctxRoot) {
        print('chose post find');
      }),
];

List<RowContent> selectedContent = [];

class PostOption extends StatefulWidget {
  const PostOption({Key? key}) : super(key: key);

  @override
  State<PostOption> createState() => _PostOptionState();
}

class _PostOptionState extends State<PostOption> {
  Widget itemSwitch(RowContent item, Widget flutterSwitch) {
    return ListTile(
      tileColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      leading: Image(image: AssetImage(item.iconLeadingURL)),
      title: Text(
        item.content,
        style: const TextStyle(
            fontFamily: 'DMSans', fontSize: 12, fontWeight: FontWeight.w400),
      ),
      trailing: Container(
          margin: const EdgeInsets.fromLTRB(24, 0, 0, 0),
          height: 30,
          width: 30,
          child: FittedBox(child: flutterSwitch)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    final PreferredSizeWidget appBar = AppBar(
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
            icon: const Image(image: AssetImage('assets/images/close.png')),
          ),
        ));

    return Scaffold(
      backgroundColor: const Color(0xFFFFAFAFD),
      appBar: appBar,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  child: Column(
                    children: const <Widget>[
                      Text(
                        'LOVISER',
                        style: TextStyle(
                            color: Color(0xFF356899),
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 7),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Chọn giải pháp để tư vấn về vấn đề tình cảm của bạn!',
                          style: TextStyle(
                              color: Color(0xFF0D0D26),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              for (int i = 0; i < allRowContent.length; i++) ...[
                const SizedBox(height: 7),
                Column(
                  children: [
                    ListTile(
                      tileColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      leading: Image(
                          width: 32,
                          height: 31,
                          image: AssetImage(allRowContent[i].iconLeadingURL)),
                      title: Text(
                        allRowContent[i].content,
                        style: const TextStyle(
                            color: Color(0xff0D0D26),
                            fontFamily: 'DMSans',
                            fontSize: 15,
                            fontWeight: FontWeight.w100),
                      ),
                      trailing: allRowContent[i].isSelected
                          ? Checkbox(
                              activeColor: Colors.red,
                              shape: const CircleBorder(),
                              side: const BorderSide(
                                  width: 1, color: Color(0xFFCACBCE)),
                              value: allRowContent[i].isSelected,
                              onChanged: (value) {
                                setState(() {
                                  allRowContent[i].isSelected =
                                      !allRowContent[i].isSelected;
                                  if (allRowContent[1].isSelected ==
                                          allRowContent[0].isSelected &&
                                      count1 >= count0) {
                                    allRowContent[0].isSelected == true;
                                    allRowContent[1].isSelected = false;
                                  }
                                  if (allRowContent[1].isSelected == true) {
                                    allRowContent[1].isSelected == true;
                                    allRowContent[0].isSelected = false;
                                    if (count1 == 1) {
                                      count1 = 0;
                                      count0 = 0;
                                    }
                                    count1++;
                                  }
                                  if (allRowContent[0].isSelected == true) {
                                    allRowContent[0].isSelected == true;
                                    allRowContent[1].isSelected = false;
                                    if (count0 == 1) {
                                      count1 = 0;
                                      count0 = 0;
                                    }
                                    count0++;
                                  }
                                });
                              },
                            )
                          : Checkbox(
                              activeColor: Colors.red,
                              shape: const CircleBorder(),
                              side: const BorderSide(
                                  width: 1, color: Color(0xFFCACBCE)),
                              value: allRowContent[i].isSelected,
                              onChanged: (value) {
                                setState(() {
                                  allRowContent[i].isSelected =
                                      !allRowContent[i].isSelected;
                                  if (allRowContent[1].isSelected ==
                                          allRowContent[0].isSelected &&
                                      count1 >= count0) {
                                    allRowContent[0].isSelected == true;
                                    allRowContent[1].isSelected = false;
                                  }
                                  if (allRowContent[1].isSelected == true) {
                                    allRowContent[1].isSelected == true;
                                    allRowContent[0].isSelected = false;
                                    if (count1 == 1) {
                                      count1 = 0;
                                      count0 = 0;
                                    }
                                    count1++;
                                  }
                                  if (allRowContent[0].isSelected == true) {
                                    allRowContent[0].isSelected == true;
                                    allRowContent[1].isSelected = false;
                                    if (count0 == 1) {
                                      count1 = 0;
                                      count0 = 0;
                                    }
                                    count0++;
                                  }
                                });
                              },
                            ),
                      onTap: () {
                        setState(() {
                          allRowContent[i].isSelected =
                              !allRowContent[i].isSelected;
                          if (allRowContent[1].isSelected ==
                                  allRowContent[0].isSelected &&
                              count1 >= count0) {
                            allRowContent[0].isSelected == true;
                            allRowContent[1].isSelected = false;
                          }
                          if (allRowContent[1].isSelected == true) {
                            allRowContent[1].isSelected == true;
                            allRowContent[0].isSelected = false;
                            if (count1 == 1) {
                              count1 = 0;
                              count0 = 0;
                            }
                            count1++;
                          }
                          if (allRowContent[0].isSelected == true) {
                            allRowContent[0].isSelected == true;
                            allRowContent[1].isSelected = false;
                            if (count0 == 1) {
                              count1 = 0;
                              count0 = 0;
                            }
                            count0++;
                          }
                        });
                      },
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xffEC1C24),
                      minimumSize: const Size(327, 56),
                    ),
                    onPressed: () => {
                      allRowContent[0].isSelected
                          ? _showModalBottomSheetForFreePost()
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PostToFind()),
                            ),
                    },
                    child: const Text(
                      'Tiếp tục',
                      style: TextStyle(
                        fontFamily: 'Poppins-Regular',
                        fontSize: 16,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
      ),
    );
  }

  void _showModalBottomSheetForFeePost() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (builder) {
        final width = MediaQuery.of(context).size.width;
        final height = MediaQuery.of(context).size.height;
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(100.0),
            ),
          ),
          height: height * 0.32,
          child: Column(
            children: [
              const Icon(Icons.remove, size: 40),
              SizedBox(
                width: width * 0.8,
                child: const Text(
                  "Bạn đang gặp vấn đề về chuyện tình cảm? xxx",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF150B3D),
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              SizedBox(
                width: width * 0.6,
                child: const Text(
                  "Đăng vấn đề của bạn và nhờ một freelancer có kinh nghiệm tư vấn!",
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              SizedBox(
                height: 50,
                width: 315,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const PostOption(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  child: const Text(
                    "Đăng vấn đề",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showModalBottomSheetForFreePost() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (builder) {
        final width = MediaQuery.of(context).size.width;
        final height = MediaQuery.of(context).size.height;
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(100.0),
            ),
          ),
          height: height * 0.77,
          child: Column(
            children: [
              const Icon(Icons.remove, size: 40),
              SizedBox(
                width: width * 0.8,
                child: const Text(
                  "Đăng bài miễn phí",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF000000),
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Text(
                "Tiêu đề",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF000000),
                  fontWeight: FontWeight.bold,
                  fontSize: height * 0.025,
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: SizedBox(
                  height: height * 0.08,
                  width: width * 0.9,
                  child: TextField(
                    maxLines: 2,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          left: width * 0.05,
                          top: width * 0.01,
                          bottom: width * 0.01),
                      border: InputBorder.none,
                      hintText:
                          'Ghi ngắn gọn vấn đề tình cảm mà bạn đang gặp phải',
                      hintStyle: TextStyle(
                        color: Colors.grey[600],
                        height: height * 0.002,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.025,
              ),
              Text(
                "Bạn đang gặp vấn đề gì?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF000000),
                  fontWeight: FontWeight.bold,
                  fontSize: height * 0.025,
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: SizedBox(
                  height: height * 0.2,
                  width: width * 0.9,
                  child: TextField(
                    maxLines: 3,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          left: width * 0.05,
                          top: width * 0.01,
                          bottom: width * 0.01),
                      border: InputBorder.none,
                      hintText:
                          'Hãy viết vấn đề bạn đang gặp phải tại đây, cộng đồng người dùng LOVISER sẽ giúp bạn giải quyết.',
                      hintStyle: TextStyle(
                        color: Colors.grey[600],
                        height: height * 0.002,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: height * 0.035),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFFEC1C24),
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(20),
                        ),
                        child: const Icon(Icons.camera_alt),
                      ),
                      SizedBox(
                        height: height * 0.007,
                      ),
                      Text(
                        "Thêm ảnh của bạn",
                        style: TextStyle(
                            color: const Color(0xFF000000),
                            fontSize: height * 0.015,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              SizedBox(
                height: height * 0.065,
                width: width * 0.9,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const PostOption(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  child: const Text(
                    "Đăng",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
