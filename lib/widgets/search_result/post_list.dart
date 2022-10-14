import 'package:flutter/material.dart';
import 'package:loviser/providers/post_filter.dart';
import 'package:provider/provider.dart';

import '../../providers/posts.dart';

import './post_item.dart';

class PostList extends StatelessWidget {
  final PostFilter postFilter;
  final int maxAmout;

  const PostList({Key? key, required this.postFilter, required this.maxAmout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final posts = Provider.of<Posts>(context, listen: false)
        .getPostWithFilterAndMaxAmout(postFilter, maxAmout);

    return posts.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: const <Widget>[
                Text('Bài đăng trống'),
              ],
            );
          })
        : Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.start,
            spacing: !isLandscape
                ? mediaQuery.size.width - 48 - 156 * 2
                : mediaQuery.size.width - 48 - 156 * 3,
            runSpacing: 8,
            children: posts.map((item) {
              return ChangeNotifierProvider.value(
                  value: item, child: const PostItem());
            }).toList());
  }
}
