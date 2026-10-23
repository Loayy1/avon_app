import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:cosmetics_app/core/logic/dio_helper.dart';
import 'package:cosmetics_app/core/logic/helper_methods.dart';
import 'package:cosmetics_app/features/auth/presentation/views/login_view.dart';
import 'package:cosmetics_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:cosmetics_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:cosmetics_app/features/home/data/models/product_model.dart';

class Items extends StatelessWidget {
  final ProductModel model;

  const Items({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
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
                child: _AddToCartButton(model: model),
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

/// زر إضافة إلى السلة المعزول - يعمل rebuild لنفسه فقط ولا يعيد بناء الصفحة
class _AddToCartButton extends StatefulWidget {
  final ProductModel model;

  const _AddToCartButton({required this.model});

  @override
  State<_AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<_AddToCartButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: 32,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: isLoading
            ? null
            : () async {
                final messenger = ScaffoldMessenger.of(context);

                if (DioHelper.token == null || DioHelper.token!.isEmpty) {
                  messenger.hideCurrentSnackBar();
                  messenger.showSnackBar(
                    SnackBar(
                      content: const Text("Please login first to add items to cart"),
                      backgroundColor: Colors.red,
                      duration: const Duration(seconds: 3),
                      action: SnackBarAction(
                        label: "Login",
                        textColor: Colors.white,
                        onPressed: () {
                          goTo(page: const LogInView(), keepHistory: true);
                        },
                      ),
                    ),
                  );
                  return;
                }

                setState(() => isLoading = true);
                final homeCubit = BlocProvider.of<HomeCubit>(context);
                CartCubit? cartCubit;
                try {
                  cartCubit = BlocProvider.of<CartCubit>(context);
                } catch (_) {}

                final success = await homeCubit.addToCart(widget.model);

                if (!mounted) return;
                setState(() => isLoading = false);

                // تحديث السلة في الخلفية بدون عمل rebuild لصفحة الـ Home
                cartCubit?.getCart();

                messenger.hideCurrentSnackBar();
                messenger.showSnackBar(
                  SnackBar(
                    content: Text(
                      success
                          ? "${widget.model.nameEn} added to cart!"
                          : "Failed to add to cart. Please check your login.",
                    ),
                    duration: const Duration(seconds: 3),
                    backgroundColor:
                        success ? const Color(0xff434C6D) : Colors.red,
                    action: !success
                        ? SnackBarAction(
                            label: "Login",
                            textColor: Colors.white,
                            onPressed: () {
                              goTo(page: const LogInView(), keepHistory: true);
                            },
                          )
                        : null,
                  ),
                );
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
      ),
    );
  }
}
