import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/posts.dart';
import '../../providers/authentication.dart';
import '../../providers/users.dart';

import './post_item.dart';

class PostList extends StatelessWidget {
  const PostList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final login =
        Provider.of<Authentication>(context, listen: false).userIdLogined;
    final userLogined =
        Provider.of<Users>(context, listen: false).findById(login);
    final posts = Provider.of<Posts>(context, listen: false)
        .getPostsWithPostWatchedIds(userLogined.postIdWatched);

    return posts.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: const <Widget>[
                Text(
                  'Trống',
                ),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
                value: posts[index], child: const PostItem()),
            itemCount: posts.length,
          );
  }
}
