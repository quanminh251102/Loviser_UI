import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

class ColorInPage {
  static const blackColor = Color(0xFF0D0D26);
  static const backgroudColor = Color(0xFFFAFAFD);
  static const textColor = Color(0xFF000000);
  static const backgroundAppBar = Color(0xFF356899);
  static const buttonColor = Color(0xFF537fa8);
}

class ReasonForRefusal extends StatefulWidget {
  const ReasonForRefusal({Key? key}) : super(key: key);

  @override
  State<ReasonForRefusal> createState() => _ReasonForRefusalState();
}

class _ReasonForRefusalState extends State<ReasonForRefusal> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
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
      body: Container(
        width: mediaQuery.size.width,
        height: !isLandscape
            ? (mediaQuery.size.height - mediaQuery.padding.top) / 2
            : (mediaQuery.size.height - mediaQuery.padding.top),
        color: Colors.white,
        child: Container(
          margin: const EdgeInsets.fromLTRB(24, 0, 24, 29),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // !isLandscape
              //     ? const SizedBox(height: 25)
              //     : const SizedBox(height: 0),
              const Text(
                'Như Ý đã từ chối bạn làm người tư vấn',
                style: TextStyle(
                    fontFamily: 'DMSans',
                    color: Color(0xFF150B3D),
                    fontSize: 16,
                    wordSpacing: 2,
                    fontWeight: FontWeight.w700),
              ),
              Image.asset('assets/images/reason_for_refusal.gif', width: 150),
              Container(
                alignment: Alignment.center,
                height: 30,
                width: mediaQuery.size.width - 24 * 2,
                decoration: BoxDecoration(
                    color: const Color(0xFFF2F2F3),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(
                      width: 1,
                      color: const Color(0xFFF2F2F2),
                    )),
                child: const Text(
                  'Không đủ kinh nghiệm tư vấn ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Color(0xFF616161),
                      fontSize: 15,
                      wordSpacing: 2,
                      fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(height: 11),
              RichText(
                  text: const TextSpan(
                    text:
                        "Bạn đừng thất vọng nha, ở LOVISER đang còn rất nhiều người cần bạn tư vấn hãy apply vào các công việc tiếp theo nhé, Good luck 🍀",
                    style: TextStyle(
                        fontFamily: 'DMSans',
                        color: Color(0xFF524B6B),
                        fontSize: 12,
                        wordSpacing: 2,
                        fontWeight: FontWeight.w400),
                  ),
                  textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
