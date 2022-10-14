import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:provider/provider.dart';
//import 'package:timeline_tile/timeline_tile.dart';
//import '../providers/post.dart';
import '../providers/posts.dart';
//import '../providers/users.dart';

import '../widgets/search_option/post_item.dart';
import '../widgets/progress_track/progress_track.dart';

import './applications.dart';

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

  static Widget textTilteBlack(String str,
      {FontWeight fontWeight = FontWeight.w600,
      double size = 16,
      String fontFamily = 'Poppins',
      double space = 0,
      Color color = ColorInPage.blackColor}) {
    return Text(str,
        style: TextStyle(
            letterSpacing: space,
            color: color,
            fontSize: size,
            fontFamily: fontFamily,
            fontWeight: fontWeight));
  }

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
}

class ApplicationTracking extends StatefulWidget {
  const ApplicationTracking({Key? key}) : super(key: key);

  @override
  State<ApplicationTracking> createState() => _ApplicationTrackingState();
}

class _ApplicationTrackingState extends State<ApplicationTracking> {
  @override
  Widget build(BuildContext context) {
    // DateTime now = DateTime.now();
    // String formattedDate = DateFormat('dd/MM/yyyy – h:mm a').format(now);
    final post = Provider.of<Posts>(context, listen: false).findById('p1');
    // final user =
    //     Provider.of<Users>(context, listen: false).findById(post.userId);

    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    //final bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    final SliverAppBar appBar = SliverAppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      backgroundColor: Colors.white,
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
            // print('Back to Search Filter Page');
            Navigator.pop(context);
          },
          icon: const Image(
              color: ColorInPage.blackColor,
              width: 8,
              height: 16,
              image: AssetImage('assets/images/searchResult_left.png')),
        ),
      ),
      centerTitle: true,
      title: TextInPage.textTilteBlack('Theo dõi công việc'),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: Container(
          margin: const EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: ChangeNotifierProvider.value(
            value: post,
            child: const PostItem(),
          ),
        ),
      ),
    );

    final pageBody = SingleChildScrollView(
        child: Container(
      color: ColorInPage.backgroudColor,
      margin: const EdgeInsets.fromLTRB(24, 8, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Theo dõi quá trình',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Color(0xFF0D0D26),
            ),
          ),
          SizedBox(
            height: (!isLandscape)
                ? (mediaQuery.size.height)
                : (mediaQuery.size.height) * 2,
            child: Timeline(post.id),
          ),
        ],
      ),
    ));
    return Scaffold(
      backgroundColor: ColorInPage.backgroudColor,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[appBar];
        },
        body: pageBody,
      ),
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0.0,
            shadowColor: Colors.transparent,
            minimumSize: Size(mediaQuery.size.width - 24 * 2, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
            primary: const Color(0xFFEC1C24),
            onPrimary: Colors.white),
        child: const FittedBox(
          child: Text(
            'Duyệt công việc',
            style: TextStyle(
                letterSpacing: 0,
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500),
          ),
        ),
        onPressed: () {
          //print('Event: Change language');
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const Applications(),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
