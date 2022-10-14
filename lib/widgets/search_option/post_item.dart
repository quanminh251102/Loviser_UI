import 'package:flutter/material.dart';
import 'package:loviser/pages/job_detail.dart';
import 'package:provider/provider.dart';

import '../../providers/post.dart';
import '../../providers/users.dart';
//import '../../models/post.dart';

import '../../utils/handle_string.dart';

class PostItem extends StatelessWidget {
  //final Post post;

  //PostItem(this.post);
  const PostItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final post = Provider.of<Post>(context, listen: false);
    final user =
        Provider.of<Users>(context, listen: false).findById(post.userId);
    return Column(
      children: [
        const SizedBox(height: 16),
        InkWell(
          onTap: () {
            print('Event : Post item onTap');
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => JobDetail(
                postId: post.id,
              ),
            ));
          },
          child: Container(
              height: 74,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Container(
                margin: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CircleAvatar(
                      minRadius: 20,
                      maxRadius: 20,
                      backgroundImage:
                          //NetworkImage('https://picsum.photos/id/237/200/300'),
                          NetworkImage(user.avatarURL),
                    ),
                    SizedBox(
                      width: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          FittedBox(
                            child: Text(
                                HandleString.validateForLongString(user.name),
                                style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.left),
                          ),
                          FittedBox(
                            child: Text(
                                HandleString.validateForLongString(
                                    post.emotion[0]),
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 149, 150, 157),
                                ),
                                textAlign: TextAlign.left),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 120,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text('Giá: ${HandleString.priceInPost(post)} VNĐ',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xFF0D0D26),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              )),
                          Text(HandleString.timeDistanceFromNow(post.time),
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                                color: Color.fromARGB(255, 149, 150, 157),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ),
      ],
    );
  }
}
