import 'package:flutter/material.dart';
import 'package:loviser/modules/profile/widgets/card_description_widget.dart';
import 'package:loviser/modules/profile/widgets/card_language_widget.dart';
import 'package:loviser/modules/profile/widgets/card_profile_widget.dart';
import 'package:loviser/modules/profile/widgets/card_resume_widget.dart';
import 'package:loviser/modules/profile/widgets/card_skill_widget.dart';
import 'package:loviser/modules/profile/widgets/card_study_widget.dart';
import 'package:loviser/modules/profile/widgets/card_work_widget.dart';

class MyProfilePage extends StatelessWidget {
  final bool isMe;

  const MyProfilePage({
    super.key,
    this.isMe = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const double sizeBackground = 300;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFC).withOpacity(0.98),
      body: SafeArea(
        top: false,
        bottom: false,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 190,
              ),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: sizeBackground,
                    width: double.infinity,
                    child: Image.network(
                      'https://images.unsplash.com/photo-1660029865414-4a8f3c6ccc0e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=800&q=60',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: sizeBackground - 380 / 2,
                    child: CardProfileWidget(isMe: isMe),
                  ),
                  Positioned(
                    top: 50,
                    left: 7,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: CardWorkWidget(isMe: isMe),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: CardDescriptionWidget(
                    isMe: isMe,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: CardStudyWidget(isMe: isMe),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: CardResumeWidget(isMe: isMe),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: CardSkillWidget(isMe: isMe),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: CardLanguageWidget(isMe: isMe),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
