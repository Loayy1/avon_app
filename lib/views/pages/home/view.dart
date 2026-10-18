import 'package:cosmetics_app/views/pages/home/cubit.dart';
import 'package:cosmetics_app/views/pages/home/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'customs_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getData(),
      child: Builder(
        builder: (ctx) {
          final cubit = BlocProvider.of<HomeCubit>(ctx);
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(13),
                child: BlocBuilder(
                  bloc: cubit,
                  builder: (context, state) {
                    if (state is HomeLoadingState) {
                      return Center(child: CircularProgressIndicator(color: Color(0xffD75D72),));
                    } else if (state is HomeSuccessState) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
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
                                  borderSide: BorderSide(
                                    color: Color(0xffB3B3C1),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffB3B3C1),
                                  ),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                            ),
                            SizedBox(height: 13),
                            Image.asset("assets/images/home_discount_img.png"),
                            SizedBox(height: 26),
                            Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Text(
                                "Top rated products",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff434C6D),
                                ),
                              ),
                            ),
                            SizedBox(height: 14),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 15,
                                    mainAxisSpacing: 15,
                                    childAspectRatio: .7,
                                  ),
                              itemBuilder: (context, index) =>
                                  Items(model: state.list[index]),
                              itemCount: state.list.length > 4
                                  ? 4
                                  : state.list.length,
                            ),
                            SizedBox(height: 42),
                            Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Text(
                                "Most ordered Products",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff434C6D),
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 15,
                                    mainAxisSpacing: 15,
                                    childAspectRatio: .7,
                                  ),
                              itemBuilder: (context, index) =>
                                  Items(model: state.list[index + 4]),
                              itemCount: state.list.length > 4
                                  ? (state.list.length - 4 > 4
                                        ? 4
                                        : state.list.length - 4)
                                  : 0,
                            ),
                            SizedBox(height: 77),
                          ],
                        ),
                      );
                    }
                    return Text("Please call the method");
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
