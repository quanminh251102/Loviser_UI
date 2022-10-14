import 'package:flutter/material.dart';
import 'package:loviser/pages/post_option_page.dart';
import 'package:loviser/pages/proposal_for_you_page.dart';
import 'package:loviser/pages/search_option.dart';
import 'package:loviser/widgets/navigation_drawer_profile.dart';
import 'package:loviser/modules/profile/pages/my_profile_page.dart';
import 'package:provider/provider.dart';
import '../data/post_data.dart';
import '../models/post.dart';
import '../widgets/new_job_card_widget.dart';
import '../widgets/propose_for_you_card_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> posts = allPosts;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  void retrievingAccountValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("Account info: ");
    String? email = prefs.getString("email");
    print(email);
    String? password = prefs.getString("password");
    print(password);
  }

  @override
  Widget build(BuildContext context) {
    retrievingAccountValue();
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: const NavigationDrawerProfile(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 20, 12, 12),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                InkWell(
                  onTap: () => _key.currentState!.openDrawer(),
                  child: const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/huy_avatar.jpg'),
                    radius: 30,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Xin chào,',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Huy Nguyễn',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _showModalBottomSheet,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    shadowColor: Colors.black.withOpacity(0.00),
                  ),
                  child: Image.asset('assets/images/add.gif', width: 60),
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              height: 36,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                    child: Icon(
                      Icons.search,
                      color: Colors.grey[600],
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      onTap: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SearchOption()))
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Tán tỉnh, duy trì, thất tình,...',
                        hintStyle: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.pink[100],
                  ),
                  height: 36.0,
                  width: 36.0,
                  child: TextButton(
                    child: const Icon(Icons.tune),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 7,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Đề xuất cho bạn",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProposalForYouPage(),
                        ),
                      );
                    },
                    child: const Text(
                      "Xem tất cả",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 200,
              child: ListView.separated(
                separatorBuilder: (context, _) => const SizedBox(
                  width: 10,
                ),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: posts.length,
                itemBuilder: (context, index) =>
                    ProposeForYouCard(post: posts[index]),
              ),
            ),
            const SizedBox(height: 7),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Công việc mới",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProposalForYouPage(),
                        ),
                      );
                    },
                    child: const Text(
                      "Xem tất cả",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
            // proposeForYourCard(post: posts[0]),
            // newJobCard(post: posts[0]),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, _) => const SizedBox(
                  height: 7,
                ),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: posts.length,
                itemBuilder: (context, index) => NewJobCard(post: posts[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showModalBottomSheet() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (builder) {
        final width = MediaQuery.of(context).size.width;
        final height = MediaQuery.of(context).size.height;
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(100.0),
            ),
          ),
          height: height * 0.32,
          child: Column(
            children: [
              const Icon(Icons.remove, size: 40),
              SizedBox(
                width: width * 0.8,
                child: const Text(
                  "Bạn đang gặp vấn đề về chuyện tình cảm?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF150B3D),
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              SizedBox(
                width: width * 0.6,
                child: const Text(
                  "Đăng vấn đề của bạn và nhờ một freelancer có kinh nghiệm tư vấn!",
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              SizedBox(
                height: 50,
                width: 315,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const PostOption(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  child: const Text(
                    "Đăng vấn đề",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
