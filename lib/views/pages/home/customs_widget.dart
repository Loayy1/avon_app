import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'cubit.dart';
import 'model.dart';
import 'states.dart';

class Items extends StatelessWidget {
  final ProductModel model;

  const Items({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeCubit>(context);
    return Container(
      height: 240,
      width: 176,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(0xffD9D9D9),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(4),
                  bottom: Radius.circular(4),
                ),
                child: Image.network(
                  model.imageUrl,
                  height: 169,
                  width: 161,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: 6,
                top: 6,
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  // ---- زرار إضافة للـ cart ----
                  child: BlocBuilder<HomeCubit, HomeStates>(
                    builder: (context, state) {
                      // لو الـ item دا بالذات بيتحمل
                      final isLoading = state is HomeAddToCartLoadingState &&
                          state.productId == model.id;
                      return IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: isLoading
                            ? null
                            : () {
                                cubit.addToCart(model);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "${model.nameEn} added to cart!",
                                    ),
                                    duration: Duration(seconds: 2),
                                    backgroundColor: Color(0xff434C6D),
                                  ),
                                );
                              },
                        icon: isLoading
                            ? SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Color(0xff434C6D),
                                ),
                              )
                            : SvgPicture.asset("assets/icons/cart.svg"),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 3),
          Text(
            model.nameEn,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xff434C6D),
            ),
          ),
          SizedBox(height: 3),
          Text(
            "${model.price.toString()} EGP",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xff70839C),
            ),
          ),
        ],
      ),
    );
  }
}
