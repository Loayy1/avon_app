import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../cubit/categories_cubit.dart';
import '../cubit/categories_states.dart';
import 'widgets/customes_widget.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  // late final list = [
  //   _CategoriesModel(
  //     title: details!.list[0].titleEn,
  //     img: details!.list[0].imageUrl,
  //   ),
  //   _CategoriesModel(
  //     title: details!.list[1].titleEn,
  //     img: "assets/images/most_order_img1.jpg",
  //   ),
  //   _CategoriesModel(title: "Makeup", img: "assets/images/top_item2.jpg"),
  //   _CategoriesModel(
  //     title: "Skin Care",
  //     img: "assets/images/most_order_img4.jpg",
  //   ),
  //   _CategoriesModel(title: "Gifts", img: "assets/images/gifts.jpg"),
  // ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoriesCubit()..getData(),
      child: Builder(
        builder: (ctx) {
          final cubit = BlocProvider.of<CategoriesCubit>(ctx);
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 150,
              backgroundColor: Color(0xffD9D9D9),
              surfaceTintColor: Colors.transparent,
              title: Column(
                children: [
                  Text(
                    "Categories",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff434C6D),
                    ),
                  ),
                  SizedBox(height: 24),
                  TextFormField(
                    cursorColor: Color(0xff434C6D),
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff8E8EA9),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          "assets/icons/search.svg",
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: Color(0xffB3B3C1)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffB3B3C1)),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: BlocBuilder(
              bloc: cubit,
              builder: (context, state) {
                if (state is CategoriesLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(color: Color(0xffD75D72)),
                  );
                } else if (state is CategoriesSuccessState) {
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) =>
                              Items(model: state.list[index]),
                          separatorBuilder: (context, index) =>
                              Divider(color: Color(0x80B3B3C1)),
                          itemCount: state.list.length,
                        ),
                      ),
                      SizedBox(height: 60),
                    ],
                  );
                }
                return Text("please call the method");
              },
            ),
          );
        },
      ),
    );
  }
}
