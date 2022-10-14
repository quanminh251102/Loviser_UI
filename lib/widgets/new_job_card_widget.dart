import 'package:flutter/material.dart';
import 'package:loviser/modules/profile/pages/my_profile_page.dart';
import '../models/post.dart';
import 'package:loviser/pages/post_detail_page.dart';

class NewJobCard extends StatelessWidget {
  const NewJobCard({Key? key, required this.post}) : super(key: key);
  final Post post;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.3),
        highlightColor: Colors.grey.withOpacity(0.3),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => PostDetail(post: post),
          ),
        ),
        child: SizedBox(
          height: 110,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const MyProfilePage(),
                    ),
                  ),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(post.avaURL),
                    radius: 30,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Cảm xúc tiêu cực",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Giá: ${post.price} VND",
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          post.content,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[400],
                          ),
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    const Icon(Icons.bookmark_outline_sharp),
                    const SizedBox(
                      height: 20,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey[300],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
