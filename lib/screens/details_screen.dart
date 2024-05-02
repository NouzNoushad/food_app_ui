import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pizza_ui/data/database.dart';
import 'package:pizza_ui/model/popular_pizza.dart';
import 'package:pizza_ui/screens/cart_screen.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.pizza});
  final PopularPizza pizza;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int count = 1;
  MyDatabase myDatabase = MyDatabase();

  @override
  void initState() {
    myDatabase.open();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(248, 248, 248, 1),
      body: Column(
        children: [
          Expanded(
            child: buildDetailsHeader(),
          ),
          Expanded(
            flex: 8,
            child: Column(
              children: [
                Expanded(
                  flex: 8,
                  child: buildPizzaDetails(),
                ),
                Expanded(
                  child: buildAddButton(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAddButton() => Align(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.06,
          width: MediaQuery.of(context).size.width * 0.9,
          child: ElevatedButton(
            onPressed: () async {
              await myDatabase.db!.rawInsert(
                  'INSERT INTO foodCarts(image, title, price, count) VALUES (?, ?, ?, ?)',
                  [
                    widget.pizza.image,
                    widget.pizza.title,
                    (widget.pizza.price * count).toStringAsFixed(2),
                    count
                  ]).then((value) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Colors.white,
                    behavior: SnackBarBehavior.floating,
                    content: Text(
                      'Product added to cart',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        letterSpacing: 1,
                      ),
                    )));
              });
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(46, 120, 85, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                )),
            child: Text(
              'Add to cart'.toUpperCase(),
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.amber,
              ),
            ),
          ),
        ),
      );

  Widget buildPizzaDetails() => Column(
        children: [
          Text(
            widget.pizza.title,
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Image.asset(
                'assets/${widget.pizza.image}',
              ),
            ),
          ),
          Expanded(child: buildInfo()),
        ],
      );

  Widget buildInfo() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: buildPriceDetails(),
            ),
            Expanded(
              child: buildIngredients(),
            ),
            Expanded(
              child: buildDescription(),
            ),
          ],
        ),
      );

  Widget buildDescription() => const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Details',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Pizza is a dish of Italian origin consisting of a usually round, flat base of leavened wheat-based dough topped with tomato, cheese and often various other ingredients, which is then baked at a high temperature',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      );

  Widget buildIngredients() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ingredients',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 10),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color.fromARGB(29, 76, 175, 79),
                      ),
                      child: Image.asset(
                          'assets/${widget.pizza.ingredients[index]}'),
                    ),
                separatorBuilder: (context, index) => const SizedBox(
                      width: 15,
                    ),
                itemCount: widget.pizza.ingredients.length),
          ),
        ],
      );

  Widget buildPriceDetails() => Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.local_fire_department,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${widget.pizza.calories} Calories',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${widget.pizza.rating}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.timer_outlined,
                      color: Colors.purple,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.pizza.time,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '\$${(widget.pizza.price * count).toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 25,
                  color: Color.fromRGBO(46, 120, 85, 1),
                  fontWeight: FontWeight.bold,
                ),
              ),
              buildCounter(),
            ],
          ))
        ],
      );

  Widget buildCounter() => Container(
        decoration: const ShapeDecoration(
            color: Color.fromRGBO(46, 120, 85, 1), shape: StadiumBorder()),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  if (count > 1) {
                    setState(() {
                      count--;
                    });
                  }
                },
                child: const Icon(
                  Icons.remove,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  '$count',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  if (count < 5) {
                    setState(() {
                      count++;
                    });
                  }
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildDetailsHeader() => Padding(
        padding: const EdgeInsets.fromLTRB(15, 30, 15, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: PhysicalModel(
                elevation: 1.2,
                color: Colors.grey.shade300,
                shape: BoxShape.circle,
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Color.fromRGBO(46, 120, 85, 1),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CartScreen()));
              },
              child: PhysicalModel(
                elevation: 1.2,
                color: Colors.grey.shade300,
                shape: BoxShape.circle,
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.shopping_bag,
                    color: Color.fromRGBO(46, 120, 85, 1),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
