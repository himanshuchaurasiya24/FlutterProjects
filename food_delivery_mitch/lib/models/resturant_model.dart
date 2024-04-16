import 'package:flutter/material.dart';
import 'package:food_delivery_mitch/models/food_model.dart';

class Resturant extends ChangeNotifier {
  final List<FoodModel> _menu = [
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
    FoodModel(
      name: 'Sweet Potato Fries',
      description: 'Crispy sweet potato fries with a touch of salt.',
      imagePath: 'assets/sides/side1.png',
      price: 4.99,
      catagory: FoodCatagory.sides,
      availableAddon: [
        Addon(
          name: 'Cheese Sauce',
          price: 0.99,
        ),
        Addon(
          name: 'Truffle Iol',
          price: 1.49,
        ),
        Addon(
          name: 'Cajun Spice',
          price: 1.99,
        ),
      ],
    ),
    FoodModel(
      name: 'Onion Rings',
      description: 'Golden and crispy onion rings, perfect for dipping.',
      imagePath: 'assets/sides/side2.png',
      price: 3.99,
      catagory: FoodCatagory.sides,
      availableAddon: [
        Addon(
          name: 'Ranch Dip',
          price: 0.99,
        ),
        Addon(
          name: 'Spicy Mayo',
          price: 1.49,
        ),
        Addon(
          name: 'Permesan Dust',
          price: 1.99,
        ),
      ],
    ),
    FoodModel(
      name: 'Garlic Bread',
      description:
          'Warm and toasty garlic bread, topped eith melted butter and parsley',
      imagePath: 'assets/sides/side3.png',
      price: 4.99,
      catagory: FoodCatagory.sides,
      availableAddon: [
        Addon(
          name: 'Extra Garlic',
          price: 0.99,
        ),
        Addon(
          name: 'Mozzarella Cheese',
          price: 1.49,
        ),
        Addon(
          name: 'Marinara Dip',
          price: 1.99,
        ),
      ],
    ),
    FoodModel(
      name: 'Loaded Sweet Potato Fries',
      description:
          'Savory sweet potato fries with melted cheese, smoky bacon bits, and a dollop of salt.',
      imagePath: 'assets/sides/side4.png',
      price: 4.99,
      catagory: FoodCatagory.sides,
      availableAddon: [
        Addon(
          name: 'Saur Cream',
          price: 0.99,
        ),
        Addon(
          name: 'Bacon Bits',
          price: 1.49,
        ),
        Addon(
          name: 'Green Onions',
          price: 1.99,
        ),
      ],
    ),
    FoodModel(
      name: 'Crispy Mac & Cheese Bites',
      description:
          'Golden brown, bite-sized mac and cheese balls, perfect for on-the-go snacking. Served with sauce.',
      imagePath: 'assets/sides/side5.png',
      price: 3.99,
      catagory: FoodCatagory.sides,
      availableAddon: [
        Addon(
          name: 'Bacon Bits',
          price: 0.99,
        ),
        Addon(
          name: 'Jalepeno Slices',
          price: 1.49,
        ),
        Addon(
          name: 'Sriracha Drizzle',
          price: 1.99,
        ),
      ],
    ),
    FoodModel(
      name: 'Chocolate Brownie',
      description:
          'Rich and fudgy chocolate brownie, with chunks of chocolate.',
      imagePath: 'assets/desserts/dessert1.png',
      price: 3.99,
      catagory: FoodCatagory.desserts,
      availableAddon: [
        Addon(
          name: 'Vanilla Ice Cream',
          price: 0.99,
        ),
        Addon(
          name: 'Hot Fudge',
          price: 1.49,
        ),
        Addon(
          name: 'Whipped Cream',
          price: 1.99,
        ),
      ],
    ),
    FoodModel(
      name: 'Cheesecake',
      description:
          'Creamy cheesecake on a grahm cracker crust, eith a berry compote.',
      imagePath: 'assets/desserts/dessert2.png',
      price: 3.99,
      catagory: FoodCatagory.desserts,
      availableAddon: [
        Addon(
          name: 'Strawberry Topping',
          price: 0.99,
        ),
        Addon(
          name: 'Blueberry Compote',
          price: 1.49,
        ),
        Addon(
          name: 'Chocolate Chips',
          price: 1.99,
        ),
      ],
    ),
    FoodModel(
      name: 'Apple Pie',
      description:
          'Classic apple pie with a flaky crust and a cinnamon-spiced apple filling.',
      imagePath: 'assets/desserts/dessert3.png',
      price: 3.99,
      catagory: FoodCatagory.desserts,
      availableAddon: [
        Addon(
          name: 'Caramel Sauce',
          price: 0.99,
        ),
        Addon(
          name: 'Vanilla Ice Cream',
          price: 1.49,
        ),
        Addon(
          name: 'Cinnamon Spice',
          price: 1.99,
        ),
      ],
    ),
    FoodModel(
      name: 'Red Velvet lava Cake',
      description:
          'A delectable red velvet cake with a warm, goey chocolate lava center, served with a dessert.',
      imagePath: 'assets/desserts/dessert4.png',
      price: 3.99,
      catagory: FoodCatagory.desserts,
      availableAddon: [
        Addon(
          name: 'Raspberry Sauce',
          price: 0.99,
        ),
        Addon(
          name: 'Cream Cheese Icing',
          price: 1.49,
        ),
        Addon(
          name: 'Chocolate Sprinkles',
          price: 1.99,
        ),
      ],
    ),
    FoodModel(
      name: 'Pineapple Cake',
      description: 'A pineapple cake added with sugerfree sweetness.',
      imagePath: 'assets/desserts/dessert5.png',
      price: 3.99,
      catagory: FoodCatagory.desserts,
      availableAddon: [
        Addon(
          name: 'Raspberry Sauce',
          price: 0.99,
        ),
        Addon(
          name: 'Cream Cheese Icing',
          price: 1.49,
        ),
        Addon(
          name: 'Chocolate Sprinkles',
          price: 1.99,
        ),
      ],
    ),
    FoodModel(
      name: 'Lemonade',
      description:
          'Refreshing lemonade made with real lemons and a touch of sweetness.',
      imagePath: 'assets/drinks/drink1.png',
      price: 3.99,
      catagory: FoodCatagory.drinks,
      availableAddon: [
        Addon(
          name: 'Strawberry Flavor',
          price: 0.99,
        ),
        Addon(
          name: 'Mont Leaves',
          price: 1.49,
        ),
        Addon(
          name: 'Ginger Zest',
          price: 1.99,
        ),
      ],
    ),
    FoodModel(
      name: 'Iced Tea',
      description: 'Chilled iced tea with a hint of lemon, served over ice.',
      imagePath: 'assets/drinks/drink2.png',
      price: 3.99,
      catagory: FoodCatagory.drinks,
      availableAddon: [
        Addon(
          name: 'Peach Flavor',
          price: 0.99,
        ),
        Addon(
          name: 'Lemon Slices',
          price: 1.49,
        ),
        Addon(
          name: 'Honey',
          price: 1.99,
        ),
      ],
    ),
    FoodModel(
      name: 'Smoothie',
      description:
          'A bleed of fresh friuts and yogurt, perfect for a healthy boost.',
      imagePath: 'assets/drinks/drink3.png',
      price: 3.99,
      catagory: FoodCatagory.drinks,
      availableAddon: [
        Addon(
          name: 'Protein Power',
          price: 0.99,
        ),
        Addon(
          name: 'Almond Milk',
          price: 1.49,
        ),
        Addon(
          name: 'Chia Seeds',
          price: 1.99,
        ),
      ],
    ),
    FoodModel(
      name: 'Mojito',
      description:
          'A classic Cuban with muddled lime and mint, sweetened with sugar.',
      imagePath: 'assets/drinks/drink4.png',
      price: 3.99,
      catagory: FoodCatagory.drinks,
      availableAddon: [
        Addon(
          name: 'Extra Mint',
          price: 0.99,
        ),
        Addon(
          name: 'Raspberry Puree',
          price: 1.49,
        ),
        Addon(
          name: 'Splash of Coconut Rum',
          price: 1.99,
        ),
      ],
    ),
    FoodModel(
      name: 'Caramel Macchiato',
      description:
          'A layered coffee drink with steamed milk, espresso and vanilla syrup.',
      imagePath: 'assets/drinks/drink5.png',
      price: 3.99,
      catagory: FoodCatagory.drinks,
      availableAddon: [
        Addon(
          name: 'EXtra Shot of Espresso',
          price: 0.99,
        ),
        Addon(
          name: 'Hazelnut Syrup',
          price: 1.49,
        ),
        Addon(
          name: 'Whipped Cream',
          price: 1.99,
        ),
      ],
    ),
  ];
  List<FoodModel> get menu => _menu;
}
