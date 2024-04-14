// ignore_for_file: public_member_api_docs, sort_constructors_first
class FoodModel {
  final String name;
  final String description;
  final String imagePath;
  final double price;
  final FoodCatagory catagory;
  final List<Addon> availableAddon;
  FoodModel({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.catagory,
    required this.availableAddon,
  });
}

enum FoodCatagory {
  burgers,
  salads,
  drinks,
  desserts,
  sides,
}

class Addon {
  String name;
  double price;
  Addon({
    required this.name,
    required this.price,
  });
}
