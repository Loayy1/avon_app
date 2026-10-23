import 'package:cosmetics_app/core/logic/helper_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../main/presentation/views/main_view.dart';

class CheckoutView extends StatelessWidget {
  final double subtotal;
  const CheckoutView({super.key, this.subtotal = 0.0});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Color(0xffD9D9D9),
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            goTo(page: ViewPage());
          },
          icon: Transform.translate(
            offset: Offset(3, 0),
            child: Icon(Icons.arrow_back_ios, size: 20),
          ),
          style: IconButton.styleFrom(
            fixedSize: Size(31, 31),
            backgroundColor: Color(0x0D101010),
          ),
        ),
        title: Text(
          "Checkout",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xff434C6D),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                color: Color(0x1C29D3DA),
              ),
              child: Padding(
                padding: const EdgeInsets.all(27),
                child: Column(
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        "Delivery to",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff434C6D),
                        ),
                      ),
                    ),
                    SizedBox(height: 18),
                    Container(
                      height: 84,
                      width: 309,
                      padding: EdgeInsets.all(12).copyWith(right: 0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff73B9BB)),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            "assets/images/map.jpg",
                            height: 60,
                            width: 97,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          "Home",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff434C6D),
                          ),
                        ),
                        subtitle: Text(
                          "Mansoura, 14 Porsaid St",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff8E8EA9),
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: Color(0xffD75D72),
                            size: 35,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        "Payment Method",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff434C6D),
                        ),
                      ),
                    ),
                    SizedBox(height: 18),
                    Container(
                      height: 57,
                      width: 309,
                      padding: EdgeInsets.all(12).copyWith(right: 0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff73B9BB)),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: SvgPicture.asset(
                              "assets/icons/meza.svg",
                              height: 20,
                              width: 30,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 6),
                          Text(
                            "**** **** **** 0256",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff434C6D),
                            ),
                          ),
                          SizedBox(width: 98),
                          IconButton(
                            onPressed: () {},
                            icon: Transform.translate(
                              offset: Offset(0, -8),
                              child: Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: Color(0xffD75D72),
                                size: 35,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    Container(
                      height: 57,
                      width: 309,
                      padding: EdgeInsets.all(12).copyWith(right: 0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff73B9BB)),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: SvgPicture.asset(
                              "assets/icons/voucher .svg",
                              height: 20,
                              width: 30,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 6),
                          Text(
                            "Add voucher",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff434C6D),
                            ),
                          ),
                          SizedBox(width: 98),
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 21,
                              ),
                              backgroundColor: Color(0xffD75D72),
                              foregroundColor: Colors.white
                            ),
                            child: Text(
                              "Apply",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32),
                    Text("- " * 42),
                    SizedBox(height: 32),
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        "- REVIEW PAYMENT",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff434C6D),
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        "PAYMENT SUMMARY",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff434C6D),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Subtotal",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff434C6D),
                          ),
                        ),
                        Text(
                          "${subtotal.toStringAsFixed(2)} EGP",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff434C6D),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "SHIPPING FEES",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff434C6D),
                          ),
                        ),
                        Text(
                          "TO BE CALCULATED",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff434C6D),
                          ),
                        ),
                      ],
                    ),
                    Divider(color: Color(0xff73B9BB)),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "TOTAL + VAT",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff434C6D),
                          ),
                        ),
                        Text(
                          "${subtotal.toStringAsFixed(2)} EGP",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff434C6D),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 35),
                    TextButton.icon(
                      onPressed: () {},
                      icon: SvgPicture.asset("assets/icons/order.svg"),
                      label: Text(
                        "ORDER",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xffD75D72),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          vertical: 21,
                          horizontal: 94,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
