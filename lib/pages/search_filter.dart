import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:flutter/services.dart';

import '../widgets/search_filter/field_list.dart';
import '../widgets/search_filter/work_list.dart';
import '../models/work.dart';
import '../data/work_data.dart';

import '../pages/search_result.dart';

import '../providers/posts.dart';
import '../providers/post_filter.dart';
import '../providers/post_filters.dart';

import '../providers/authentication.dart';

import '../utils/handle_string.dart';

class ColorInPage {
  static const _blueColor = Color(0xFF356899);
  static const _blackColor = Color(0xFF0D0D26);
  static const _redColor = Color(0xFFEC1C24);
  static const _backgroudColor = Color(0xFFFAFAFD);
  static const _pinkColor = Color(0xFFf9babd);
  static const _grayShapeColor = Color(0xFFE4E5E7);
  static const _grayTextColor = Color(0xFF95969D);
}

class SearchFilter extends StatefulWidget {
  static const routeName = '/search-filter';
  const SearchFilter({Key? key}) : super(key: key);

  @override
  State<SearchFilter> createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {
  late List<String> fields;
  late List<Work> works;
  final TextEditingController _controller = TextEditingController();
  double startRange = 0;
  double endRange = 0;
  RangeValues _values = const RangeValues(0.1, 0.5);
  late String login;

  void deleteField(String content) {
    setState(() {
      fields.removeWhere((element) => element == content);
    });
  }

  void addField(String content) {
    setState(() {
      fields.insert(0, content);
    });
  }

  String fomartValueToVietNamPrice(double value, bool isStartRange) {
    // 0 - 0.5 => 0 - 1 MILION VND
    // 0.5 - 1 => 1 - 10 MILION VND
    double price = 0;
    if (value < 0.5) {
      price = (value * 1000000) / 0.5;
    } else {
      value = value - 0.5;
      price = 1000000;
      price = price + (value * 9000000) / 0.5;
    }

    if (isStartRange) {
      startRange = price;
    } else {
      endRange = price;
      print('Price range : $startRange - $endRange');
    }
    String result = HandleString.priceWithValue(price);

    // if (price >= 1000000) {
    //   result = (price / 1000000).toString();
    //   if (result.length > 8) result = result.substring(0, 7);
    //   result = '$result tr';
    // } else {
    //   result = (price / 1000).toString();
    //   if (result.length > 8) result = result.substring(0, 7);
    //   result = '$result k';
    // }
    return result;
  }

  void selectWork(Work work) {
    setState(() {
      int index = works.indexWhere((element) => element == work);
      works[index].isSelected = !works[index].isSelected;
    });
  }

  void navigateSearchResult(BuildContext context) {
    int newId = Provider.of<Posts>(context, listen: false).getPosts.length;

    PostFilter postFilter = PostFilter(
      id: 'pf$newId',
      userId: login,
      searchContent: fields,
      minPrice: startRange,
      maxPrice: endRange,
      isFullTime: works[0].isSelected,
      isDate: works[1].isSelected,
      isHour: works[2].isSelected,
      isMonth: works[3].isSelected,
      isYear: works[4].isSelected,
    );

    Provider.of<PostFilters>(context, listen: false).add(postFilter);

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SearchResult(postFilter: postFilter)));
  }

  @override
  void initState() {
    super.initState();

    print('Init Search Filter Pages');

    login = Provider.of<Authentication>(context, listen: false).userIdLogined;

    fields = [
      'Tiêu cực',
      'Tán tỉnh',
      'Nhắn tin',
      'Bất an',
      'Chán nản',
      'Bất an'
    ];

    works = allWork;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget appBar = AppBar(
      // systemOverlayStyle:
      //     SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      backgroundColor: ColorInPage._backgroudColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
      leading: Container(
        decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0))),
        child: IconButton(
          onPressed: () {
            print('Event: Exit Search Filter Page');
            Navigator.pop(context);
          },
          icon: Icon(
            size: 16,
            Icons.clear,
            color: ColorInPage._blackColor,
          ),
        ),
      ),
      title: const Text(
        'Lọc',
        style: TextStyle(
            fontFamily: 'Poppins',
            color: ColorInPage._blackColor,
            fontSize: 16,
            fontWeight: FontWeight.w600),
      ),
      actions: <Widget>[
        Container(
            decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.only(topRight: Radius.circular(25.0))),
            padding: const EdgeInsets.fromLTRB(0, 0, 24, 0),
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {
                print('Event : OnTap Xong label');
                navigateSearchResult(context);
              },
              child: const FittedBox(
                  child: Text(
                'Xong',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  // backgroundColor: Colors.blueAccent,
                  color: ColorInPage._blueColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              )),
            )),
      ],
      centerTitle: true,
      elevation: 0.0,
      // backgroundColor: Color.fromRGBO(250, 250, 253, 1),
    );

    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBar,
        body: SingleChildScrollView(
          child: Container(
            height: !isLandscape
                ? (mediaQuery.size.height -
                    appBar.preferredSize.height -
                    mediaQuery.padding.top)
                : (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    2,
            color: ColorInPage._backgroudColor,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                  color: ColorInPage._backgroudColor,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                            height: 52,
                            child: Focus(
                              onFocusChange: (focused) {
                                if (!focused && _controller.text.isNotEmpty) {
                                  addField(_controller.text);
                                  _controller.clear();
                                }
                              },
                              child: TextField(
                                  controller: _controller,
                                  //textAlign: TextAlign.center,
                                  cursorColor: ColorInPage._pinkColor,
                                  decoration: InputDecoration(
                                    prefixIcon: const Image(
                                        width: 15.64,
                                        height: 16.02,
                                        image: AssetImage(
                                            'assets/images/Search.png')),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    hintText: 'Thêm lĩnh vực sở trường của bạn',
                                    hintStyle: TextStyle(
                                        color: const Color(0xFF0D0D26)
                                            .withOpacity(0.4),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                    contentPadding:
                                        const EdgeInsets.fromLTRB(12, 10, 0, 0),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: ColorInPage._pinkColor),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  )),
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: (mediaQuery.size.height -
                                  appBar.preferredSize.height -
                                  mediaQuery.padding.top) *
                              0.16,
                          //color: Colors.yellow,
                          width: mediaQuery.size.width - 48,
                          child: FieldList(
                              fields: fields, deleteField: deleteField),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 1,
                          color: ColorInPage._grayShapeColor,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text("Giá tiền",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: ColorInPage._grayTextColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 15.0)),
                        const Text("Giá niêm yết trung bình là 100k VNĐ",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: ColorInPage._grayTextColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 13.0)),
                        const SizedBox(
                          height: 32,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                                '${fomartValueToVietNamPrice(_values.start, true)} VNĐ',
                                style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    color: ColorInPage._blackColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17.0)),
                            Text(
                                '${fomartValueToVietNamPrice(_values.end, false)} VNĐ',
                                style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    color: ColorInPage._blackColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17.0)),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SliderTheme(
                            data: SliderThemeData(
                                overlayShape: SliderComponentShape.noOverlay,
                                //trackHeight: 1,
                                thumbColor: ColorInPage._redColor,
                                activeTrackColor: ColorInPage._redColor,
                                inactiveTrackColor: ColorInPage._grayShapeColor,
                                activeTickMarkColor: Colors.transparent,
                                inactiveTickMarkColor: Colors.transparent),
                            child: RangeSlider(
                                divisions: 1000000,
                                values: _values,
                                onChanged: (newvalues) {
                                  setState(() {
                                    _values = newvalues;
                                  });
                                })),
                        const SizedBox(
                          height: 16,
                        ),
                        const Center(
                          child: Image(
                              width: 150,
                              height: 150,
                              image: AssetImage('assets/images/Search.gif')),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text("Các loại công việc",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: ColorInPage._grayTextColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 15.0)),
                        const SizedBox(
                          height: 8,
                        ),
                      ]),
                ),
                Container(
                    color: ColorInPage._backgroudColor,
                    margin: const EdgeInsets.fromLTRB(24, 0, 0, 0),
                    child: WorkList(works: works, selectWork: selectWork)),
                // if (isLandscape)
                //   Container(height: 32, color: ColorInPage._backgroudColor),
              ],
            ),
          ),
        ));
  }
}
