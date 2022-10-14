import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import '../widgets/search_result/post_list.dart';
import '../pages/search_filter.dart';

import '../providers/post_filter.dart';
import '../providers/posts.dart';

class ColorInPage {
  static const blueColor = Color(0xFF356899);
  static const blackColor = Color(0xFF0D0D26);
  static const redColor = Color(0xFFEC1C24);
  static const backgroudColor = Color(0xFFFAFAFD);
  static const pinkColor = Color(0xFFf9babd);
  static const grayShapeColor = Color(0xFFE4E5E7);
  static const grayTextColor = Color(0xFF95969D);
}

class SearchResult extends StatefulWidget {
  static const routeName = '/search-result';
  final PostFilter postFilter;

  const SearchResult({Key? key, required this.postFilter}) : super(key: key);

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  late bool isFullPostSuitable;
  late bool isFullPostSuggested;

  void navigateToSearchFilter(BuildContext ctxRoot) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: ctxRoot,
        builder: (ctx) => SizedBox(
              height: (MediaQuery.of(ctxRoot).size.height -
                  MediaQuery.of(ctxRoot).padding.top),
              child: const SearchFilter(),
            ));
  }

  @override
  void initState() {
    super.initState();

    isFullPostSuitable = false;
    isFullPostSuggested = false;

    print('Init Search Result Pages');
  }

  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<Posts>(context, listen: false)
        .getPostWithFilter(widget.postFilter);
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final getContent = widget.postFilter.sumSearchContent();
    final title = getContent.length > 20
        ? ('${getContent.substring(0, 20)}...')
        : getContent;

    final PreferredSizeWidget appBar = AppBar(
      systemOverlayStyle:
          const SystemUiOverlayStyle(statusBarColor: Colors.white),
      elevation: 0.0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(4.0),
        child: Container(
          margin: const EdgeInsets.fromLTRB(24, 0, 24, 0),
          color: const Color(0xFFC4C4C4),
          height: 1.0,
        ),
      ),
      backgroundColor: Colors.white,
      leading: Container(
        margin: const EdgeInsets.fromLTRB(24, 0, 0, 0),
        child: IconButton(
          onPressed: () {
            print('Back to Search Filter Page');
            Navigator.pop(context);
          },
          icon: const Image(
              width: 8,
              height: 16,
              image: AssetImage('assets/images/searchResult_left.png')),
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
            fontFamily: 'Poppins',
            color: ColorInPage.blackColor,
            fontSize: 16,
            fontWeight: FontWeight.w600),
      ),
      actions: <Widget>[
        Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 24, 0),
          // color: Colors.black45,
          alignment: Alignment.center,
          child: IconButton(
            onPressed: () {
              print('Exit Search Result Page');
              Navigator.pop(context);
            },
            icon: Icon(
              size: 20,
              Icons.clear,
              color: Color(0xFFAFB0B6),
            ),
          ),
        ),
      ],
    );
    return Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                  height: (mediaQuery.size.height -
                          appBar.preferredSize.height -
                          mediaQuery.padding.top) *
                      (0.1 + (isLandscape ? 0.1 : 0)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('${posts.length} vấn đề được tìm thấy',
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              color: ColorInPage.redColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            )),
                        InkWell(
                          onTap: () {
                            print('Event : OnTap Filter Icon');
                            navigateToSearchFilter(context);
                          },
                          child: const Image(
                              color: ColorInPage.redColor,
                              image: AssetImage('assets/images/FilterRed.png')),
                        )
                      ]),
                ),
              ),
              Container(
                color: ColorInPage.backgroudColor,
                margin: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                child: Column(children: <Widget>[
                  SizedBox(
                    height: 57,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text('Vấn đề phù hợp',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: ColorInPage.blackColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            )),
                        InkWell(
                          onTap: () {
                            print('Event : OnTap label');
                            setState(() {
                              isFullPostSuitable = !isFullPostSuitable;
                            });
                          },
                          child:
                              Text((!isFullPostSuitable) ? 'Tất cả' : 'Thu gọn',
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    color: ColorInPage.grayTextColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      height: (150 * (posts.length + 1) / 2 +
                          8 * (posts.length + 1) / 2),
                      child: (isFullPostSuitable)
                          ? PostList(
                              postFilter: widget.postFilter,
                              maxAmout: posts.length)
                          : PostList(
                              postFilter: widget.postFilter, maxAmout: 4)),
                  SizedBox(
                    height: 57,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text('Gợi ý',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: ColorInPage.blackColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            )),
                        InkWell(
                          onTap: () {
                            print('Event : Ontap label');
                            setState(() {
                              isFullPostSuggested = !isFullPostSuggested;
                            });
                          },
                          child: Text(
                              (!isFullPostSuggested) ? 'Tất cả' : 'Thu gọn',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                color: ColorInPage.grayTextColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              )),
                        ),
                      ],
                    ),
                  ),
                  (!isLandscape)
                      ? SizedBox(
                          child: (isFullPostSuggested)
                              ? PostList(
                                  postFilter: widget.postFilter,
                                  maxAmout: posts.length)
                              : PostList(
                                  postFilter: widget.postFilter, maxAmout: 2))
                      : SizedBox(
                          //height: 200 * ((posts.length + 1) / 2),
                          child: (isFullPostSuggested)
                              ? PostList(
                                  postFilter: widget.postFilter,
                                  maxAmout: posts.length)
                              : PostList(
                                  postFilter: widget.postFilter, maxAmout: 2)),
                ]),
              ),
            ],
          ),
        ));
  }
}
