import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:loviser/pages/home_page.dart';
import 'package:loviser/pages/job_type_problem_page.dart';
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

final allRowContent = [
  RowContent(
      isSelected: false,
      iconLeadingURL: 'assets/images/love sick.png',
      content: 'Thất tình',
      itemFunction: (ctxRoot) {
        print('chose to love sick');
      }),
  RowContent(
      isSelected: false,
      iconLeadingURL: 'assets/images/flirt.png',
      content: 'Tán tỉnh',
      itemFunction: (ctxRoot) {
        print('chose to flirt');
      }),
  RowContent(
      isSelected: false,
      iconLeadingURL: 'assets/images/maintain.png',
      content: 'Duy trì',
      itemFunction: () {
        print('chose to maintain');
      }),
  RowContent(
      isSelected: false,
      iconLeadingURL: 'assets/images/feeling.png',
      content: 'Cảm xúc',
      itemFunction: () {
        print('chose to feeling');
      }),
  RowContent(
      isSelected: false,
      iconLeadingURL: 'assets/images/sad.png',
      content: 'Buồn',
      itemFunction: () {
        print('chose to sad');
      }),
  RowContent(
      isSelected: false,
      iconLeadingURL: 'assets/images/other.png',
      content: 'Khác',
      itemFunction: () {
        print('chose to other');
      }),
];

List<RowContent> selectedContent = [];

class JobTypeFreelancer extends StatefulWidget {
  const JobTypeFreelancer({Key? key}) : super(key: key);

  @override
  State<JobTypeFreelancer> createState() => _JobTypeFreelancerState();
}

class _JobTypeFreelancerState extends State<JobTypeFreelancer> {
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
                          'Bạn là freelancer? Bạn đang tìm vấn đề tình cảm nào để tư vấn',
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
              const SizedBox(height: 7),
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
                          height: 16,
                          image: AssetImage(allRowContent[i].iconLeadingURL)),
                      title: Text(
                        allRowContent[i].content,
                        style: const TextStyle(
                            color: Color(0xff0D0D26),
                            fontFamily: 'DMSans',
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
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
                                });
                              },
                            ),
                      onTap: () {
                        setState(() {
                          allRowContent[i].isSelected =
                              !allRowContent[i].isSelected;
                          if (allRowContent[i].isSelected == true) {
                          } else if (allRowContent[i].isSelected == false) {}
                        });
                      },
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 10),
              if (allRowContent[5].isSelected == true) ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(35, 0, 0, 0),
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: 'Nhập vấn đề khác',
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 2, color: Colors.blue),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 3, color: Colors.red),
                          borderRadius: BorderRadius.circular(15),
                        )),
                  ),
                ),
              ],
              const SizedBox(height: 17),
              Center(
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              minimumSize: const Size(158, 56),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => JobTypeProblem()),
                              );
                            },
                            child: const Text(
                              'Bỏ qua',
                              style: TextStyle(
                                fontFamily: 'Poppins-Regular',
                                fontSize: 16,
                                color: Color(0xff95969D),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(0xffEC1C24),
                              minimumSize: const Size(158, 56),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()),
                              );
                            },
                            child: const Text(
                              'Lưu',
                              style: TextStyle(
                                fontFamily: 'Poppins-Regular',
                                fontSize: 16,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
