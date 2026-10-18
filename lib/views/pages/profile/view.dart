import 'package:cosmetics_app/views/pages/profile/cubit.dart';
import 'package:cosmetics_app/views/pages/profile/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'customes_widget.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getData(),
      child: Builder(
        builder: (ctx) {
          final cubit= BlocProvider.of<ProfileCubit>(ctx);
          return Scaffold(
            body: Column(
              children: [
                BlocBuilder(bloc: cubit,
                  builder: (context, state) {
                    if(state is ProfileLoadingStates){
                      return Center(child: CircularProgressIndicator(color: Color(0xffD75D72),),);
                    }else if(state is ProfileSuccessStates){
                      return Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 152,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xff434C6D).withValues(alpha: .6),
                                      Color(0xffECA4C5),
                                    ],
                                    begin: AlignmentDirectional.topCenter,
                                    end: AlignmentDirectional.bottomCenter,
                                  ),
                                ),
                              ),
                              Center(
                                child: Transform.translate(
                                  offset: Offset(0, 105),
                                  child: ClipOval(
                                    child: Image.asset(
                                      "assets/images/person.jpg",
                                      height: 96,
                                      width: 96,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 63),
                          Text(
                            "Salma Ahmed",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff434C6D),
                            ),
                          ),
                        ],
                      );
                    }
                    return Text("please call method");
                  },
                ),Column(
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Item(model: cubit.list[index]),
                      separatorBuilder: (context, index) => SizedBox(height: 10),
                      itemCount: cubit.list.length,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(13),
                      child: InkWell(
                        onTap: () {},
                        splashColor: Colors.red.withValues(alpha: .1),
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                          height: 50,
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/logout.svg",
                                height: 24,
                                width: 24,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Logout",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xffCD0F0F),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}



