import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import '../providers/posts.dart';
//import '../providers/users.dart';

import '../widgets/search_option/post_item.dart';
import './application_tracking.dart';
import './applications.dart';

class ColorInPage {
  static const blackColor = Color(0xFF0D0D26);
  static const backgroudColor = Color(0xFFFAFAFD);
  static const textColor = Color(0xFF000000);
  static const backgroundAppBar = Color(0xFF356899);
  static const buttonColor = Color(0xFF537fa8);
}

class TextInPage {
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
}

class ApplySuccess extends StatefulWidget {
  final String postId;

  //ApplySuccess(this.postId);
  const ApplySuccess({Key? key, required this.postId}) : super(key: key);
  @override
  State<ApplySuccess> createState() => _ApplySuccessState();
}

class _ApplySuccessState extends State<ApplySuccess> {
  @override
  Widget build(BuildContext context) {
    final post =
        Provider.of<Posts>(context, listen: false).findById(widget.postId);
    // final user =
    //     Provider.of<Users>(context, listen: false).findById(post.userId);

    final mediaQuery = MediaQuery.of(context);
    // final isLandscape = mediaQuery.orientation == Orientation.landscape;
    // final bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
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
      title: TextInPage.textTilteBlack('Apply'),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: Container(
          margin: const EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: IgnorePointer(
            ignoring: true,
            child: ChangeNotifierProvider.value(
              value: post,
              child: const PostItem(),
            ),
          ),
        ),
      ),
    );

    final pageBody = SingleChildScrollView(
        child: Container(
      color: Colors.white,
      margin: const EdgeInsets.fromLTRB(24, 8, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/images/successful.gif', width: 270),
          const Text(
            'Thành công',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: Color(0xFF0D0D26),
            ),
          ),
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Color(0xFF95969D),
                    wordSpacing: 2),
                text:
                    'Bạn đã đăng ký thành công vai trò Tư vấn thất tình cho Thị Yến. Bạn có thể xem trạng thái công việc từ Theo dõi công việc'),
          ),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
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
                'Theo dõi công việc',
                style: TextStyle(
                    letterSpacing: 0,
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500),
              ),
            ),
            onPressed: () {
              // print('Event: Change language');
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ApplicationTracking(),
                ),
              );
            },
          ),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0.0,
                shadowColor: Colors.transparent,
                minimumSize: Size(mediaQuery.size.width - 24 * 2, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
                primary: const Color(0xFFF5F7FA),
                onPrimary: Colors.white),
            child: const FittedBox(
              child: Text(
                'DUYỆT CÔNG VIỆC',
                style: TextStyle(
                    letterSpacing: 0,
                    color: Color(0xFF243656),
                    fontSize: 14,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w700),
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
          )
        ],
      ),
    ));
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[appBar];
        },
        body: pageBody,
      ),
    );
  }
}
