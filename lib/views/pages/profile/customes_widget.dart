import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileModel {
  String title, img;

  ProfileModel({required this.title, required this.img});
}

class Item extends StatelessWidget {
  final ProfileModel model;

  const Item({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(13).copyWith(bottom: 0),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {},
        child: SizedBox(
          height: 50,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              SvgPicture.asset(model.img, height: 18, width: 18),
              SizedBox(width: 8),
              Text(
                model.title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff434C6D),
                ),
              ),
              Spacer(),
              SvgPicture.asset(
                "assets/icons/forward.svg",
                fit: BoxFit.scaleDown,
                height: 24,
                width: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}