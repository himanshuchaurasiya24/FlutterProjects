import 'package:food_delivery_mitch/models/food_model.dart';

class Resturant {
  final List<FoodModel> menu = [
    FoodModel(
      name: 'Classic Cheeseburger',
      description:
          'A juicy beef patty eith melted chedder, lettuce, tomato, and a hint of onion and pickle.',
      imagePath: 'assets/burgers/burger1.png',
      price: 0.99,
      catagory: FoodCatagory.burgers,
      availableAddon: [
        Addon(
          name: 'Extra cheese',
          price: 0.99,
        ),
        Addon(
          name: 'Bacon',
          price: 1.99,
        ),
        Addon(
          name: 'Avocado',
          price: 2.99,
        ),
      ],
    ),
    FoodModel(
      name: 'BBQ Bacon Burger',
      description:
          'Smoky BBQ sauce, crispy bacon, and onion rings make this beef burger a savory delight',
      imagePath: 'assets/burgers/burger2.png',
      price: 10.99,
      catagory: FoodCatagory.burgers,
      availableAddon: [
        Addon(
          name: 'Grilled Onions',
          price: 0.99,
        ),
        Addon(
          name: 'Jalapenos',
          price: 1.49,
        ),
        Addon(
          name: 'Extra BBQ sauce',
          price: 1.99,
        ),
      ],
    ),
    FoodModel(
      name: 'Veggie burger',
      description:
          'A heary veggie patty topped with fresh avocado, lettuce, and tomato, served on a whole plate.',
      imagePath: 'assets/burgers/burger3.png',
      price: 9.49,
      catagory: FoodCatagory.burgers,
      availableAddon: [
        Addon(
          name: 'Vegan cheese',
          price: 0.99,
        ),
        Addon(
          name: 'Grilled Mashrooms',
          price: 1.49,
        ),
        Addon(
          name: 'Humus Spread',
          price: 1.99,
        ),
      ],
    ),
    FoodModel(
      name: 'Aloha Burger',
      description:
          'A char-grilled chicken breast with a slice of grilled pineapple, Swiss cheese and sauce.',
      imagePath: 'assets/burgers/burger4.png',
      price: 9.49,
      catagory: FoodCatagory.burgers,
      availableAddon: [
        Addon(
          name: 'Teriyaki Glaze',
          price: 0.99,
        ),
        Addon(
          name: 'Extra Pineapple',
          price: 0.99,
        ),
        Addon(
          name: 'Bacon',
          price: 1.49,
        ),
      ],
    ),
    FoodModel(
      name: 'Blue Moon Burger',
      description:
          'This burger is a blue cheese lover\'s dream. It features a succulent ground beef patty.',
      imagePath: 'assets/burgers/burger5.png',
      price: 9.49,
      catagory: FoodCatagory.burgers,
      availableAddon: [
        Addon(
          name: 'Sauted Mushrooms',
          price: 0.99,
        ),
        Addon(
          name: 'Fried Egg',
          price: 1.49,
        ),
        Addon(
          name: 'Spicy Mayo',
          price: 0.99,
        ),
      ],
    ),
    FoodModel(
      name: 'Ceasar Salad',
      description:
          'Crisp romine lettuce, permesan cheese, croutons, and Ceasar dressing.',
      imagePath: 'assets/salads/salad1.png',
      price: 7.99,
      catagory: FoodCatagory.salads,
      availableAddon: [
        Addon(
          name: 'Grilled Chicken',
          price: 0.99,
        ),
        Addon(
          name: 'Anchovies',
          price: 1.49,
        ),
        Addon(
          name: 'Extra Permesan',
          price: 1.99,
        ),
      ],
    ),
    FoodModel(
      name: 'Greek Salad',
      description:
          'Tomatoes, cucumbers, red onions, olives, feta cheese with olive iol and herbs.',
      imagePath: 'assets/salads/salad2.png',
      price: 8.49,
      catagory: FoodCatagory.salads,
      availableAddon: [
        Addon(
          name: 'Feta Chicken',
          price: 0.99,
        ),
        Addon(
          name: 'Kalamata Olives',
          price: 1.49,
        ),
        Addon(
          name: 'Grilled Shrimp',
          price: 1.99,
        ),
      ],
    ),
    FoodModel(
      name: 'Quinoa Salad',
      description:
          'Quinoa mixed with cucumbers, tomatoes, bell peppers, and a lemon vinaigrette',
      imagePath: 'assets/salads/salad3.png',
      price: 9.99,
      catagory: FoodCatagory.salads,
      availableAddon: [
        Addon(
          name: 'Avocado',
          price: 0.99,
        ),
        Addon(
          name: 'Feta Cheese',
          price: 1.49,
        ),
        Addon(
          name: 'Grilled Chicken',
          price: 1.99,
        ),
      ],
    ),
    FoodModel(
      name: 'Asian Salad',
      description:
          'DElight in the flavors of the East with this sesame-infused salad. It includes mixed vegetables.',
      imagePath: 'assets/salads/salad4.png',
      price: 9.99,
      catagory: FoodCatagory.salads,
      availableAddon: [
        Addon(
          name: 'Mandarin Oranges',
          price: 0.99,
        ),
        Addon(
          name: 'Almonds Slivers',
          price: 1.49,
        ),
        Addon(
          name: 'Extra Teriyaki Chicken',
          price: 1.99,
        ),
      ],
    ),
    FoodModel(
      name: 'South West Chicken Salad',
      description:
          'This colorful salad combines the zesty flavors of the southwest. It\'s loaded with mixed potatoes.',
      imagePath: 'assets/salads/salad5.png',
      price: 9.99,
      catagory: FoodCatagory.salads,
      availableAddon: [
        Addon(
          name: 'Sour Cream',
          price: 0.99,
        ),
        Addon(
          name: 'Pico de Gallo',
          price: 1.49,
        ),
        Addon(
          name: 'Guacamole',
          price: 1.99,
        ),
      ],
    ),
  ];
}
