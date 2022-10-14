import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loviser/pages/saved.dart';
import 'package:provider/provider.dart';

import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

import 'package:group_button/group_button.dart';

import '../providers/posts.dart';
import '../providers/users.dart';
import '../providers/authentication.dart';

import '../utils/handle_string.dart';

import './apply.dart';

class ColorInPage {
  static const blackColor = Color(0xFF0D0D26);
  static const backgroudColor = Color(0xFFFAFAFD);
  static const textColor = Color(0xFF000000);
  static const backgroundAppBar = Color(0xFF356899);
  static const buttonColor = Color(0xFF537fa8);
}

class JobDetail extends StatefulWidget {
  final String postId;
  const JobDetail({Key? key, required this.postId}) : super(key: key);

  @override
  State<JobDetail> createState() => _JobDetailState();
}

class _JobDetailState extends State<JobDetail> {
  @override
  void initState() {
    super.initState();

    String login =
        Provider.of<Authentication>(context, listen: false).userIdLogined;

    Provider.of<Users>(context, listen: false)
        .addPostIdWathed(login, widget.postId);
  }

  @override
  Widget build(BuildContext context) {
    // Data from provider
    final post =
        Provider.of<Posts>(context, listen: false).findById(widget.postId);
    final user =
        Provider.of<Users>(context, listen: false).findById(post.userId);
    // final login =
    //     Provider.of<Authentication>(context, listen: false).userIdLogined;

    final mediaQuery = MediaQuery.of(context);
    // final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final SliverAppBar appBar = SliverAppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      toolbarHeight: 180,
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
            print('Back to Search Filter Page');
            Navigator.pop(context);
          },
          icon: const Image(
              color: Colors.white,
              width: 8,
              height: 16,
              image: AssetImage('assets/images/searchResult_left.png')),
        ),
      ),
      backgroundColor: Colors.transparent,
      centerTitle: true,
      flexibleSpace: InkWell(
        onTap: () {
          // print('Change to Saved');
          // Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (context) => const Saved()));
        },
        child: Container(
          decoration: const BoxDecoration(
              color: ColorInPage.backgroundAppBar,
              image: DecorationImage(
                  image: AssetImage('assets/images/maskgroup.png'),
                  fit: BoxFit.fill)),
        ),
      ),
      title: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
            border: Border.all(width: 5, color: Colors.white),
            borderRadius: BorderRadius.circular(62)),
        child: CircleAvatar(
          minRadius: 20,
          maxRadius: 20,
          //backgroundImage: AssetImage(user.avatarURL)
          backgroundImage: NetworkImage(user.avatarURL),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: Container(
          margin: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          color: Colors.transparent,
          height: 140.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                HandleString.validateForLongString(user.name),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    fontSize: 20),
              ),
              Text(
                'Xem trang cá nhân',
                style: TextStyle(
                    color: const Color(0xFFFFFFFF).withOpacity(0.75),
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600,
                    fontSize: 15),
              ),
              SizedBox(
                height: 40,
                //width: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: GroupButton(
                    options: GroupButtonOptions(
                      selectedTextStyle: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 11,
                      ),
                      unselectedTextStyle: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 11,
                      ),
                      selectedColor: ColorInPage.buttonColor,
                      unselectedColor: ColorInPage.buttonColor,
                      borderRadius: BorderRadius.circular(164),
                      //direction: Axis.vertical,
                      groupingType: GroupingType.row,
                    ),
                    isRadio: false,
                    onSelected: (index, isSelected, value) {
                      print('$index button is selected');
                    },
                    buttons: post.emotion.map((str) {
                      return HandleString.validateForLongString(str);
                    }).toList(),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Giá: ${HandleString.priceInPost(post)} VNĐ',
                    style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  Text(
                    HandleString.timeDistanceFromNow(post.time),
                    style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      actions: [
        Container(
          alignment: Alignment.topCenter,
          margin: const EdgeInsets.fromLTRB(24, 0, 0, 0),
          child: IconButton(
            padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
            onPressed: () {
              print('Change to Saved');
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const Saved()));
            },
            icon: const Image(
                //width: 8,
                //height: 16,
                image: AssetImage('assets/images/bookmark.png')),
          ),
        ),
      ],
    );

    final pageBody = Container(
      height: mediaQuery.size.height,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.fromLTRB(24, 24, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Mô tả',
                style: TextStyle(
                    fontFamily: 'Rotobo',
                    color: Color(0xFF0D0D26),
                    fontSize: 14,
                    wordSpacing: 2,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 6,
              ),
              RichText(
                text: TextSpan(
                  text: post.description,
                  style: const TextStyle(
                      fontFamily: 'Rotobo',
                      color: Color(0xFF95969D),
                      fontSize: 14,
                      wordSpacing: 2,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Row(
                children: const <Widget>[
                  Image(image: AssetImage("assets/images/icon_file.png")),
                  Text(
                    'Tệp đính kèm',
                    style: TextStyle(
                        fontFamily: 'Rotobo',
                        color: Color(0xFF0D0D26),
                        fontSize: 14,
                        wordSpacing: 2,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              ImageSlideshow(
                /// Width of the [ImageSlideshow].
                width: double.infinity,

                /// Height of the [ImageSlideshow].
                height: 200,

                /// The page to show when first creating the [ImageSlideshow].
                initialPage: 0,

                /// The color to paint the indicator.
                indicatorColor: ColorInPage.backgroundAppBar,

                /// The color to paint behind th indicator.
                indicatorBackgroundColor: Colors.grey,

                /// The widgets to display in the [ImageSlideshow].
                /// Add the sample image file into the images folder

                /// Called whenever the page in the center of the viewport changes.
                onPageChanged: (value) {
                  print('Page changed: $value');
                },

                /// Auto scroll interval.
                /// Do not auto scroll with null or 0.
                autoPlayInterval: 3000,

                /// Loops back to first slide.
                isLoop: true,

                children: [
                  ...post.attachmentsURL.map((photo) {
                    return Image.network(photo, fit: BoxFit.cover);
                  })
                ],
              ),
              const SizedBox(height: 100)
            ],
          ),
        ),
      ),
    );

    return InteractiveViewer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
              minimumSize: const Size(327, 56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              primary: const Color(0xFFEC1C24),
              onPrimary: Colors.white),
          child: const FittedBox(
            child: Text(
              'Apply',
              style: TextStyle(
                  //height: 26,
                  letterSpacing: 2,
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500),
            ),
          ),
          onPressed: () {
            print('Event: APPLY');
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Apply(
                  key: UniqueKey(),
                  postId: widget.postId,
                ),
              ),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
