import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:loviser/pages/job_type_problem_page.dart';
import 'package:loviser/pages/post_success_page.dart';
import 'package:loviser/utils/color.dart';
import 'package:loviser/values/app_color.dart';
import 'package:image_picker/image_picker.dart';

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

Widget titleTag() => TextField(
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffF2F2F3)),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffF2F2F3)),
          borderRadius: BorderRadius.circular(15),
        ),
        hintText:
            "Ghi ngắn gọn và chọn ra vấn đề mà bạn đang gặp phải, nhập dấu phẩy sau mỗi thẻ",
        hintStyle: TextStyle(color: Color(0xff616161)),
        filled: true,
        fillColor: Color(0xffF2F2F3),
      ),
      maxLines: 5,
      minLines: 1,
    );

Widget describe() => TextField(
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffF2F2F3)),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffF2F2F3)),
          borderRadius: BorderRadius.circular(15),
        ),
        hintText:
            "Đây là cách bạn tìm ra freelancer mà bạn cần. Bao gồm kỳ vọng của bạn về nhiệm vụ hoặc khả năng có thể tư vấn",
        hintStyle: TextStyle(color: Color(0xff616161)),
        filled: true,
        fillColor: Color(0xffF2F2F3),
      ),
      maxLines: 100,
      minLines: 1,
    );

int count0 = 0;
int count1 = 0;
int count2 = 0;
int count3 = 0;
int count4 = 0;

final allRowContent = [
  RowContent(
      isSelected: false,
      iconLeadingURL: 'assets/images/all_in_one.png',
      content: 'Trọn gói',
      itemFunction: (ctxRoot) {
        print('chose to post free');
      }),
  RowContent(
      isSelected: false,
      iconLeadingURL: 'assets/images/hourly.png',
      content: 'Theo giờ',
      itemFunction: (ctxRoot) {
        print('chose post find');
      }),
  RowContent(
      isSelected: false,
      iconLeadingURL: 'assets/images/day.png',
      content: 'Theo ngày',
      itemFunction: (ctxRoot) {
        print('chose to post free');
      }),
  RowContent(
      isSelected: false,
      iconLeadingURL: 'assets/images/month.png',
      content: 'Theo tháng',
      itemFunction: (ctxRoot) {
        print('chose post find');
      }),
  RowContent(
      isSelected: false,
      iconLeadingURL: 'assets/images/year.png',
      content: 'Theo năm',
      itemFunction: (ctxRoot) {
        print('chose post find');
      }),
];

List<RowContent> selectedContent = [];

class PostToFind extends StatefulWidget {
  const PostToFind({Key? key}) : super(key: key);

  @override
  State<PostToFind> createState() => _PostToFindState();
}

class _PostToFindState extends State<PostToFind> {
  late bool isDealPriceValueError = true;
  TextEditingController controller = TextEditingController();
  File? imageFile;
  ImagePicker image = ImagePicker();
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
        centerTitle: true,
        title: const Text('ĐĂNG BÀI TÌM FREELANCER',
            style: TextStyle(
                color: Color(0xFF0D0D26),
                fontSize: 20,
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Thẻ tiêu đề',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Poppins-Regular',
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 10),
            titleTag(),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Mô tả',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Poppins-Regular',
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 10),
            describe(),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Đính kèm ảnh',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Poppins-Regular',
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              if (imageFile != null)
                Container(
                  width: 640,
                  height: 480,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    image: DecorationImage(
                        image: FileImage(imageFile!), fit: BoxFit.cover),
                    border: Border.all(width: 8, color: Color(0xffF2F2F3)),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                )
              else
                IconButton(
                  icon: Image.asset('assets/images/upload_image.gif'),
                  iconSize: 250,
                  onPressed: () => getImage(source: ImageSource.gallery),
                ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => getImage(source: ImageSource.camera),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xffEC1C24), // background
                        onPrimary: Color(0xffFFFFFF), // foreground
                      ),
                      child: Text('Chụp ảnh'),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => getImage(source: ImageSource.gallery),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xffEC1C24), // background
                        onPrimary: Color(0xffFFFFFF), // foreground
                      ),
                      child: Text('Chọn ảnh'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              for (int i = 0; i < allRowContent.length; i++) ...[
                Column(
                  children: [
                    ListTile(
                      tileColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      leading: Image(
                          width: 18,
                          height: 18,
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
                                  if (allRowContent[0].isSelected == true) {
                                    //01
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

                                    //02
                                    if (allRowContent[2].isSelected ==
                                            allRowContent[0].isSelected &&
                                        count2 >= count0) {
                                      allRowContent[0].isSelected == true;
                                      allRowContent[2].isSelected = false;
                                    }
                                    if (allRowContent[2].isSelected == true) {
                                      allRowContent[2].isSelected == true;
                                      allRowContent[0].isSelected = false;
                                      if (count2 == 1) {
                                        count2 = 0;
                                        count0 = 0;
                                      }
                                      count2++;
                                    }
                                    if (allRowContent[0].isSelected == true) {
                                      allRowContent[0].isSelected == true;
                                      allRowContent[2].isSelected = false;
                                      if (count0 == 1) {
                                        count2 = 0;
                                        count0 = 0;
                                      }
                                      count0++;
                                    }

                                    //03
                                    if (allRowContent[3].isSelected ==
                                            allRowContent[0].isSelected &&
                                        count3 >= count0) {
                                      allRowContent[0].isSelected == true;
                                      allRowContent[3].isSelected = false;
                                    }
                                    if (allRowContent[3].isSelected == true) {
                                      allRowContent[3].isSelected == true;
                                      allRowContent[0].isSelected = false;
                                      if (count3 == 1) {
                                        count3 = 0;
                                        count0 = 0;
                                      }
                                      count3++;
                                    }
                                    if (allRowContent[0].isSelected == true) {
                                      allRowContent[0].isSelected == true;
                                      allRowContent[3].isSelected = false;
                                      if (count0 == 1) {
                                        count3 = 0;
                                        count0 = 0;
                                      }
                                      count0++;
                                    }

                                    //04
                                    if (allRowContent[4].isSelected ==
                                            allRowContent[0].isSelected &&
                                        count4 >= count0) {
                                      allRowContent[0].isSelected == true;
                                      allRowContent[4].isSelected = false;
                                    }
                                    if (allRowContent[4].isSelected == true) {
                                      allRowContent[4].isSelected == true;
                                      allRowContent[0].isSelected = false;
                                      if (count4 == 1) {
                                        count4 = 0;
                                        count0 = 0;
                                      }
                                      count4++;
                                    }
                                    if (allRowContent[0].isSelected == true) {
                                      allRowContent[0].isSelected == true;
                                      allRowContent[4].isSelected = false;
                                      if (count0 == 1) {
                                        count4 = 0;
                                        count0 = 0;
                                      }
                                      count0++;
                                    }
                                  }
                                  //1
                                  if (allRowContent[1].isSelected == true) {
                                    //12
                                    if (allRowContent[2].isSelected ==
                                            allRowContent[1].isSelected &&
                                        count2 >= count1) {
                                      allRowContent[1].isSelected == true;
                                      allRowContent[2].isSelected = false;
                                    }
                                    if (allRowContent[2].isSelected == true) {
                                      allRowContent[2].isSelected == true;
                                      allRowContent[1].isSelected = false;
                                      if (count2 == 1) {
                                        count2 = 0;
                                        count1 = 0;
                                      }
                                      count2++;
                                    }
                                    if (allRowContent[1].isSelected == true) {
                                      allRowContent[1].isSelected == true;
                                      allRowContent[2].isSelected = false;
                                      if (count1 == 1) {
                                        count2 = 0;
                                        count1 = 0;
                                      }
                                      count1++;
                                    }
                                    //13
                                    if (allRowContent[3].isSelected ==
                                            allRowContent[1].isSelected &&
                                        count3 >= count1) {
                                      allRowContent[1].isSelected == true;
                                      allRowContent[3].isSelected = false;
                                    }
                                    if (allRowContent[3].isSelected == true) {
                                      allRowContent[3].isSelected == true;
                                      allRowContent[1].isSelected = false;
                                      if (count3 == 1) {
                                        count3 = 0;
                                        count1 = 0;
                                      }
                                      count3++;
                                    }
                                    if (allRowContent[1].isSelected == true) {
                                      allRowContent[1].isSelected == true;
                                      allRowContent[3].isSelected = false;
                                      if (count1 == 1) {
                                        count3 = 0;
                                        count1 = 0;
                                      }
                                      count1++;
                                    }

                                    //14
                                    if (allRowContent[4].isSelected ==
                                            allRowContent[1].isSelected &&
                                        count4 >= count1) {
                                      allRowContent[1].isSelected == true;
                                      allRowContent[4].isSelected = false;
                                    }
                                    if (allRowContent[4].isSelected == true) {
                                      allRowContent[4].isSelected == true;
                                      allRowContent[1].isSelected = false;
                                      if (count4 == 1) {
                                        count4 = 0;
                                        count1 = 0;
                                      }
                                      count4++;
                                    }
                                    if (allRowContent[1].isSelected == true) {
                                      allRowContent[1].isSelected == true;
                                      allRowContent[4].isSelected = false;
                                      if (count1 == 1) {
                                        count4 = 0;
                                        count1 = 0;
                                      }
                                      count1++;
                                    }
                                  }

                                  //2
                                  if (allRowContent[2].isSelected == true) {
                                    //24
                                    if (allRowContent[4].isSelected ==
                                            allRowContent[2].isSelected &&
                                        count4 >= count2) {
                                      allRowContent[2].isSelected == true;
                                      allRowContent[4].isSelected = false;
                                    }
                                    if (allRowContent[4].isSelected == true) {
                                      allRowContent[4].isSelected == true;
                                      allRowContent[2].isSelected = false;
                                      if (count4 == 1) {
                                        count4 = 0;
                                        count2 = 0;
                                      }
                                      count4++;
                                    }
                                    if (allRowContent[2].isSelected == true) {
                                      allRowContent[2].isSelected == true;
                                      allRowContent[4].isSelected = false;
                                      if (count2 == 1) {
                                        count4 = 0;
                                        count2 = 0;
                                      }
                                      count2++;
                                    }

                                    //23
                                    if (allRowContent[3].isSelected ==
                                            allRowContent[2].isSelected &&
                                        count3 >= count2) {
                                      allRowContent[2].isSelected == true;
                                      allRowContent[3].isSelected = false;
                                    }
                                    if (allRowContent[3].isSelected == true) {
                                      allRowContent[3].isSelected == true;
                                      allRowContent[2].isSelected = false;
                                      if (count3 == 1) {
                                        count3 = 0;
                                        count2 = 0;
                                      }
                                      count3++;
                                    }
                                    if (allRowContent[2].isSelected == true) {
                                      allRowContent[2].isSelected == true;
                                      allRowContent[3].isSelected = false;
                                      if (count2 == 1) {
                                        count3 = 0;
                                        count2 = 0;
                                      }
                                      count2++;
                                    }
                                  }

                                  //3
                                  if (allRowContent[3].isSelected == true) {
                                    if (allRowContent[4].isSelected ==
                                            allRowContent[3].isSelected &&
                                        count4 >= count3) {
                                      allRowContent[3].isSelected == true;
                                      allRowContent[4].isSelected = false;
                                    }
                                    if (allRowContent[4].isSelected == true) {
                                      allRowContent[4].isSelected == true;
                                      allRowContent[3].isSelected = false;
                                      if (count4 == 1) {
                                        count4 = 0;
                                        count3 = 0;
                                      }
                                      count4++;
                                    }
                                    if (allRowContent[3].isSelected == true) {
                                      allRowContent[3].isSelected == true;
                                      allRowContent[4].isSelected = false;
                                      if (count3 == 1) {
                                        count4 = 0;
                                        count3 = 0;
                                      }
                                      count3++;
                                    }
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
                                  if (allRowContent[0].isSelected == true) {
                                    //01
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

                                    //02
                                    if (allRowContent[2].isSelected ==
                                            allRowContent[0].isSelected &&
                                        count2 >= count0) {
                                      allRowContent[0].isSelected == true;
                                      allRowContent[2].isSelected = false;
                                    }
                                    if (allRowContent[2].isSelected == true) {
                                      allRowContent[2].isSelected == true;
                                      allRowContent[0].isSelected = false;
                                      if (count2 == 1) {
                                        count2 = 0;
                                        count0 = 0;
                                      }
                                      count2++;
                                    }
                                    if (allRowContent[0].isSelected == true) {
                                      allRowContent[0].isSelected == true;
                                      allRowContent[2].isSelected = false;
                                      if (count0 == 1) {
                                        count2 = 0;
                                        count0 = 0;
                                      }
                                      count0++;
                                    }

                                    //03
                                    if (allRowContent[3].isSelected ==
                                            allRowContent[0].isSelected &&
                                        count3 >= count0) {
                                      allRowContent[0].isSelected == true;
                                      allRowContent[3].isSelected = false;
                                    }
                                    if (allRowContent[3].isSelected == true) {
                                      allRowContent[3].isSelected == true;
                                      allRowContent[0].isSelected = false;
                                      if (count3 == 1) {
                                        count3 = 0;
                                        count0 = 0;
                                      }
                                      count3++;
                                    }
                                    if (allRowContent[0].isSelected == true) {
                                      allRowContent[0].isSelected == true;
                                      allRowContent[3].isSelected = false;
                                      if (count0 == 1) {
                                        count3 = 0;
                                        count0 = 0;
                                      }
                                      count0++;
                                    }

                                    //04
                                    if (allRowContent[4].isSelected ==
                                            allRowContent[0].isSelected &&
                                        count4 >= count0) {
                                      allRowContent[0].isSelected == true;
                                      allRowContent[4].isSelected = false;
                                    }
                                    if (allRowContent[4].isSelected == true) {
                                      allRowContent[4].isSelected == true;
                                      allRowContent[0].isSelected = false;
                                      if (count4 == 1) {
                                        count4 = 0;
                                        count0 = 0;
                                      }
                                      count4++;
                                    }
                                    if (allRowContent[0].isSelected == true) {
                                      allRowContent[0].isSelected == true;
                                      allRowContent[4].isSelected = false;
                                      if (count0 == 1) {
                                        count4 = 0;
                                        count0 = 0;
                                      }
                                      count0++;
                                    }
                                  }
                                  //1
                                  if (allRowContent[1].isSelected == true) {
                                    //12
                                    if (allRowContent[2].isSelected ==
                                            allRowContent[1].isSelected &&
                                        count2 >= count1) {
                                      allRowContent[1].isSelected == true;
                                      allRowContent[2].isSelected = false;
                                    }
                                    if (allRowContent[2].isSelected == true) {
                                      allRowContent[2].isSelected == true;
                                      allRowContent[1].isSelected = false;
                                      if (count2 == 1) {
                                        count2 = 0;
                                        count1 = 0;
                                      }
                                      count2++;
                                    }
                                    if (allRowContent[1].isSelected == true) {
                                      allRowContent[1].isSelected == true;
                                      allRowContent[2].isSelected = false;
                                      if (count1 == 1) {
                                        count2 = 0;
                                        count1 = 0;
                                      }
                                      count1++;
                                    }
                                    //13
                                    if (allRowContent[3].isSelected ==
                                            allRowContent[1].isSelected &&
                                        count3 >= count1) {
                                      allRowContent[1].isSelected == true;
                                      allRowContent[3].isSelected = false;
                                    }
                                    if (allRowContent[3].isSelected == true) {
                                      allRowContent[3].isSelected == true;
                                      allRowContent[1].isSelected = false;
                                      if (count3 == 1) {
                                        count3 = 0;
                                        count1 = 0;
                                      }
                                      count3++;
                                    }
                                    if (allRowContent[1].isSelected == true) {
                                      allRowContent[1].isSelected == true;
                                      allRowContent[3].isSelected = false;
                                      if (count1 == 1) {
                                        count3 = 0;
                                        count1 = 0;
                                      }
                                      count1++;
                                    }

                                    //14
                                    if (allRowContent[4].isSelected ==
                                            allRowContent[1].isSelected &&
                                        count4 >= count1) {
                                      allRowContent[1].isSelected == true;
                                      allRowContent[4].isSelected = false;
                                    }
                                    if (allRowContent[4].isSelected == true) {
                                      allRowContent[4].isSelected == true;
                                      allRowContent[1].isSelected = false;
                                      if (count4 == 1) {
                                        count4 = 0;
                                        count1 = 0;
                                      }
                                      count4++;
                                    }
                                    if (allRowContent[1].isSelected == true) {
                                      allRowContent[1].isSelected == true;
                                      allRowContent[4].isSelected = false;
                                      if (count1 == 1) {
                                        count4 = 0;
                                        count1 = 0;
                                      }
                                      count1++;
                                    }
                                  }

                                  //2
                                  if (allRowContent[2].isSelected == true) {
                                    //24
                                    if (allRowContent[4].isSelected ==
                                            allRowContent[2].isSelected &&
                                        count4 >= count2) {
                                      allRowContent[2].isSelected == true;
                                      allRowContent[4].isSelected = false;
                                    }
                                    if (allRowContent[4].isSelected == true) {
                                      allRowContent[4].isSelected == true;
                                      allRowContent[2].isSelected = false;
                                      if (count4 == 1) {
                                        count4 = 0;
                                        count2 = 0;
                                      }
                                      count4++;
                                    }
                                    if (allRowContent[2].isSelected == true) {
                                      allRowContent[2].isSelected == true;
                                      allRowContent[4].isSelected = false;
                                      if (count2 == 1) {
                                        count4 = 0;
                                        count2 = 0;
                                      }
                                      count2++;
                                    }

                                    //23
                                    if (allRowContent[3].isSelected ==
                                            allRowContent[2].isSelected &&
                                        count3 >= count2) {
                                      allRowContent[2].isSelected == true;
                                      allRowContent[3].isSelected = false;
                                    }
                                    if (allRowContent[3].isSelected == true) {
                                      allRowContent[3].isSelected == true;
                                      allRowContent[2].isSelected = false;
                                      if (count3 == 1) {
                                        count3 = 0;
                                        count2 = 0;
                                      }
                                      count3++;
                                    }
                                    if (allRowContent[2].isSelected == true) {
                                      allRowContent[2].isSelected == true;
                                      allRowContent[3].isSelected = false;
                                      if (count2 == 1) {
                                        count3 = 0;
                                        count2 = 0;
                                      }
                                      count2++;
                                    }
                                  }

                                  //3
                                  if (allRowContent[3].isSelected == true) {
                                    if (allRowContent[4].isSelected ==
                                            allRowContent[3].isSelected &&
                                        count4 >= count3) {
                                      allRowContent[3].isSelected == true;
                                      allRowContent[4].isSelected = false;
                                    }
                                    if (allRowContent[4].isSelected == true) {
                                      allRowContent[4].isSelected == true;
                                      allRowContent[3].isSelected = false;
                                      if (count4 == 1) {
                                        count4 = 0;
                                        count3 = 0;
                                      }
                                      count4++;
                                    }
                                    if (allRowContent[3].isSelected == true) {
                                      allRowContent[3].isSelected == true;
                                      allRowContent[4].isSelected = false;
                                      if (count3 == 1) {
                                        count4 = 0;
                                        count3 = 0;
                                      }
                                      count3++;
                                    }
                                  }
                                });
                              },
                            ),
                      onTap: () {
                        setState(() {
                          allRowContent[i].isSelected =
                              !allRowContent[i].isSelected;
                          //The super-algorithm chooses an option
                          //0
                          if (allRowContent[0].isSelected == true) {
                            //01
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

                            //02
                            if (allRowContent[2].isSelected ==
                                    allRowContent[0].isSelected &&
                                count2 >= count0) {
                              allRowContent[0].isSelected == true;
                              allRowContent[2].isSelected = false;
                            }
                            if (allRowContent[2].isSelected == true) {
                              allRowContent[2].isSelected == true;
                              allRowContent[0].isSelected = false;
                              if (count2 == 1) {
                                count2 = 0;
                                count0 = 0;
                              }
                              count2++;
                            }
                            if (allRowContent[0].isSelected == true) {
                              allRowContent[0].isSelected == true;
                              allRowContent[2].isSelected = false;
                              if (count0 == 1) {
                                count2 = 0;
                                count0 = 0;
                              }
                              count0++;
                            }

                            //03
                            if (allRowContent[3].isSelected ==
                                    allRowContent[0].isSelected &&
                                count3 >= count0) {
                              allRowContent[0].isSelected == true;
                              allRowContent[3].isSelected = false;
                            }
                            if (allRowContent[3].isSelected == true) {
                              allRowContent[3].isSelected == true;
                              allRowContent[0].isSelected = false;
                              if (count3 == 1) {
                                count3 = 0;
                                count0 = 0;
                              }
                              count3++;
                            }
                            if (allRowContent[0].isSelected == true) {
                              allRowContent[0].isSelected == true;
                              allRowContent[3].isSelected = false;
                              if (count0 == 1) {
                                count3 = 0;
                                count0 = 0;
                              }
                              count0++;
                            }

                            //04
                            if (allRowContent[4].isSelected ==
                                    allRowContent[0].isSelected &&
                                count4 >= count0) {
                              allRowContent[0].isSelected == true;
                              allRowContent[4].isSelected = false;
                            }
                            if (allRowContent[4].isSelected == true) {
                              allRowContent[4].isSelected == true;
                              allRowContent[0].isSelected = false;
                              if (count4 == 1) {
                                count4 = 0;
                                count0 = 0;
                              }
                              count4++;
                            }
                            if (allRowContent[0].isSelected == true) {
                              allRowContent[0].isSelected == true;
                              allRowContent[4].isSelected = false;
                              if (count0 == 1) {
                                count4 = 0;
                                count0 = 0;
                              }
                              count0++;
                            }
                          }
                          //1
                          if (allRowContent[1].isSelected == true) {
                            //12
                            if (allRowContent[2].isSelected ==
                                    allRowContent[1].isSelected &&
                                count2 >= count1) {
                              allRowContent[1].isSelected == true;
                              allRowContent[2].isSelected = false;
                            }
                            if (allRowContent[2].isSelected == true) {
                              allRowContent[2].isSelected == true;
                              allRowContent[1].isSelected = false;
                              if (count2 == 1) {
                                count2 = 0;
                                count1 = 0;
                              }
                              count2++;
                            }
                            if (allRowContent[1].isSelected == true) {
                              allRowContent[1].isSelected == true;
                              allRowContent[2].isSelected = false;
                              if (count1 == 1) {
                                count2 = 0;
                                count1 = 0;
                              }
                              count1++;
                            }
                            //13
                            if (allRowContent[3].isSelected ==
                                    allRowContent[1].isSelected &&
                                count3 >= count1) {
                              allRowContent[1].isSelected == true;
                              allRowContent[3].isSelected = false;
                            }
                            if (allRowContent[3].isSelected == true) {
                              allRowContent[3].isSelected == true;
                              allRowContent[1].isSelected = false;
                              if (count3 == 1) {
                                count3 = 0;
                                count1 = 0;
                              }
                              count3++;
                            }
                            if (allRowContent[1].isSelected == true) {
                              allRowContent[1].isSelected == true;
                              allRowContent[3].isSelected = false;
                              if (count1 == 1) {
                                count3 = 0;
                                count1 = 0;
                              }
                              count1++;
                            }

                            //14
                            if (allRowContent[4].isSelected ==
                                    allRowContent[1].isSelected &&
                                count4 >= count1) {
                              allRowContent[1].isSelected == true;
                              allRowContent[4].isSelected = false;
                            }
                            if (allRowContent[4].isSelected == true) {
                              allRowContent[4].isSelected == true;
                              allRowContent[1].isSelected = false;
                              if (count4 == 1) {
                                count4 = 0;
                                count1 = 0;
                              }
                              count4++;
                            }
                            if (allRowContent[1].isSelected == true) {
                              allRowContent[1].isSelected == true;
                              allRowContent[4].isSelected = false;
                              if (count1 == 1) {
                                count4 = 0;
                                count1 = 0;
                              }
                              count1++;
                            }
                          }

                          //2
                          if (allRowContent[2].isSelected == true) {
                            //24
                            if (allRowContent[4].isSelected ==
                                    allRowContent[2].isSelected &&
                                count4 >= count2) {
                              allRowContent[2].isSelected == true;
                              allRowContent[4].isSelected = false;
                            }
                            if (allRowContent[4].isSelected == true) {
                              allRowContent[4].isSelected == true;
                              allRowContent[2].isSelected = false;
                              if (count4 == 1) {
                                count4 = 0;
                                count2 = 0;
                              }
                              count4++;
                            }
                            if (allRowContent[2].isSelected == true) {
                              allRowContent[2].isSelected == true;
                              allRowContent[4].isSelected = false;
                              if (count2 == 1) {
                                count4 = 0;
                                count2 = 0;
                              }
                              count2++;
                            }

                            //23
                            if (allRowContent[3].isSelected ==
                                    allRowContent[2].isSelected &&
                                count3 >= count2) {
                              allRowContent[2].isSelected == true;
                              allRowContent[3].isSelected = false;
                            }
                            if (allRowContent[3].isSelected == true) {
                              allRowContent[3].isSelected == true;
                              allRowContent[2].isSelected = false;
                              if (count3 == 1) {
                                count3 = 0;
                                count2 = 0;
                              }
                              count3++;
                            }
                            if (allRowContent[2].isSelected == true) {
                              allRowContent[2].isSelected == true;
                              allRowContent[3].isSelected = false;
                              if (count2 == 1) {
                                count3 = 0;
                                count2 = 0;
                              }
                              count2++;
                            }
                          }

                          //3
                          if (allRowContent[3].isSelected == true) {
                            if (allRowContent[4].isSelected ==
                                    allRowContent[3].isSelected &&
                                count4 >= count3) {
                              allRowContent[3].isSelected == true;
                              allRowContent[4].isSelected = false;
                            }
                            if (allRowContent[4].isSelected == true) {
                              allRowContent[4].isSelected == true;
                              allRowContent[3].isSelected = false;
                              if (count4 == 1) {
                                count4 = 0;
                                count3 = 0;
                              }
                              count4++;
                            }
                            if (allRowContent[3].isSelected == true) {
                              allRowContent[3].isSelected == true;
                              allRowContent[4].isSelected = false;
                              if (count3 == 1) {
                                count4 = 0;
                                count3 = 0;
                              }
                              count3++;
                            }
                          }
                        });
                      },
                    )
                  ],
                ),
                if (allRowContent[i].isSelected == true) ...[
                  const SizedBox(height: 7),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(35, 0, 0, 0),
                      child: TextFormField(
                        maxLength: 10,
                        controller: controller,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            isDealPriceValueError = true;

                            return '';
                          }
                          if (text.contains('.') ||
                              text.contains(' ') ||
                              text.contains('/') ||
                              text.contains('-')) {
                            isDealPriceValueError = true;

                            return 'Vui lòng chỉ nhập kí tự số';
                          }
                          double value = double.parse(text);
                          if (value < 1000) {
                            isDealPriceValueError = true;

                            return 'Giá phải lớn hơn 1000 VNĐ';
                          }

                          isDealPriceValueError = false;
                        },
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 12),
                        decoration: InputDecoration(
                            labelText: 'Nhập giá',
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 2, color: Colors.blue),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(width: 3, color: Colors.red),
                              borderRadius: BorderRadius.circular(15),
                            )),
                      )),
                ],
                const SizedBox(height: 10),
              ],
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
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const PostSuccess(),
                        ),
                      );
                    },
                    child: const Text(
                      'ĐĂNG',
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
          ],
        ),
      ),
    );
  }

  void getImage({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(
        source: source, maxWidth: 640, maxHeight: 480, imageQuality: 70);

    if (file?.path != null) {
      setState(() {
        imageFile = File(file!.path);
      });
    }
  }
}
