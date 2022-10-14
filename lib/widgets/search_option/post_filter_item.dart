import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../pages/search_result.dart';

import '../../providers/post_filter.dart';
import '../../providers/post_filters.dart';
import '../../providers/posts.dart';
//import '../../providers/post.dart';
import '../../providers/authentication.dart';

//  Get width of device : MediaQuery.of(context).size.width
class ColorInPage {
  static const Color backgroudColor = Color(0xFFFAFAFD);
  static const Color backBold = Color(0xFF0D0D26);
  static const Color inputFoucusColor = Color(0xFFf9babd);
  static const Color iconColor = Color(0xFF95969D);
}

class PostFilterItem extends StatelessWidget {
  const PostFilterItem({Key? key}) : super(key: key);

  void navigateSearchResult(BuildContext context, List<String> searchContent) {
    int newId = Provider.of<Posts>(context, listen: false).getPosts.length;
    String login =
        Provider.of<Authentication>(context, listen: false).userIdLogined;

    PostFilter postFilter = PostFilter(
        id: 'pf$newId',
        userId: login,
        searchContent: searchContent,
        minPrice: 0,
        maxPrice: 10000000,
        isFullTime: true,
        isDate: true,
        isHour: true,
        isMonth: true,
        isYear: true);

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SearchResult(postFilter: postFilter)));
  }

  @override
  Widget build(BuildContext context) {
    final postFilter = Provider.of<PostFilter>(context, listen: false);
    final getContent = postFilter.sumSearchContent();
    final content = getContent.length > 20
        ? ('${getContent.substring(0, 20)}...')
        : getContent;

    return InkWell(
      onTap: () => navigateSearchResult(context, postFilter.searchContent),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 11),
          Row(children: <Widget>[
            const Image(
              width: 16,
              height: 16,
              image: AssetImage('assets/images/Clock.png'),
            ),
            const SizedBox(width: 16),
            Text(
              content,
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: ColorInPage.iconColor),
            ),
            Expanded(child: Container()),
            InkWell(
              child: const Image(
                width: 11.25,
                height: 11.25,
                image: AssetImage('assets/images/CrossSmall.png'),
              ),
              onTap: () {
                print(
                    'Event : remove history item  ${postFilter.searchContent}');
                Provider.of<PostFilters>(context, listen: false)
                    .remove(postFilter);
              },
            )
          ]),
          const SizedBox(height: 11),
          Container(color: const Color(0xFFCACBCE), width: 1)
        ],
      ),
    );
  }
}
