import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/post.dart';
import '../../providers/users.dart';

import '../../pages/job_detail.dart';

import '../../utils/handle_string.dart';

const _blackColor = Color(0xFF0D0D26);

class PostItem extends StatelessWidget {
  const PostItem({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final post = Provider.of<Post>(context, listen: false);
    final user =
        Provider.of<Users>(context, listen: false).findById(post.userId);
    return InkWell(
      onTap: () {
        print('Event : Post item Ontap');
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => JobDetail(
              postId: post.id,
            ),
          ),
        );
      },
      child: Container(
          height: 150,
          width: 156,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  minRadius: 30,
                  maxRadius: 30,
                  backgroundImage: NetworkImage(user.avatarURL),
                ),
                Text(HandleString.validateForLongString(user.name),
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        color: _blackColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.left),
                Text(HandleString.validateForLongString(post.emotion[0]),
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: _blackColor.withOpacity(0.5),
                    ),
                    textAlign: TextAlign.left),
                Text('Giá: ${HandleString.priceInPost(post)} VNĐ',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      color: _blackColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    )),
              ],
            ),
          )),
    );
  }
}
