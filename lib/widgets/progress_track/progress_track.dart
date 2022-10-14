//import 'dart:ffi';
import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// import 'package:timeline_tile/timeline_tile.dart';

import 'package:intl/intl.dart';

import '../../providers/posts.dart';
import '../../providers/users.dart';
//import '../../providers/post.dart';

//import '../custom_timeline_tile/src/axis.dart';
import '../custom_timeline_tile/src/style.dart';
import '../custom_timeline_tile/src/tile.dart';
//import '../custom_timeline_tile/src/timeline_divider.dart';

class ColorInPage {
  static const blackColor = Color(0xFF0D0D26);
  static const backgroudColor = Color(0xFFFAFAFD);
  static const textColor = Color(0xFF000000);
  static const backgroundAppBar = Color(0xFF356899);
  static const buttonColor = Color(0xFF537fa8);
}

class TextInPage {
  static String sendInvitations = 'Gửi lời mời';
  static String checkProfile = ' đã xem hồ sơ';
  static String interviewInvitations = ' đã mời bạn vào cuộc phỏng vấn';
  static String chooseAdviser = ' đã chọn bạn làm người tư vấn';
  static String payment = ' đã thanh toán và đánh giá';
  static String doneJob = 'Công việc thành công';

  static Widget progressTitle(String str,
      {FontWeight fontWeight = FontWeight.w500,
      double size = 15,
      // String fontFamily = 'Poppins',
      double space = 0,
      Color color = ColorInPage.blackColor}) {
    return Text(
      str,
      style: TextStyle(
          color: color,
          letterSpacing: space,
          fontSize: size,
          // fontFamily: fontFamily,
          fontWeight: fontWeight),
    );
  }

  static Widget progressTime(String str,
      {FontWeight fontWeight = FontWeight.w400,
      double size = 13,
      // String fontFamily = 'Poppins',
      double space = 0,
      Color color = Colors.grey}) {
    return Text(
      str,
      style: TextStyle(
          color: color,
          letterSpacing: space,
          fontSize: size,
          // fontFamily: fontFamily,
          fontWeight: fontWeight),
    );
  }

  static Widget progressToDo(
    String str, {
    FontWeight fontWeight = FontWeight.w500,
    double size = 15,
    // String fontFamily = 'Poppins',
    double space = 0,
    Color color = Colors.grey,
  }) {
    return Text(
      str,
      style: TextStyle(
          color: color,
          letterSpacing: space,
          fontSize: size,
          // fontFamily: fontFamily,
          fontWeight: fontWeight),
    );
  }
}

class TimeLineItem {
  String content;
  bool isDone;

  TimeLineItem({required this.content, required this.isDone});
}

const deliverySteps = [
  'gửi lời mời',
  'đã xem hồ sơ',
  'đã mời bạn vào cuộc phỏng vấn',
  'đã chọn bạn làm người tư vấn',
  'đã thanh toán và đánh giá',
  'đã hoàn thành công việc',
];

final timeLineItems = [
  TimeLineItem(
    content: 'gửi lời mời',
    isDone: false,
  ),
  TimeLineItem(
    content: 'đã xem hồ sơ',
    isDone: true,
  ),
  TimeLineItem(
    content: 'đã mời bạn vào cuộc phỏng vấn',
    isDone: true,
  ),
  TimeLineItem(
    content: 'đã chọn bạn làm người tư vấn',
    isDone: true,
  ),
  TimeLineItem(
    content: 'đã thanh toán và đánh giá',
    isDone: false,
  ),
  TimeLineItem(
    content: 'đã hoàn thành công việc',
    isDone: false,
  ),
];

class Timeline extends StatefulWidget {
  final String postId;
  Timeline(this.postId);

  @override
  TimelineState createState() => TimelineState();
}

class TimelineState extends State<Timeline> {
  @override
  void initState() {
    super.initState();
  }

  final currentStep = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ...deliverySteps.map((step) {
          var index = deliverySteps.indexOf(step);
          _DeliveryStatus status = _DeliveryStatus.invite;
          var indicatorSize = 30.0;
          var beforeLineStyle = const LineStyleCustom(
            color: Color(0xFFEC1C24),
            thickness: 2.5,
          );

          var afterLineStyle = const LineStyleCustom(
            color: Color(0xFFEC1C24),
            thickness: 2.5,
          );

          // Use color to check draw in tile file drawLine
          if (!timeLineItems[index].isDone) {
            beforeLineStyle = const LineStyleCustom(
              color: Color(0xFFAFB0B6),
              thickness: 2.5,
            );
            afterLineStyle = const LineStyleCustom(
              color: Color(0xFFAFB0B6),
              thickness: 2.5,
            );
          }
          // if (index < currentStep) {
          //   status = _DeliveryStatus.done;
          // } else if (index > currentStep) {
          //   status = _DeliveryStatus.todo;
          //   indicatorSize = 20;
          //   beforeLineStyle = const LineStyleCustom(
          //     color: Color(0xFFAFB0B6),
          //     thickness: 2.5,
          //   );
          //   afterLineStyle = const LineStyleCustom(
          //     color: Color(0xFFAFB0B6),
          //     thickness: 2.5,
          //   );
          // } else {
          //   afterLineStyle = const LineStyleCustom(
          //     color: Color(0xFFAFB0B6),
          //     thickness: 2.5,
          //   );
          //   status = _DeliveryStatus.doing;
          // }

          // if (index == 0) status = _DeliveryStatus.invite;
          // if (index == 1) status = _DeliveryStatus.watchProfile;

          if (index == 0) {
            status = timeLineItems[0].isDone
                ? _DeliveryStatus.invite
                : _DeliveryStatus.notInvite;
          }
          if (index == 1) {
            status = timeLineItems[1].isDone
                ? _DeliveryStatus.watchProfile
                : _DeliveryStatus.notWatchProfile;
          }
          if (index > 1) {
            status = timeLineItems[index].isDone
                ? _DeliveryStatus.done
                : _DeliveryStatus.todo;
          }

          return TimelineTile(
            axis: TimelineAxis.vertical,
            alignment: TimelineAlign.manual,
            lineXY: 0.1,
            isFirst: index == 0,
            isLast: index == deliverySteps.length - 1,
            beforeLineStyle: beforeLineStyle,
            afterLineStyle: afterLineStyle,
            indicatorStyle: IndicatorStyleCustom(
              width: indicatorSize,
              height: indicatorSize,
              indicator: _IndicatorDelivery(status: status),
            ),
            // startChild: _StartChildDelivery(index: index),
            endChild: _EndChildDelivery(
              text: step,
              current: index == currentStep,
              status: status,
              postId: widget.postId,
            ),
          );
        })
      ],
    );
  }
}

enum _DeliveryStatus {
  done,
  doing,
  todo,
  invite,
  notInvite,
  watchProfile,
  notWatchProfile,
}

class _StartChildDelivery extends StatelessWidget {
  const _StartChildDelivery({Key? key, this.index}) : super(key: key);

  final int? index;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _EndChildDelivery extends StatelessWidget {
  _EndChildDelivery({
    Key? key,
    @required this.text,
    @required this.current,
    @required this.status,
    @required this.postId,
  }) : super(key: key);
  final String? postId;
  final String? text;
  final bool? current;
  final _DeliveryStatus? status;
  @override
  Widget build(BuildContext context) {
    final post =
        Provider.of<Posts>(context, listen: false).findById(postId.toString());
    final user =
        Provider.of<Users>(context, listen: false).findById(post.userId);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy – h:mm a').format(now);
    String time;
    //String tempText = text.toString();
    Widget progressTitle = TextInPage.progressTitle(text.toString());
    Widget userName = TextInPage.progressTitle('${user.name} ');
    if (status == _DeliveryStatus.done || status == _DeliveryStatus.doing) {
      time = formattedDate;
      progressTitle = TextInPage.progressTitle(text.toString());
    } else {
      time = 'Not yet';
      progressTitle = TextInPage.progressToDo(text.toString());
      userName = TextInPage.progressToDo('${user.name} '.toString());
    }
    return Padding(
      padding: EdgeInsets.only(left: width * 0.02),
      child: SizedBox(
        height: height * 0.1,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: <Widget>[
                  userName,
                  progressTitle,
                ],
              ),
              Row(
                children: <Widget>[
                  TextInPage.progressTime(time),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _IndicatorDelivery extends StatelessWidget {
  const _IndicatorDelivery({Key? key, this.status}) : super(key: key);

  final _DeliveryStatus? status;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case _DeliveryStatus.invite:
        return Image.asset(
          "assets/images/cup.png",
          width: 20,
          height: 20,
          color: const Color(0xFFEC1C24),
        );
      case _DeliveryStatus.notInvite:
        return Image.asset(
          "assets/images/cup.png",
          width: 20,
          height: 20,
          color: const Color(0xFFAFB0B6),
        );
      case _DeliveryStatus.watchProfile:
        return Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorInPage.backgroudColor,
                border: Border.all(
                  color: const Color(0xFFEC1C24),
                  width: 1,
                )),
            child: Center(
              child: Container(
                width: 13,
                height: 13,
                decoration: const BoxDecoration(
                  color: Color(0xFFEC1C24),
                  shape: BoxShape.circle,
                ),
              ),
            ));
      case _DeliveryStatus.notWatchProfile:
        return Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorInPage.backgroudColor,
                border: Border.all(
                  color: const Color(0xFFAFB0B6),
                  width: 1,
                )),
            child: Center(
              child: Container(
                width: 13,
                height: 13,
                decoration: const BoxDecoration(
                  color: Color(0xFFAFB0B6),
                  shape: BoxShape.circle,
                ),
              ),
            ));
      case _DeliveryStatus.done:
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFEC1C24),
            // color: Colors.blue,
          ),
          child: const Center(
            child: Icon(Icons.check, color: Colors.white),
          ),
        );
      case _DeliveryStatus.doing:
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFEC1C24),
          ),
          child: const Center(
            child: SizedBox(
              height: 15,
              width: 15,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
        );
      case _DeliveryStatus.todo:
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFAFB0B6),
          ),
          child: Center(
            child: Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFAFB0B6),
              ),
            ),
          ),
        );
    }
    return Container();
  }
}
