class StockItem {
  int? id;
  String? name;
  String? description;
  String? category;
  String? image;
  int? status = 0;

  StockItem({
    this.id,
    this.name,
    this.description,
    this.category,
    this.image,
    this.status,
  });

  StockItem.fromMap(Map<String, dynamic> result)
      : id = result["id"],
        name = result["name"],
        description = result["description"],
        category = result["category"],
        image = result["image"],
        status = result["status"];

  Map<String, Object> toMap() {
    return {
      'id': id!,
      'name': name!,
      'description': description!,
      'category': category!,
      'image': image!,
      'status': status!,
    };
  }
}
