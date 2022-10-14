import 'package:flutter/material.dart';
import 'package:loviser/providers/post_filters.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'package:loviser/pages/search_filter.dart';

import '../widgets/search_option/post_list.dart';
import '../widgets/search_option/post_filter_list.dart';

import '../pages/search_filter.dart';
import '../pages/search_result.dart';

import '../providers/posts.dart';
import '../providers/post_filter.dart';

import '../providers/authentication.dart';

import '../providers/users.dart';

class ColorInPage {
  static const Color backgroudColor = Color(0xFFFAFAFD);
  static const Color backBold = Color(0xFF0D0D26);
  static const Color inputFoucusColor = Color(0xFFf9babd);
  static const Color iconColor = Color(0xFF95969D);
}

class SearchOption extends StatefulWidget {
  static const routeName = '/search-option';

  const SearchOption({Key? key}) : super(key: key);

  @override
  State<SearchOption> createState() => _SearchOptionState();
}

class _SearchOptionState extends State<SearchOption> {
  late List<String> issue;
  late List<String> issueSuggested;
  late String query = '';
  final TextEditingController _controller = TextEditingController();
  late String login;

  var _isInit = true;
  var _isLoading = false;

  void searchIssue(String query) {
    print(query);

    final newIssue = issue.where((issue) {
      final issueLower = issue.toLowerCase();

      final searchLower = query.toLowerCase();

      print('$issueLower $searchLower');

      return issueLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      issueSuggested = newIssue;
    });
  }

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

    print('Init Search Option Pages');

    login = Provider.of<Authentication>(context, listen: false).userIdLogined;

    issue = [
      'Thất tình',
      'Thất vọng',
      'Tha lỗi',
      'Tán tỉnh',
      'Cảm xúc',
      'Buồn'
    ];
  }

  @override
  void didChangeDependencies() {
    // if (_isInit) {
    //   setState(() {
    //     _isLoading = true;
    //   });
    //   Provider.of<Users>(context).fetchAndSetUsers().then((_) {
    //     setState(() {
    //       _isLoading = false;
    //     });
    //   });
    // }
    // _isInit = false;

    super.didChangeDependencies();
  }

  void navigateSearchResult(BuildContext context, String searchContent) {
    int newId = Provider.of<Posts>(context, listen: false).getPosts.length;

    PostFilter postFilter = PostFilter(
      id: 'pf$newId',
      userId: login,
      searchContent: [searchContent],
      minPrice: 0,
      maxPrice: 10000000,
      isFullTime: true,
      isDate: true,
      isHour: true,
      isMonth: true,
      isYear: true,
    );

    Provider.of<PostFilters>(context, listen: false).add(postFilter);

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SearchResult(postFilter: postFilter)));
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final addHeight = (isLandscape) ? 0.4 : 0;

    final PreferredSizeWidget appBar = AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      leading: Container(
          margin: const EdgeInsets.fromLTRB(24 - 8, 0, 0, 0),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
              print('Event : Exit Search Option Pages');
            },
            icon: const Icon(
              Icons.clear,
              color: Colors.black45,
            ),
          )),
      title: const Text(
        'Tìm kiếm',
        style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16.0,
            color: Colors.black,
            fontWeight: FontWeight.w600),
      ),
      centerTitle: true,
      elevation: 0.0,
      backgroundColor: ColorInPage.backgroudColor,
    );

    final searchBar = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: SizedBox(
            height: 52,
            child: Focus(
              onFocusChange: (focused) {
                if (!focused && _controller.text.isNotEmpty) {
                  String searchContain = _controller.text;
                  _controller.clear();
                  query = '';
                  searchIssue(query);
                  navigateSearchResult(context, searchContain);
                }
              },
              child: TextField(
                  controller: _controller,
                  onChanged: searchIssue,
                  cursorColor: ColorInPage.inputFoucusColor,
                  decoration: InputDecoration(
                    prefixIcon: const Image(
                        width: 15.64,
                        height: 16.02,
                        image: AssetImage('assets/images/Search.png')),
                    border: const OutlineInputBorder(),
                    hintText: 'Tìm kiếm vấn đề phù hợp',
                    hintStyle: const TextStyle(
                        fontSize: 15.0,
                        color: Color(0xFFE4E5E7),
                        fontWeight: FontWeight.w400),
                    isDense: true, // important line
                    contentPadding: const EdgeInsets.fromLTRB(54, 15, 26, 14),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: ColorInPage.inputFoucusColor),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          const BorderSide(color: ColorInPage.inputFoucusColor),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  )),
            ),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Stack(children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {
                print('Event icon filter onTap');
                // Navigator.of(context).push(
                //     MaterialPageRoute(builder: (context) => SearchFilter()));
                navigateToSearchFilter(context);
              },
              child: Container(
                  height: 52,
                  width: 48,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                    shape: BoxShape.rectangle,
                    border: Border.all(
                        color: const Color.fromARGB(255, 149, 150, 157),
                        width: 1),
                  ),
                  child: const Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 15.6,
                      width: 17.33,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Image(
                            image: AssetImage('assets/images/Filter.png')),
                      ),
                    ),
                  )),
            ),
          ),
        ]),
      ],
    );

    final pageBody = Scaffold(
        appBar: appBar,
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: query.isEmpty
                    ? Container(
                        color: ColorInPage.backgroudColor,
                        margin: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                        child: Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            //crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              SizedBox(
                                height: (mediaQuery.size.height -
                                        appBar.preferredSize.height -
                                        mediaQuery.padding.top) *
                                    0.2,
                                child: searchBar,
                              ),
                              Container(
                                height: (mediaQuery.size.height -
                                        appBar.preferredSize.height -
                                        mediaQuery.padding.top) *
                                    0.08,
                                alignment: Alignment.topLeft,
                                child: const Text("Tìm kiếm gần đây",
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: ColorInPage.backBold,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0)),
                              ),
                              SizedBox(
                                  height: (mediaQuery.size.height -
                                          appBar.preferredSize.height -
                                          mediaQuery.padding.top) *
                                      (0.25 + addHeight),
                                  //child: HistoryList(history, _deleteHistory)
                                  child: const PostFilterList()),
                              Container(
                                height: (mediaQuery.size.height -
                                        appBar.preferredSize.height -
                                        mediaQuery.padding.top) *
                                    0.08,
                                alignment: Alignment.topLeft,
                                child: const Text(
                                  "Đã xem gần đây",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: ColorInPage.backBold,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height: (mediaQuery.size.height -
                                          appBar.preferredSize.height -
                                          mediaQuery.padding.top) *
                                      (0.45 + addHeight),
                                  child: const PostList()),
                            ]),
                      )
                    : Container(
                        color: ColorInPage.backgroudColor,
                        margin: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                        child: Column(children: <Widget>[
                          SizedBox(
                              height: (mediaQuery.size.height -
                                      appBar.preferredSize.height -
                                      mediaQuery.padding.top) *
                                  0.2,
                              child: searchBar),
                          for (var i in issueSuggested)
                            InkWell(
                              onTap: () {
                                _controller.text = i;
                              },
                              child: Container(
                                alignment: Alignment.centerLeft,
                                padding:
                                    const EdgeInsets.fromLTRB(46, 10, 0, 0),
                                child: Text(
                                  i.toString(),
                                  style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            )
                        ]),
                      )));

    return pageBody;
  }
}
