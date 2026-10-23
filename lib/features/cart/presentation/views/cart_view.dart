import 'package:cosmetics_app/core/logic/helper_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../data/models/cart_item_model.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/cart_states.dart';
import 'checkout_view.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    CartCubit? parentCubit;
    try {
      parentCubit = BlocProvider.of<CartCubit>(context);
    } catch (_) {}

    if (parentCubit != null) {
      return _CartContent(cubit: parentCubit);
    }

    return BlocProvider(
      create: (context) => CartCubit()..getCart(),
      child: Builder(
        builder: (ctx) => _CartContent(cubit: BlocProvider.of<CartCubit>(ctx)),
      ),
    );
  }
}

class _CartContent extends StatelessWidget {
  final CartCubit cubit;

  const _CartContent({required this.cubit});

  @override
  Widget build(BuildContext context) {
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
            onPressed: () => goTo(
              page: CheckoutView(subtotal: cubit.subtotal),
              keepHistory: true,
            ),
            icon: SvgPicture.asset(
              "assets/icons/shopping_cart_checkout_icon.svg",
            ),
          ),
        ],
      ),
      body: BlocConsumer<CartCubit, CartStates>(
        bloc: cubit,
        listener: (context, state) {
          if (state is CartFailedState) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is CartLoadingState && cubit.items.isEmpty) {
            return Center(
              child: CircularProgressIndicator(color: Color(0xffD75D72)),
            );
          }

          if (state is CartFailedState && cubit.items.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 56, color: Colors.grey),
                    SizedBox(height: 12),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Color(0xff434C6D)),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: cubit.getCart,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffD75D72),
                        foregroundColor: Colors.white,
                      ),
                      child: Text("Retry"),
                    ),
                  ],
                ),
              ),
            );
          }

          if (cubit.items.isEmpty) {
            return RefreshIndicator(
              onRefresh: cubit.getCart,
              color: Color(0xffD75D72),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(height: 120),
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: Color(0xffB3B3C1),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: Text(
                      "Your cart is empty",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff8E8EA9),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Center(
                    child: Text(
                      "Add items from the home screen to see them here.",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xff8E8EA9),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: cubit.getCart,
            color: Color(0xffD75D72),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(13),
                child: Column(
                  children: [
                    // عدد المنتجات في السلة
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
                    SizedBox(height: 24),
                    // قائمة المنتجات
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cubit.items.length,
                      separatorBuilder: (context, index) =>
                          Divider(color: Color(0x80B3B3C1)),
                      itemBuilder: (context, index) {
                        final item = cubit.items[index];
                        final isDeleting =
                            state is CartItemActionLoadingState &&
                                state.productId == item.productId;
                        return _CartItem(
                          model: item,
                          isDeleting: isDeleting,
                          onDelete: () => cubit.removeItem(item.productId),
                          onQuantityChanged: (newQty) =>
                              cubit.updateQuantity(item.productId, newQty),
                        );
                      },
                    ),
                    SizedBox(height: 25),
                    // ---- فاتورة الدفع المتجاوبة والديناميكية ----
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                onPressed: () => goTo(
                                  page: CheckoutView(subtotal: cubit.subtotal),
                                  keepHistory: true,
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xffD75D72),
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                    SizedBox(height: 80),
                  ],
                ),
              ),
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
  final bool isDeleting;
  final VoidCallback onDelete;
  final void Function(int) onQuantityChanged;

  const _CartItem({
    required this.model,
    this.isDeleting = false,
    required this.onDelete,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: 107,
                  height: 107,
                  child: model.imageUrl.isNotEmpty
                      ? Image.network(
                          model.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: Color(0xffD9D9D9),
                            child: Icon(Icons.image_not_supported,
                                color: Color(0xff8E8EA9)),
                          ),
                        )
                      : Container(
                          color: Color(0xffD9D9D9),
                          child: Icon(Icons.shopping_bag,
                              color: Color(0xff8E8EA9)),
                        ),
                ),
              ),
              Positioned(
                left: -6,
                top: -6,
                child: isDeleting
                    ? Padding(
                        padding: const EdgeInsets.all(12),
                        child: SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Color(0xffD75D72),
                          ),
                        ),
                      )
                    : IconButton(
                        onPressed: onDelete,
                        icon: SvgPicture.asset(
                          "assets/icons/delete.svg",
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ],
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff3B4569),
                  ),
                ),
                if (model.description != null &&
                    model.description!.isNotEmpty) ...[
                  SizedBox(height: 4),
                  Text(
                    model.description!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xBA3B4569),
                    ),
                  ),
                ],
                SizedBox(height: 8),
                Text(
                  "${model.price.toStringAsFixed(2)} EGP",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff3B4569),
                  ),
                ),
                SizedBox(height: 12),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Container(
                    height: 38,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff8E8EA9)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(
                            minWidth: 36,
                            minHeight: 36,
                          ),
                          onPressed: model.quantity <= 1
                              ? null
                              : () => onQuantityChanged(model.quantity - 1),
                          icon: Icon(Icons.remove, size: 18),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "${model.quantity}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Color(0xff434C6D),
                            ),
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(
                            minWidth: 36,
                            minHeight: 36,
                          ),
                          onPressed: () =>
                              onQuantityChanged(model.quantity + 1),
                          icon: Icon(Icons.add, size: 18),
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
    );
  }
}
