import 'package:flutter/material.dart';
import 'package:loviser/widgets/search_option/post_filter_item.dart';
import 'package:provider/provider.dart';

import '../../providers/post_filters.dart';
//import '../../providers/post_filter.dart';

class PostFilterList extends StatelessWidget {
  const PostFilterList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final postFiltersData = Provider.of<PostFilters>(context);
    final postFilters = postFiltersData.getPostFilters;
    return postFilters.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: const <Widget>[
                Text(
                  'Lịch sử trống',
                ),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return ChangeNotifierProvider.value(
                  value: postFilters[index], child: const PostFilterItem());
            },
            itemCount: postFilters.length,
          );
  }
}
