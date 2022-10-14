import 'package:flutter/material.dart';
import '../data/post_data.dart';
import '../models/post.dart';
import '../widgets/new_job_card_widget.dart';

List<Post> posts = allPosts;

class ProposalForYouPage extends StatelessWidget {
  const ProposalForYouPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Đề xuất cho bạn",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Thoát",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) =>
                      NewJobCard(post: posts[index]),
                  separatorBuilder: (context, _) => const SizedBox(
                    width: 10,
                  ),
                  itemCount: posts.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
