import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../cart/cubit.dart';
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
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xffD9D9D9),
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(4),
                  bottom: Radius.circular(4),
                ),
                child: Image.network(
                  model.imageUrl,
                  height: 169,
                  width: 161,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 169,
                    width: 161,
                    color: const Color(0xffD9D9D9),
                    child: const Icon(Icons.image_not_supported),
                  ),
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
                  // ---- زرار إضافة للـ cart فوق كل منتج ----
                  child: BlocBuilder<HomeCubit, HomeStates>(
                    builder: (context, state) {
                      final isLoading = state is HomeAddToCartLoadingState &&
                          state.productId == model.id;
                      return IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: isLoading
                            ? null
                            : () async {
                                final success = await cubit.addToCart(model);
                                if (context.mounted) {
                                  // تحديث السلة تلقائياً لو الكيوبت متاح في الـ context
                                  try {
                                    BlocProvider.of<CartCubit>(context).getCart();
                                  } catch (_) {}

                                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        success
                                            ? "${model.nameEn} added to cart!"
                                            : "Failed to add to cart. Please check your login.",
                                      ),
                                      duration: const Duration(seconds: 2),
                                      backgroundColor: success
                                          ? const Color(0xff434C6D)
                                          : Colors.red,
                                    ),
                                  );
                                }
                              },
                        icon: isLoading
                            ? const SizedBox(
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
          const SizedBox(height: 3),
          Text(
            model.nameEn,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xff434C6D),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            "${model.price.toString()} EGP",
            style: const TextStyle(
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
