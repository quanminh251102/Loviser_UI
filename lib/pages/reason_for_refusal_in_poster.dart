import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

class ColorInPage {
  static const blackColor = Color(0xFF0D0D26);
  static const backgroudColor = Color(0xFFFAFAFD);
  static const textColor = Color(0xFF000000);
  static const backgroundAppBar = Color(0xFF356899);
  static const buttonColor = Color(0xFF537fa8);
}

class ReasonForRefusalInPoster extends StatefulWidget {
  const ReasonForRefusalInPoster({Key? key}) : super(key: key);

  @override
  State<ReasonForRefusalInPoster> createState() => _ReasonForRefusalState();
}

// Emum
enum FavoriteMethod { notExperience, notSuitable, anotherReason }

class _ReasonForRefusalState extends State<ReasonForRefusalInPoster> {
  FavoriteMethod? _method = FavoriteMethod.notExperience;
  late bool isAnotherReason = false;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    final PreferredSizeWidget appBar = AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0))),
        elevation: 0.0,
        leading: const SizedBox(height: 0),
        backgroundColor: Colors.white);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          width: mediaQuery.size.width,
          height: !isLandscape
              ? (mediaQuery.size.height - mediaQuery.padding.top) * 0.7
              : (mediaQuery.size.height - mediaQuery.padding.top),
          color: Colors.white,
          child: Container(
            margin: (!isLandscape)
                ? const EdgeInsets.fromLTRB(24, 0, 24, 29)
                : const EdgeInsets.fromLTRB(80, 0, 80, 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // !isLandscape
                //     ? const SizedBox(height: 25)
                //     : const SizedBox(height: 0),
                const Text(
                  'Từ chối Thị Yến làm người tư vấn',
                  style: TextStyle(
                      fontFamily: 'DMSans',
                      color: Color(0xFF150B3D),
                      fontSize: 16,
                      wordSpacing: 2,
                      fontWeight: FontWeight.w700),
                ),

                const SizedBox(height: 11),
                RichText(
                    text: const TextSpan(
                      text:
                          "Vì sao bạn không chọn Thị Yến làm người tư vấn vấn đề tình cảm của bạn",
                      style: TextStyle(
                          fontFamily: 'DMSans',
                          color: Color(0xFF524B6B),
                          fontSize: 12,
                          wordSpacing: 2,
                          fontWeight: FontWeight.w400),
                    ),
                    textAlign: TextAlign.center),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      'Không đủ kinh nghiệm tư vấn',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Color(0xFF150B3D),
                      ),
                    ),
                    Radio<FavoriteMethod>(
                      activeColor: const Color(0xFFEC1C24),
                      value: FavoriteMethod.notExperience,
                      groupValue: _method,
                      onChanged: (value) {
                        setState(() {
                          _method = value;
                          isAnotherReason = false;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      'Không phù hợp với tôi',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Color(0xFF150B3D),
                      ),
                    ),
                    Radio<FavoriteMethod>(
                      activeColor: const Color(0xFFEC1C24),
                      value: FavoriteMethod.notSuitable,
                      groupValue: _method,
                      onChanged: (value) {
                        setState(() {
                          _method = value;
                          isAnotherReason = false;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Khác',
                          style: TextStyle(
                            fontFamily: 'DMSans',
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Color(0xFF150B3D),
                          ),
                        ),
                        SizedBox(
                          width: !isLandscape ? 250 : 350,
                          height: 50,
                          child: TextField(
                            cursorColor: const Color(0xFFAAA6B9),
                            controller: controller,
                            scrollPadding:
                                const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            enabled: isAnotherReason,
                            style: const TextStyle(
                              fontFamily: 'DMSans',
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Color(0xFFAAA6B9),
                            ),
                            decoration: const InputDecoration(
                              counterText: "",
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFAAA6B9)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFAAA6B9)),
                              ),
                              disabledBorder: InputBorder.none,
                              isDense: true,
                              hintStyle: TextStyle(
                                fontFamily: 'DMSans',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Color(0xFFAAA6B9),
                              ),
                              hintText: 'Nhập lí do bạn từ chối vào đây',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Radio<FavoriteMethod>(
                      activeColor: const Color(0xFFEC1C24),
                      value: FavoriteMethod.anotherReason,
                      groupValue: _method,
                      onChanged: (value) {
                        setState(() {
                          _method = value;
                          isAnotherReason = true;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Visibility(
          visible: !keyboardIsOpen,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0.0,
                shadowColor: Colors.transparent,
                minimumSize: !isLandscape
                    ? Size(mediaQuery.size.width - 24 * 2, 56)
                    : Size(mediaQuery.size.width - 80 * 2, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
                primary: const Color(0xFFEC1C24),
                onPrimary: Colors.white),
            child: const FittedBox(
              child: Text(
                'Xác nhận',
                style: TextStyle(
                    letterSpacing: 2,
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500),
              ),
            ),
            onPressed: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => ApplySuccess(
              //       postId: widget.postId,
              //     ),
              //   ),
              // );
              if (_method == FavoriteMethod.notExperience) {
                print('Ko kinh nghiem');
              }
              if (_method == FavoriteMethod.notSuitable) {
                print('TEST');
              }
              if (_method == FavoriteMethod.anotherReason) {
                print(controller.text);
              }
            },
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
