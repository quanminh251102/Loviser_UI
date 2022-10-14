import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../providers/post.dart';
import '../providers/posts.dart';
import '../../models/rating_review.dart';
import '../widgets/report_item/report_item.dart';

import 'package:intl/intl.dart';

class ColorInPage {
  static const blackColor = Color(0xFF0D0D26);
  static const backgroudColor = Color(0xFFFAFAFD);
  static const textColor = Color(0xFF000000);
  static const backgroundAppBar = Color(0xFF356899);
  static const buttonColor = Color(0xFF537fa8);
}

class TextInPage {
  static Widget Rating(String str,
      {FontWeight fontWeight = FontWeight.w400,
      double size = 18,
      String fontFamily = 'Plus Jakarta Sans',
      double space = 0,
      Color color = Colors.grey}) {
    return Text(
      str,
      style: TextStyle(
          color: color,
          letterSpacing: space,
          fontSize: size,
          fontFamily: fontFamily,
          fontWeight: fontWeight),
    );
  }

  static Widget ReportTime(String str,
      {FontWeight fontWeight = FontWeight.w400,
      double size = 12,
      String fontFamily = 'Roboto',
      double space = 0,
      Color color = Colors.black}) {
    return Text(
      str,
      style: TextStyle(
          color: color,
          letterSpacing: space,
          fontSize: size,
          fontFamily: fontFamily,
          fontWeight: fontWeight),
    );
  }

  static Widget ReportTitle(
    String str, {
    FontWeight fontWeight = FontWeight.w600,
    double size = 20,
    // String fontFamily = 'OpenSans',
    double space = 0,
    Color color = const Color(0xff133240),
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

final RatingReviews = [
  RatingReview(
    id: 'RatingReview-1',
    userId: 'user-1',
    postId: 'p1',
    rating: 4,
    rateTime: DateTime.now(),
    review: 'Tư vấn có tâm, nhưng chưa thể giải quyết vấn đề của mình.',
  ),
  RatingReview(
    id: 'RatingReview-2',
    userId: 'user-2',
    postId: 'p2',
    rating: 5,
    rateTime: DateTime.now(),
    review:
        'Mình đã giải quyết được vấn đề của mình nhờ bạn này, thật tuyệt vời',
  ),
  RatingReview(
    id: 'RatingReview-3',
    userId: 'user-3',
    postId: 'p3',
    rating: 2,
    rateTime: DateTime.now(),
    review: 'Anh đẹp trai lắm',
  ),
  RatingReview(
    id: 'RatingReview-3',
    userId: 'user-3',
    postId: 'p3',
    rating: 2,
    rateTime: DateTime.now(),
    review: 'Anh đẹp trai lắm',
  ),
  RatingReview(
    id: 'RatingReview-3',
    userId: 'user-3',
    postId: 'p3',
    rating: 2,
    rateTime: DateTime.now(),
    review: 'Anh đẹp trai lắm',
  ),
];

class RatingReviewPage extends StatefulWidget {
  const RatingReviewPage({Key? key}) : super(key: key);

  @override
  State<RatingReviewPage> createState() => _RatingReviewPageState();
}

class _RatingReviewPageState extends State<RatingReviewPage> {
  List<RatingReview> ratingReview = RatingReviews;

  Widget ReportCard(RatingReview itemratingReview, BuildContext context) {
    DateFormat format = DateFormat('dd-MM-yyyy');
    String ratingTime = format.format(itemratingReview.rateTime);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return CustomCard(
      childPadding: 30,
      elevation: 0.0,
      color: Colors.white,
      // shadowColor: const Color(0xFFF00000).withOpacity(0.03),
      borderWidth: 1,
      borderColor: const Color(0xFFE7EAEC),
      borderRadius: 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // IgnorePointer(
          //   ignoring: true,
          //   child: ReportItem(itemratingReview),
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // CircleAvatar(
              //   minRadius: 20,
              //   maxRadius: 20,
              //   backgroundImage:
              //       NetworkImage('https://picsum.photos/id/237/200/300'),
              //   // NetworkImage(user.avatarURL),
              // ),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: const Color(0xff7c94b6),
                    image: DecorationImage(
                      image:
                          NetworkImage('https://picsum.photos/id/237/200/300'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(7))),
              ),
              SizedBox(
                width: (!isLandscape) ? 10 : 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  IgnorePointer(
                    ignoring: true,
                    child: RatingBar.builder(
                      glowColor: Colors.green,
                      initialRating: itemratingReview.rating,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 32,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Color(0xFFF8A401),
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                  ),
                  Padding(
                    padding: (!isLandscape)
                        ? const EdgeInsets.fromLTRB(10, 0, 0, 0)
                        : const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: TextInPage.ReportTime(ratingTime),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'Ngọc Kem | Tư vấn thất tình',
            style: TextStyle(
              //fontFamily: 'Manrope',
              fontWeight: FontWeight.w500,
              fontSize: 23,
              color: Color(0xFF133240),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'Tư vấn có tâm, nhưng chưa thể giải quyết vấn đề của mình.',
            style: TextStyle(
              //fontFamily: 'Manrope',
              fontWeight: FontWeight.w300,
              fontSize: 15,
              color: Color(0xFF133240),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final posts =
        Provider.of<Posts>(context, listen: false).getPostWithMaxAmout(3);
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    final double mediumRate;
    double totalRate = 0;
    for (int i = 0; i < ratingReview.length; i++) {
      totalRate = totalRate + ratingReview[i].rating;
    }
    mediumRate = totalRate / (ratingReview.length);
    final SliverAppBar appBar = SliverAppBar(
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
      title: const Text(
        'Đánh giá',
        style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 24,
            color: Color(0xFF0D0D26)),
      ),
      actions: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 24, 0),
          child: Stack(
            children: <Widget>[
              CircleAvatar(
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
                        color: Color(0xFFFC1010),
                        border: Border.all(
                            color: ColorInPage.backgroudColor, width: 4),
                        borderRadius: BorderRadius.all(Radius.circular(167))),
                  ))
            ],
          ),
        )
      ],
    );

    final pageBody = SingleChildScrollView(
        child: Container(
      margin: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: !isLandscape
                ? mediaQuery.size.height * 0.1
                : mediaQuery.size.height * 0.2,
            child: CustomCard(
              borderRadius: 12,
              borderWidth: 1,
              borderColor: const Color(0xFFF0F0F0),
              color: const Color(0xFFF6FAFB),
              elevation: 0.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IgnorePointer(
                    child: RatingBar.builder(
                      initialRating: mediumRate,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 22,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Color(0xFFF8A401),
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                  ),
                  TextInPage.Rating('${ratingReview.length} lượt đánh giá')
                ],
              ),
            ),
          ),
          Container(
            child: Column(
              children: [
                ...ratingReview.map(
                  (successJob) {
                    return ReportCard(successJob, context);
                  },
                ),
              ],
            ),
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
    );
  }
}
