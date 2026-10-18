class CategoryModel {
  final int id;
  final String titleEn;
  final String titleAr;
  final String imageUrl;

  const CategoryModel({
    required this.id,
    required this.titleEn,
    required this.titleAr,
    required this.imageUrl,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? 0,
      titleEn: (json['title_en'] ?? json['titleEn'] ?? json['name'] ?? "").toString(),
      titleAr: (json['title_ar'] ?? json['titleAr'] ?? "").toString(),
      imageUrl: (json['image_url'] ?? json['imageUrl'] ?? "").toString(),
    );
  }
}
