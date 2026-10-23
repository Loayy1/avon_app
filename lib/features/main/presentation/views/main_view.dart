import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../../../cart/presentation/views/cart_view.dart';
import '../../../categories/presentation/views/categories_view.dart';
import '../../../home/presentation/views/home_view.dart';
import '../../../profile/presentation/views/profile_view.dart';
import '../../cubit/navigation_cubit.dart';
import '../../cubit/navigation_states.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({super.key});

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  final controller = PageController(initialPage: 0);
  final pages = [HomeView(), CategoriesView(), CartView(), ProfileView()];
  final icons = [
    "assets/icons/home.svg",
    "assets/icons/categories.svg",
    "assets/icons/my_cart.svg",
    "assets/icons/profile.svg",
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CartCubit()..getCart()),
        BlocProvider(create: (context) => NavigationCubit()),
      ],
      child: Builder(
        builder: (ctx) {
          final cartCubit = BlocProvider.of<CartCubit>(ctx);
          final navCubit = BlocProvider.of<NavigationCubit>(ctx);
          return Scaffold(
            body: PageView(
              controller: controller,
              onPageChanged: (value) {
                navCubit.changePage(value);
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
                child: BlocBuilder<NavigationCubit, NavigationStates>(
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                        pages.length,
                        (index) => IconButton(
                          onPressed: () {
                            navCubit.changePage(index);
                            controller.jumpToPage(index);
                            if (index == 2) {
                              cartCubit.getCart();
                            }
                          },
                          icon: SvgPicture.asset(
                            icons[index],
                            colorFilter: ColorFilter.mode(
                              navCubit.currentIndex == index
                                  ? const Color(0xffD75D72)
                                  : const Color(0xff8E8EA9),
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
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
