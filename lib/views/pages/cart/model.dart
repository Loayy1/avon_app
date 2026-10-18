class CartItemModel {
  final int productId;
  final String name;
  final String imageUrl;
  final double price;
  int quantity;

  CartItemModel({
    required this.productId,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    // الـ API ممكن يرجع الـ product nested أو flat
    final product = json["product"] as Map<String, dynamic>?;
    return CartItemModel(
      productId: json["productId"] ?? json["product_id"] ?? product?["id"] ?? 0,
      name: product?["name_en"] ?? json["name_en"] ?? json["name"] ?? "",
      imageUrl: product?["image_url"] ?? json["imageUrl"] ?? json["image_url"] ?? "",
      price: ((product?["price"] ?? json["price"] ?? 0) as num).toDouble(),
      quantity: json["quantity"] ?? 1,
    );
  }
}
