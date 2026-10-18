import 'package:cosmetics_app/views/pages/cart/cubit.dart';
import 'package:cosmetics_app/views/pages/cart/view.dart';
import 'package:cosmetics_app/views/pages/categories/view.dart';
import 'package:cosmetics_app/views/pages/home/view.dart';
import 'package:cosmetics_app/views/pages/profile/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({super.key});

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  int currentPage = 0;
  final controller = PageController(initialPage: 0);
  final pages = [HomeView(), CategoriesView(), CartView(), ProfileView()];
  final icons = [
    "assets/icons/home.svg",
    "assets/icons/categories.svg",
    "assets/icons/my_cart.svg",
    "assets/icons/profile.svg",
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit()..getCart(),
      child: Builder(
        builder: (ctx) {
          final cartCubit = BlocProvider.of<CartCubit>(ctx);
          return Scaffold(
            body: PageView(
              controller: controller,
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
                if (value == 2) {
                  cartCubit.getCart();
                }
              },
              children: pages,
            ),
            floatingActionButton: Padding(
              padding: const EdgeInsets.all(13),
              child: Container(
                height: 64,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: const Color(0xffD9D9D9),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: .1),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    pages.length,
                    (index) => IconButton(
                      onPressed: () {
                        setState(() {
                          controller.jumpToPage(index);
                        });
                        if (index == 2) {
                          cartCubit.getCart();
                        }
                      },
                      icon: SvgPicture.asset(
                        icons[index],
                        colorFilter: ColorFilter.mode(
                          currentPage == index
                              ? const Color(0xffD75D72)
                              : const Color(0xff8E8EA9),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          );
        },
      ),
    );
  }
}
