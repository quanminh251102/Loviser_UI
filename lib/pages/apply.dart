/*
  Page content  
  1) - appbar

  2) - text 'Chon ho so'
     - profile list
  
  3) - text 'Lua chon'
     - row select : agreePriceCard , dealPriceCard

  4) - text 'Thu gioi thieu'

 */
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:math';

// import 'package:flutter/foundation.dart';
// import 'package:path_provider/path_provider.dart';

import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:loviser/pages/apply_success.dart';
import 'package:loviser/providers/authentication.dart';
import 'package:provider/provider.dart';

import '../providers/post.dart';
import '../providers/posts.dart';
import '../providers/users.dart';
import '../providers/authentication.dart';
import '../providers/profiles.dart';
import '../providers/applys.dart' as provider;

import '../widgets/search_option/post_item.dart';

import '../utils/handle_string.dart';

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

class Apply extends StatefulWidget {
  final String postId;

  const Apply({Key? key, required this.postId}) : super(key: key);

  @override
  State<Apply> createState() => _ApplyState();
}

class _ApplyState extends State<Apply> {
  //late User user = currentUser;
  late bool isArgeePrice = true;
  late bool isDealPrice = false;
  late bool isDealPriceValueError = true;
  late List<bool> isProfilesSelected;
  late String login;
  late User userLogined;
  late List<Profile> profilesOfUserLogined;
  TextEditingController controller = TextEditingController();
  late String pathPdfFile = "Tải file PDF";

  void _pickFile(BuildContext context) async {
    // opens storage to pick files and the picked file or files
    // are assigned into result and if no file is chosen result is null.
    // you can also toggle "allowMultiple" true or false depending on your need
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    // if no file is picked
    if (result == null) return;

    // we will log the name, size and path of the
    // first picked file (if multiple are selected)
    print(result.files.first.name);
    print(result.files.first.size);
    print(result.files.first.path);

    String path = result.files.first.path ?? "";
    File imgfile = File(path);
    Uint8List imgbytes = await imgfile.readAsBytes();
    String bs4str = base64Encode(imgbytes);
    print(bs4str);
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => PDFScreen(path: result.files.first.path),
    //   ),
    // );

    Uint8List decodedbytes = base64.decode(bs4str);
    File decodedimgfile = await File("make_pdf.pdf").writeAsBytes(decodedbytes);
    String decodedpath = decodedimgfile.path;
    print(decodedpath);

    setState(() {
      pathPdfFile = HandleString.validateForLongString(result.files.first.name);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    //print(login);
  }

  @override
  void initState() {
    super.initState();
    login = Provider.of<Authentication>(context, listen: false).userIdLogined;

    userLogined = Provider.of<Users>(context, listen: false).findById(login);

    profilesOfUserLogined =
        Provider.of<Profiles>(context, listen: false).findWithUserId(login);

    isProfilesSelected = List<bool>.filled(profilesOfUserLogined.length, false);

    print(isProfilesSelected);
  }

  Widget proFileItem(
    String userName,
    Profile profile,
    int isSelected,
    double profileHeight,
    double profileWidth,
  ) {
    double minSize = min(profileHeight, profileWidth);
    return CustomCard(
      color: Colors.white,
      shadowColor: const Color(0xFF000000).withOpacity(0.02),
      borderRadius: 16,
      //width: 160,
      width: profileWidth,
      child: Stack(alignment: Alignment.center, children: <Widget>[
        Column(
          children: <Widget>[
            CustomCard(
              elevation: 0,
              shadowColor: Colors.white,
              width: minSize * 0.5,
              height: minSize * 0.5,
              borderWidth: minSize * 0.01,
              borderColor: isProfilesSelected[isSelected]
                  ? const Color(0xFFECE9F6)
                  : const Color(0xFFFFE1E2),
              color: ColorInPage.backgroudColor,
              borderRadius: 167,
              child: Center(
                  child: Image.asset(
                'assets/images/${profile.type}.png',
                width: minSize * 0.5,
                height: minSize * 0.5,
                scale: 1,
              )),
            ),
            TextInPage.textTilteBlack(
                HandleString.validateForLongString(userName),
                size: minSize / 10),
            TextInPage.textTilteBlack(
                HandleString.validateForLongString(profile.name),
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                size: minSize / 15,
                color: const Color(0xFF95969D)),
          ],
        ),
        Positioned(
            top: profileHeight * 0.025,
            right: profileWidth * 0.025,
            width: profileWidth * 0.2,
            height: profileHeight * 0.2,
            child: Checkbox(
              activeColor: Colors.red,
              shape: const CircleBorder(),
              side: const BorderSide(width: 1, color: Color(0xFFCACBCE)),
              value: isProfilesSelected[isSelected],
              onChanged: (value) {
                print(isProfilesSelected[isSelected]);
                setState(() {
                  isProfilesSelected[isSelected] =
                      !isProfilesSelected[isSelected];
                });
              },
            )),
      ]),
    );
  }

  Widget agreePriceCard(
    Post post,
    double profileHeight,
    double profileWidth,
  ) {
    return CustomCard(
      width: profileWidth,
      shadowColor: const Color(0xFF000000).withOpacity(0.02),
      borderRadius: 16,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: profileHeight * 0.15,
            left: profileWidth * 0.05,
            width: profileWidth * 0.2,
            height: profileWidth * 0.2,
            child: Checkbox(
              activeColor: Colors.red,
              shape: const CircleBorder(),
              side: const BorderSide(width: 1, color: Color(0xFFCACBCE)),
              value: isArgeePrice,
              onChanged: (value) {
                setState(() {
                  isDealPrice = !isDealPrice;
                  isArgeePrice = !isArgeePrice;
                });
              },
            ),
          ),
          Positioned(
              top: profileHeight * 0.08,
              left: profileWidth * 0.25,
              width: profileWidth * 0.6,
              height: profileHeight * 0.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF356899),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    alignment: Alignment.center,
                    height: profileHeight * 0.25,
                    width: profileWidth * 0.5,
                    child: TextInPage.textTilteBlack('Đồng ý với giá',
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Roboto',
                        size: 10,
                        space: 0,
                        color: Colors.white),
                  ),
                  FittedBox(
                    child: TextInPage.textTilteBlack(
                      'Giá: ${HandleString.priceInPost(post)} VNĐ',
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Roboto',
                      size: 14,
                      space: 0,
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }

  Widget dealPriceCard(
    double profileHeight,
    double profileWidth,
  ) {
    return CustomCard(
      width: profileWidth,
      shadowColor: const Color(0xFF000000).withOpacity(0.02),
      borderRadius: 16,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: profileHeight * 0.15,
            left: profileWidth * 0.05,
            width: profileWidth * 0.2,
            height: profileWidth * 0.2,
            child: Checkbox(
              activeColor: Colors.red,
              shape: const CircleBorder(),
              side: const BorderSide(width: 1, color: Color(0xFFCACBCE)),
              value: isDealPrice,
              onChanged: (value) {
                setState(() {
                  isDealPrice = !isDealPrice;
                  isArgeePrice = !isArgeePrice;
                });
              },
            ),
          ),
          Positioned(
              top: profileHeight * 0.08,
              left: profileWidth * 0.3,
              height: profileHeight * 0.25,
              width: profileWidth * 0.5, //46,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFE6D73),
                  borderRadius: BorderRadius.circular(6),
                ),
                alignment: Alignment.center,
                height: profileHeight * 0.25,
                width: profileWidth * 0.5,
                child: TextInPage.textTilteBlack('Deal giá',
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Roboto',
                    size: 10,
                    space: 0,
                    color: Colors.white),
              )),
          Positioned(
              top: profileHeight * 0.45,
              left: profileWidth * 0.25,
              height: profileHeight * 0.25,
              width: profileWidth * 0.65, //46,
              child: Row(children: <Widget>[
                Container(
                  height: profileHeight * 0.25,
                  width: profileWidth * 0.5,
                  decoration: const BoxDecoration(
                      border: Border(
                          left: BorderSide(
                            width: 2,
                            color: Color(0xFF0070BA),
                          ),
                          top: BorderSide(
                            width: 2,
                            color: Color(0xFF0070BA),
                          ),
                          right: BorderSide(
                            width: 2,
                            color: Color(0xFF0070BA),
                          ),
                          bottom: BorderSide(
                            width: 2,
                            color: Color(0xFF0070BA),
                          )),

                      // Make rounded corners
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      )),
                ),
                Container(
                  height: profileHeight * 0.25,
                  width: profileWidth * 0.15,
                  decoration: const BoxDecoration(
                      border: Border(
                          left: BorderSide(
                            width: 2,
                            color: Color(0xFF0070BA),
                          ),
                          top: BorderSide(
                            width: 2,
                            color: Color(0xFF0070BA),
                          ),
                          right: BorderSide(
                            width: 2,
                            color: Color(0xFF0070BA),
                          ),
                          bottom: BorderSide(
                            width: 2,
                            color: Color(0xFF0070BA),
                          )),
                      // Make rounded corners
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      )),
                  child: const Center(
                      child: Text(
                    'VNĐ',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 8,
                        color: Color(0xFF243656)),
                  )),
                )
              ])),
          Positioned(
            top: profileHeight * 0.535,
            left: profileWidth * 0.25,
            height: profileHeight * 0.27,
            width: profileWidth * 0.6,
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

                    return 'Giá phải lớn hơn 1k';
                  }

                  isDealPriceValueError = false;

                  return HandleString.priceWithValue(double.parse(text));
                },
                keyboardType: TextInputType.number,
                readOnly: !isDealPrice,
                style: const TextStyle(fontSize: 12),
                decoration: const InputDecoration(
                  counterText: "",
                  errorStyle: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w100,
                    fontSize: 10,
                    color: Colors.red,
                  ),
                  contentPadding: EdgeInsets.fromLTRB(10, 1, 0, 0),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  isDense: true,
                  hintStyle: TextStyle(
                      fontFamily: 'Roboto',
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w100,
                      fontSize: 8,
                      color: Color(0xFF243656)),
                  hintText: 'Nhập giá vào đây',
                )),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final post =
        Provider.of<Posts>(context, listen: false).findById(widget.postId);
    // final user =
    //     Provider.of<Users>(context, listen: false).findById(post.userId);

    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    // Handle Size Item
    final paddingPageLeftRight = 24.0;
    final spaceBetweenProfile = 24.0;

    final mediaHeight = mediaQuery.size.height;
    final mediaWidth = mediaQuery.size.width -
        paddingPageLeftRight * 2 -
        (((!isLandscape) ? spaceBetweenProfile : spaceBetweenProfile * 2));
    final profileHeight =
        (!isLandscape) ? mediaHeight * 0.2 : mediaHeight * 0.3;
    final profileWidth =
        (!isLandscape) ? mediaWidth * 0.5 : mediaWidth * (1 / 3);

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
          margin: (!isLandscape)
              ? const EdgeInsets.fromLTRB(36, 0, 36, 0)
              : const EdgeInsets.fromLTRB(36, 0, 36, 0),
          // color: Colors.yellow,
          alignment: Alignment.topCenter,
          child: IgnorePointer(
            ignoring: true,
            child: ChangeNotifierProvider.value(
                value: post, child: const PostItem()),
          ),
        ),
      ),
    );

    final pageBody = SingleChildScrollView(
        child: Container(
      margin: const EdgeInsets.fromLTRB(24, 16, 0, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextInPage.textTilteBlack('Chọn hồ sơ'),
          const SizedBox(height: 16),
          SizedBox(
              height: profileHeight,
              // height: 165,
              //color: Colors.amber[300],
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    for (final profile in profilesOfUserLogined) ...[
                      proFileItem(
                        userLogined.name,
                        profile,
                        profilesOfUserLogined.indexOf(profile),
                        profileHeight,
                        profileWidth, // index
                      ),
                      SizedBox(width: spaceBetweenProfile)
                    ],
                  ],
                ),
              )),
          const SizedBox(height: 11),
          TextInPage.textTilteBlack('Lựa chọn'),
          const SizedBox(height: 16),
          SizedBox(
              //height: 80,
              height: profileHeight * 0.7,
              // margin: const EdgeInsets.fromLTRB(0, 0, 24, 0),
              //color: Colors.amber[300],
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    agreePriceCard(
                      post,
                      profileHeight * 0.7,
                      profileWidth,
                    ),
                    SizedBox(
                      width: spaceBetweenProfile,
                    ),
                    dealPriceCard(
                      profileHeight * 0.7,
                      profileWidth,
                    )
                  ],
                ),
              )),
          const SizedBox(height: 16),
          Row(
            children: <Widget>[
              TextInPage.textTilteBlack('Thư giới thiệu '),
              const Text(
                '(Không bắt buộc)',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w300,
                    fontSize: 16),
              )
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: !isLandscape ? 100 : 200,
            margin: const EdgeInsets.fromLTRB(0, 0, 24, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CustomCard(
                  childPadding: 0,
                  shadowColor: const Color(0xFF000000).withOpacity(0.02),
                  width: mediaQuery.size.width * 0.6,
                  borderRadius: 12,
                  child: SizedBox(
                    //height: 100,
                    width: mediaQuery.size.width * 0.6,
                    child: const TextField(
                        maxLines: 20,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          wordSpacing: 1,
                          color: Color(0xFFAFB0B6),
                        ),
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.fromLTRB(10, 1, 0, 0),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0, color: Colors.white),
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0, color: Colors.white),
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Color(0xFFAFB0B6)),
                          hintText: 'Viết thư apply vào công việc...',
                        )),
                  ),
                ),
                //const SizedBox(width: 16),
                CustomCard(
                  onTap: () {
                    _pickFile(context);
                  },
                  color: Colors.white,
                  shadowColor: const Color(0xFF000000).withOpacity(0.02),
                  width: mediaQuery.size.width * 0.15,
                  borderRadius: 12,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/Clock.png',
                          color: const Color(0xFF356899),
                        ),
                        Text(
                          pathPdfFile,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                            color: Color(0xFF356899),
                          ),
                        )
                      ]),
                )
              ],
            ),
          ),
        ],
      ),
    ));
    return InteractiveViewer(
      child: Scaffold(
        backgroundColor: ColorInPage.backgroudColor,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[appBar];
          },
          body: pageBody,
        ),
        floatingActionButton: Visibility(
            visible: !keyboardIsOpen,
            child: ElevatedButton(
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
                  'Apply',
                  style: TextStyle(
                      letterSpacing: 2,
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500),
                ),
              ),
              onPressed: () {
                List<String> profileIdSelected = [];
                for (var index = 0;
                    index < isProfilesSelected.length;
                    index++) {
                  if (isProfilesSelected[index] == true) {
                    profileIdSelected.add(profilesOfUserLogined[index].id);
                  }
                }

                provider.Apply apply = provider.Apply(
                  id: 'apply-test',
                  userId: login,
                  postId: widget.postId,
                  status: 'Đang chờ',
                  price: isArgeePrice
                      ? post.price
                      : (!isDealPriceValueError
                          ? double.parse(controller.text)
                          : 0),
                  profilesIdSelected: profileIdSelected,
                );
                print('$isDealPriceValueError ${apply.price}');

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ApplySuccess(
                      postId: widget.postId,
                    ),
                  ),
                );
              },
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

class PDFScreen extends StatefulWidget {
  final String? path;

  PDFScreen({Key? key, this.path}) : super(key: key);

  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Document"),
      //   actions: <Widget>[
      //     IconButton(
      //       icon: Icon(Icons.share),
      //       onPressed: () {},
      //     ),
      //   ],
      // ),
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0))),
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
        title: TextInPage.textTilteBlack('PDF Viewer'),
      ),
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: widget.path,
            enableSwipe: true,
            swipeHorizontal: true,
            autoSpacing: false,
            pageFling: true,
            pageSnap: true,
            defaultPage: currentPage!,
            fitPolicy: FitPolicy.BOTH,
            preventLinkNavigation:
                false, // if set to true the link is handled in flutter
            onRender: (_pages) {
              setState(() {
                pages = _pages;
                isReady = true;
              });
            },
            onError: (error) {
              setState(() {
                errorMessage = error.toString();
              });
              print(error.toString());
            },
            onPageError: (page, error) {
              setState(() {
                errorMessage = '$page: ${error.toString()}';
              });
              print('$page: ${error.toString()}');
            },
            onViewCreated: (PDFViewController pdfViewController) {
              _controller.complete(pdfViewController);
            },
            onLinkHandler: (String? uri) {
              print('goto uri: $uri');
            },
            onPageChanged: (int? page, int? total) {
              print('page change: $page/$total');
              setState(() {
                currentPage = page;
              });
            },
          ),
          errorMessage.isEmpty
              ? !isReady
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container()
              : Center(
                  child: Text(errorMessage),
                )
        ],
      ),
      floatingActionButton: FutureBuilder<PDFViewController>(
        future: _controller.future,
        builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
          if (snapshot.hasData) {
            return FloatingActionButton.extended(
              backgroundColor: const Color(0xFFf9babd),
              label: Text("Trang ${pages! ~/ 2}"),
              onPressed: () async {
                await snapshot.data!.setPage(pages! ~/ 2);
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}
