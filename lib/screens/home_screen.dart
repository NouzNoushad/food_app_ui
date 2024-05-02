import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pizza_ui/data/constants.dart';
import 'package:pizza_ui/screens/details_screen.dart';

class PizzaHomeScreen extends StatefulWidget {
  const PizzaHomeScreen({super.key});

  @override
  State<PizzaHomeScreen> createState() => _PizzaHomeScreenState();
}

class _PizzaHomeScreenState extends State<PizzaHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  int selectedTab = 0;

  @override
  void initState() {
    controller = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(248, 248, 248, 1),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: buildHeader(),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.22,
            child: buildTabs(),
          ),
          Expanded(flex: 2, child: buildPopular()),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  Widget buildPopular() => TabBarView(controller: controller, children: [
        buildPopularPizza(),
        const Center(
          child: Text('Burger'),
        ),
        const Center(
          child: Text('Sweets'),
        ),
        const Center(
          child: Text('Fruits'),
        ),
      ]);

  Widget buildPopularPizza() => Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Popular',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'See all',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: buildPopularItems()),
        ],
      );

  Widget buildPopularItems() => ListView.separated(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final pizza = popularPizzas[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DetailsScreen(pizza: pizza)));
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          pizza.title,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${pizza.title} Pizza',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.local_fire_department,
                              color: Colors.amber,
                            ),
                            Text(
                              '${pizza.calories} Calories',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.amber,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '\$${pizza.price}',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )),
                  Image.asset(
                    'assets/${pizza.image}',
                    height: MediaQuery.of(context).size.height,
                  )
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
            height: 2,
          ),
      itemCount: popularPizzas.length);

  Widget buildTabs() => TabBar(
      controller: controller,
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      indicatorColor: Colors.transparent,
      onTap: (index) {
        setState(() {
          selectedTab = index;
        });
      },
      tabs: foodCategories.map((category) {
        final index = foodCategories.indexOf(category);
        return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.18,
          padding: const EdgeInsets.symmetric(vertical: 5),
          decoration: ShapeDecoration(
              color: selectedTab == index
                  ? const Color.fromRGBO(46, 120, 85, 1)
                  : Colors.white,
              shape: StadiumBorder(
                side: selectedTab == index
                    ? BorderSide.none
                    : BorderSide(width: 1, color: Colors.grey.shade200),
              )),
          child: Column(
            children: [
              ClipOval(
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Image.asset('assets/${category.image}'),
                ),
              ),
              Expanded(
                  child: RotatedBox(
                quarterTurns: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    category.name,
                    style: TextStyle(
                      fontSize: 16,
                      color: selectedTab == index ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ))
            ],
          ),
        );
      }).toList());

  Widget buildHeader() => Padding(
        padding: const EdgeInsets.fromLTRB(15, 35, 15, 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hey John',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Let's final quality food",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black38,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color.fromRGBO(255, 210, 88, 1),
                  ),
                  child: Image.asset('assets/profile.png'),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {}, icon: const Icon(Icons.search)),
                          const Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide.none),
                                  hintText: 'Search food..'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.width * 0.12,
                    width: MediaQuery.of(context).size.width * 0.12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color.fromRGBO(46, 120, 85, 1),
                    ),
                    child: const Icon(
                      Icons.sync_alt,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
}
