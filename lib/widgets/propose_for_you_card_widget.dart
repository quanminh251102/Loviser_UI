import 'package:flutter/material.dart';
import 'package:loviser/modules/profile/pages/my_profile_page.dart';
import '../models/post.dart';

class ProposeForYouCard extends StatelessWidget {
  const ProposeForYouCard({Key? key, required this.post}) : super(key: key);
  final Post post;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      width: width * 0.3,
      height: height * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue[50],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
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
            const SizedBox(height: 7),
            const Text(
              "Tán tỉnh",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              "Giá: ${post.price} VND",
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 7),
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
    );
  }
}
