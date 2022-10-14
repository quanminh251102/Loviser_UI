import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SocialIcon extends StatelessWidget {
  final String iconSrc;
  final Function press;
  const SocialIcon({
    Key? key, required this.iconSrc, required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press(),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Colors.white,),
          shape: BoxShape.circle,),
        child: Image(image: AssetImage(iconSrc))),
    );
  }
}