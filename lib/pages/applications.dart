/*
  page content
  1) app bar
  2) group button
  3) apply list
*/

import 'package:flutter/material.dart';

import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:loviser/main.dart';
import 'package:loviser/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:group_button/group_button.dart';

import '../providers/post.dart';
import '../providers/posts.dart';

import '../widgets/search_option/post_item.dart';

import './reason_for_refusal.dart';

// data
class Apply {
  String id;
  String userId; // the one who make apply
  String postId;
  String status; // [ 'Bi tu choi','Da chap nhan', ....]

  Apply({
    required this.id,
    required this.userId,
    required this.postId,
    required this.status,
  });
}

final applys = [
  Apply(
    id: 'apply-1',
    userId: 'user-1',
    postId: 'p1',
    status: 'Bị từ chối',
  ),
  Apply(
    id: 'apply-2',
    userId: 'user-1',
    postId: 'p2',
    status: 'Đã chấp nhận',
  ),
  Apply(
    id: 'apply-3',
    userId: 'user-1',
    postId: 'p3',
    status: 'Đã đánh giá',
  ),
  Apply(
    id: 'apply-4',
    userId: 'user-1',
    postId: 'p3',
    status: 'Đã đánh giá',
  ),
];

class ColorInPage {
  static const blackColor = Color(0xFF0D0D26);
  static const backgroudColor = Color(0xFFFAFAFD);
  static const textColor = Color(0xFF000000);
  static const backgroundAppBar = Color(0xFF356899);
  static const buttonColor = Color(0xFF537fa8);
}

class Applications extends StatefulWidget {
  const Applications({Key? key}) : super(key: key);

  @override
  State<Applications> createState() => _ApplicationsState();
}

class _ApplicationsState extends State<Applications> {
  late List<Apply> applySelected;
  final List<String> choices = [
    'Tất cả',
    'Bị từ chối',
    'Đã chấp nhận',
    'Đã đánh giá',
    'Đang chờ',
  ];

  late String itemSelectedString = 'Tất cả';

  late GroupButtonController controller = GroupButtonController(
    selectedIndex: 0,
    selectedIndexes: [0],
  );

  void resetApplySelected() {
    setState(() {
      applySelected = applys.where((apply) {
        bool res = false;

        //if (controller.selectedIndexes.contains(0)) res = true;

        // if (controller.selectedIndexes.contains(1) &&
        //     apply.status == 'Bị từ chối') res = true;

        // this is short hand from multi-if above

        // var list = controller.selectedIndexes.toList();
        // for (var index in list) {
        //   if (apply.status == choices[index]) res = true;
        // }

        if (itemSelectedString == 'Tất cả') {
          res = true;
        } else {
          if (apply.status == itemSelectedString) res = true;
        }
        return res;
      }).toList();
    });
  }

  Widget applyCard(BuildContext ctxRoot, Post post, Apply apply) {
    return CustomCard(
      color: Colors.white,
      shadowColor: const Color(0xFF000000).withOpacity(0.03),
      borderRadius: 10,
      child: Column(
        children: <Widget>[
          IgnorePointer(
            ignoring: true,
            child: ChangeNotifierProvider.value(
                value: post, child: const PostItem()),
          ),
          Container(
            height: 40,
            margin: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: 144,
                    height: 33,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(52)),
                      color: (apply.status == 'Bị từ chối')
                          ? const Color(0xFFFFEDED)
                          : (apply.status == 'Đã chấp nhận')
                              ? const Color(0xFFE8FDF2)
                              : const Color(0xFFEDF3FC),
                    ),
                    child: Text(
                      apply.status,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: (apply.status == 'Bị từ chối')
                              ? const Color(0xFFDC312D)
                              : (apply.status == 'Đã chấp nhận')
                                  ? const Color(0xFF0E9D57)
                                  : const Color(0xFF5386E4)),
                    )),
                InkWell(
                  onTap: (apply.status == 'Bị từ chối')
                      ? () {
                          showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              barrierColor:
                                  const Color(0xFF2C373B).withOpacity(0.6),
                              isScrollControlled: true,
                              context: ctxRoot,
                              builder: (ctx) => SizedBox(
                                    height: !(MediaQuery.of(ctxRoot)
                                                .orientation ==
                                            Orientation.landscape)
                                        ? (MediaQuery.of(ctxRoot).size.height -
                                                MediaQuery.of(ctxRoot)
                                                    .padding
                                                    .top) /
                                            2
                                        : (MediaQuery.of(ctxRoot).size.height -
                                                MediaQuery.of(ctxRoot)
                                                    .padding
                                                    .top) *
                                            0.85,
                                    child: const ReasonForRefusal(),
                                  ));
                        }
                      : () {},
                  child: Text(
                      (apply.status == 'Bị từ chối')
                          ? 'Xem lí do'
                          : 'Xem chi tiết',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Color(0xFFAFB0B6),
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    resetApplySelected();
  }

  @override
  Widget build(BuildContext context) {
    final posts =
        Provider.of<Posts>(context, listen: false).getPostWithMaxAmout(3);
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget appBar = AppBar(
      // systemOverlayStyle:
      //     SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      backgroundColor: ColorInPage.backgroudColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
      elevation: 0.0,
      leading: Container(
        alignment: Alignment.topCenter,
        margin: const EdgeInsets.fromLTRB(24, 0, 0, 0),
        child: IconButton(
          padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MainPage(),
              ),
            );
          },
          icon: const Image(
              color: ColorInPage.blackColor,
              width: 8,
              height: 16,
              image: AssetImage('assets/images/searchResult_left.png')),
        ),
      ),
      centerTitle: true,
      title: const Text(
        'Đơn xin việc',
        style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Color(0xFF0D0D26)),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 24, 0),
          child: Stack(
            children: <Widget>[
              const CircleAvatar(
                minRadius: 30,
                maxRadius: 30,
                backgroundImage: AssetImage('assets/images/huy_avatar.jpg'),
              ),
              Positioned(
                  top: 0,
                  right: 0,
                  width: 16,
                  height: 16,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                        color: const Color(0xFFFC1010),
                        border: Border.all(
                            color: ColorInPage.backgroudColor, width: 4),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(167))),
                  ))
            ],
          ),
        )
      ],
    );

    return Scaffold(
      backgroundColor: ColorInPage.backgroudColor,
      appBar: appBar,
      body: SingleChildScrollView(
          child: Container(
        margin: const EdgeInsets.fromLTRB(24, 8, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: !isLandscape ? 260 : double.infinity,
              margin: const EdgeInsets.fromLTRB(0, 0, 24, 0),
              child: const Text(
                "Bạn đã apply thành công 27 công việc 👍",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  color: Color(0xFF0D0D26),
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: GroupButton(
                controller: controller,
                options: GroupButtonOptions(
                  selectedTextStyle: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  unselectedTextStyle: const TextStyle(
                    color: Color(0xFF95969D),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  selectedColor: const Color(0xFFEC1C24),
                  unselectedColor: ColorInPage.backgroudColor,
                  borderRadius: BorderRadius.circular(97),
                  unselectedBorderColor: const Color(0xFF95969D),
                  selectedBorderColor: const Color(0xFFEC1C24),
                  selectedShadow: const [
                    BoxShadow(
                      color: ColorInPage.backgroudColor,
                      blurRadius: 25.0,
                      spreadRadius: 1.0,
                      offset: Offset(
                        0.0,
                        2.0,
                      ),
                    ),
                  ],
                  unselectedShadow: const [
                    BoxShadow(
                      color: ColorInPage.backgroudColor,
                      blurRadius: 25.0,
                      spreadRadius: 1.0,
                      offset: Offset(
                        0.0,
                        2.0,
                      ),
                    ),
                  ],
                  //direction: Axis.vertical,
                  groupingType: GroupingType.row,
                ),
                isRadio: true,
                onSelected: (index, isSelected, value) {
                  print(index);
                  itemSelectedString = index.toString();
                  resetApplySelected();
                },
                buttons: choices,
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 24, 0),
              child: Column(
                children: [
                  ...applySelected.map(
                    (apply) {
                      return applyCard(context, posts[0], apply);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
