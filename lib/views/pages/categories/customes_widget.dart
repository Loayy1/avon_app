import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../features/categories/data/models/category_model.dart';

class Items extends StatelessWidget {
  final CategoryModel model;

  const Items({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        ListTile(
          onTap: () {},
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: model.imageUrl.isNotEmpty
                ? Image.network(
                    model.imageUrl,
                    height: 69,
                    width: 60,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 69,
                      width: 60,
                      color: const Color(0xffD9D9D9),
                      child: const Icon(Icons.category, color: Color(0xff434C6D)),
                    ),
                  )
                : Container(
                    height: 69,
                    width: 60,
                    color: const Color(0xffD9D9D9),
                    child: const Icon(Icons.category, color: Color(0xff434C6D)),
                  ),
          ),
          title: Text(
            model.titleEn,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Color(0xff434C6D),
            ),
          ),
          trailing: SvgPicture.asset("assets/icons/forward.svg"),
        ),
        const SizedBox(height: 21),
      ],
    );
  }
}
