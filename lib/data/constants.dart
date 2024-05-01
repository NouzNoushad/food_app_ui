import 'package:pizza_ui/model/food_category.dart';
import 'package:pizza_ui/model/popular_pizza.dart';

List<FoodCategory> foodCategories = [
  FoodCategory(name: 'Pizza', image: 'farmhouse.png'),
  FoodCategory(name: 'Burger', image: 'burger.png'),
  FoodCategory(name: 'Sweets', image: 'sweets.png'),
  FoodCategory(name: 'Fruits', image: 'apples.png'),
];

List<PopularPizza> popularPizzas = [
  PopularPizza(image: 'mexican_green_wave.png', title: 'Mexican Green Wave', calories: 44, price: 8.34, ingredients: [
    'tomato.png',
    'onion.png',
    'chilli.png',
    'capsicum.png',
  ], rating: 3.8, time: '10-20 min'),
  PopularPizza(
      image: 'veggie_paradise.png',
      title: 'Veggie Paradise',
      calories: 20,
      price: 2.04,
      ingredients: [
        'tomato.png',
        'onion.png',
        'chilli.png',
        'capsicum.png',
        'carrot.png'
      ],
      rating: 4.3,
      time: '10-15 min'),
  PopularPizza(
      image: 'farmhouse.png',
      title: 'Farmhouse',
      calories: 40,
      price: 5.40,
      ingredients: [
        'tomato.png',
        'chilli.png',
        'capsicum.png',
      ],
      rating: 4.0,
      time: '10-30 min'),
];
