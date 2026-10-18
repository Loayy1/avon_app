import 'package:cosmetics_app/core/logic/helper_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'checkout.dart';
import 'cubit.dart';
import 'model.dart';
import 'states.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit()..getCart(),
      child: Builder(
        builder: (ctx) {
          final cubit = BlocProvider.of<CartCubit>(ctx);
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 100,
              backgroundColor: Color(0xffD9D9D9),
              surfaceTintColor: Colors.transparent,
              title: Text(
                "My Cart",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff434C6D),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () => goTo(page: CheckoutView()),
                  icon: SvgPicture.asset(
                    "assets/icons/shopping_cart_checkout_icon.svg",
                  ),
                ),
              ],
            ),
            body: BlocBuilder<CartCubit, CartStates>(
              bloc: cubit,
              builder: (context, state) {
                if (state is CartLoadingState || state is CartRemoveLoadingState) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is CartFailedState) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, size: 48, color: Colors.grey),
                        SizedBox(height: 12),
                        Text(state.message),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: cubit.getCart,
                          child: Text("Retry"),
                        ),
                      ],
                    ),
                  );
                }
                if (cubit.items.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart_outlined,
                            size: 72, color: Color(0xffD9D9D9)),
                        SizedBox(height: 16),
                        Text(
                          "Your cart is empty",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff8E8EA9),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(13),
                    child: Column(
                      children: [
                        // عدد المنتجات ديناميكي
                        Align(
                          alignment: AlignmentDirectional.topStart,
                          child: Text(
                            "You have ${cubit.items.length} product${cubit.items.length == 1 ? '' : 's'} in your cart",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0x8C434C6D),
                            ),
                          ),
                        ),
                        SizedBox(height: 34),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: cubit.items.length,
                          separatorBuilder: (_, __) =>
                              Divider(color: Color(0x80B3B3C1)),
                          itemBuilder: (context, index) => _CartItem(
                            model: cubit.items[index],
                            onDelete: () =>
                                cubit.removeItem(cubit.items[index].productId),
                            onQuantityChanged: (newQty) => cubit.updateQuantity(
                              cubit.items[index].productId,
                              newQty,
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        // ---- فاتورة الدفع ----
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(28),
                          decoration: BoxDecoration(
                            color: Color(0xffDDF3EF),
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "- REVIEW PAYMENT",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff526273),
                                  letterSpacing: 0.5,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                "PAYMENT SUMMARY",
                                style: TextStyle(
                                  fontSize: 27,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff526273),
                                  letterSpacing: 1,
                                ),
                              ),
                              SizedBox(height: 28),
                              // Subtotal ديناميكي
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Subtotal",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff526273),
                                    ),
                                  ),
                                  Text(
                                    "${cubit.subtotal.toStringAsFixed(2)} EGP",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff526273),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "SHIPPING FEES",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff526273),
                                    ),
                                  ),
                                  Text(
                                    "TO BE CALCULATED",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff526273),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 32),
                              Container(
                                height: 1,
                                width: double.infinity,
                                color: Color(0x1C29D3DA),
                              ),
                              SizedBox(height: 32),
                              // Total ديناميكي
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "TOTAL + VAT",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff526273),
                                    ),
                                  ),
                                  Text(
                                    "${cubit.subtotal.toStringAsFixed(2)} EGP",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff526273),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 38),
                              Center(
                                child: SizedBox(
                                  width: 300,
                                  height: 70,
                                  child: ElevatedButton(
                                    onPressed: () => goTo(page: CheckoutView()),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xffD75D72),
                                      foregroundColor: Colors.white,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.shopping_cart_checkout,
                                            size: 25),
                                        SizedBox(width: 12),
                                        Text(
                                          "PROCEED CHECKOUT",
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 70),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// ---- Cart Item Widget ----
class _CartItem extends StatelessWidget {
  final CartItemModel model;
  final VoidCallback onDelete;
  final void Function(int) onQuantityChanged;

  const _CartItem({
    required this.model,
    required this.onDelete,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    width: 107,
                    height: 107,
                    child: Image.network(
                      model.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: Color(0xffD9D9D9),
                        child: Icon(Icons.image_not_supported),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: -6,
                  top: -6,
                  child: IconButton(
                    onPressed: onDelete,
                    icon: SvgPicture.asset(
                      "assets/icons/delete.svg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0).copyWith(bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff3B4569),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "${model.price.toStringAsFixed(2)} EGP",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff3B4569),
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(left: 90),
                    child: Container(
                      height: 42,
                      width: 142,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff8E8EA9)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: model.quantity == 1
                                ? null
                                : () => onQuantityChanged(model.quantity - 1),
                            icon: Icon(Icons.remove),
                          ),
                          SizedBox(width: 7),
                          Text("${model.quantity}"),
                          SizedBox(width: 7),
                          IconButton(
                            onPressed: () =>
                                onQuantityChanged(model.quantity + 1),
                            icon: Icon(Icons.add),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 14),
      ],
    );
  }
}
