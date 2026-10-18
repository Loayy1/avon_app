import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/logic/helper_methods.dart';
import '../../auth/log_in/view.dart';
import 'cubit.dart';
import 'customes_widget.dart';
import 'states.dart';

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
          final cubit = BlocProvider.of<ProfileCubit>(ctx);
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  BlocBuilder<ProfileCubit, ProfileStates>(
                    bloc: cubit,
                    builder: (context, state) {
                      final username = state is ProfileSuccessStates &&
                              state.profile?.username != null &&
                              state.profile!.username.isNotEmpty
                          ? state.profile!.username
                          : "My Profile";

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
                                      const Color(0xff434C6D).withValues(alpha: .6),
                                      const Color(0xffECA4C5),
                                    ],
                                    begin: AlignmentDirectional.topCenter,
                                    end: AlignmentDirectional.bottomCenter,
                                  ),
                                ),
                              ),
                              Center(
                                child: Transform.translate(
                                  offset: const Offset(0, 105),
                                  child: ClipOval(
                                    child: Image.asset(
                                      "assets/images/person.jpg",
                                      height: 96,
                                      width: 96,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 63),
                          Text(
                            username,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff434C6D),
                            ),
                          ),
                          if (state is ProfileSuccessStates &&
                              state.profile?.phoneNumber != null &&
                              state.profile!.phoneNumber.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              state.profile!.phoneNumber,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xff8E8EA9),
                              ),
                            ),
                          ],
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) =>
                        Item(model: cubit.list[index]),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemCount: cubit.list.length,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(13),
                    child: InkWell(
                      onTap: () async {
                        await cubit.logout();
                        goTo(page: LogInView(), keepHistory: false);
                      },
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
                            const SizedBox(width: 8),
                            const Text(
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
                  const SizedBox(height: 80),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
