import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pizza_ui/data/database.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  MyDatabase myDatabase = MyDatabase();
  List<Map> cartItems = [];

  @override
  void initState() {
    myDatabase.open();
    getCartItems();
    super.initState();
  }

  getCartItems() {
    Future.delayed(const Duration(seconds: 1), () async {
      cartItems = await myDatabase.db!.rawQuery('SELECT * FROM foodCarts');
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(248, 248, 248, 1),
      body: Column(
        children: [
          Expanded(child: buildCartHeader()),
          Expanded(flex: 8, child: buildCartContents()),
        ],
      ),
    );
  }

  Widget buildCartContents() => Column(
        children: [
          Expanded(
            flex: 2,
            child: buildCartItems(),
          ),
          Expanded(
            child: buildCartTotal(),
          ),
        ],
      );

  Widget buildCartTotal() {
    num total = cartItems.fold(0, (prev, cart) => prev + cart['price']);
    String fixedTotal = total.toStringAsFixed(2);
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'SubTotal',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          fixedTotal,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Delivery',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Free',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '\$$fixedTotal',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.06,
          width: MediaQuery.of(context).size.width * 0.9,
          margin: const EdgeInsets.symmetric(vertical: 15),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(46, 120, 85, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                )),
            child: Text(
              'Confirm order'.toUpperCase(),
              style: const TextStyle(
                fontSize: 16,
                letterSpacing: 1.2,
                fontWeight: FontWeight.w500,
                color: Colors.amber,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCartItems() => ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final cart = cartItems[index];
          return Container(
            height: MediaQuery.of(context).size.height * 0.15,
            color: Colors.transparent,
            child: Stack(
              children: [
                Center(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.12,
                      width: MediaQuery.of(context).size.width * 0.75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              color: Colors.transparent,
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: buildItemDetails(cart),
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.transparent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    'assets/${cart['image']}',
                    width: MediaQuery.of(context).size.width * 0.3,
                  ),
                ),
                buildCartDeleteButton(cart),
              ],
            ),
          );
        },
        itemCount: cartItems.length,
      );

  Widget buildCartDeleteButton(Map<dynamic, dynamic> cart) => Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: () async {
            await myDatabase.db!.rawDelete('DELETE FROM foodCarts WHERE id = ?',
                [cart['id']]).then((value) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  backgroundColor: Colors.white,
                  behavior: SnackBarBehavior.floating,
                  content: Text(
                    'Product remove from cart',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      letterSpacing: 1,
                    ),
                  )));
            });

            getCartItems();
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.04,
            width: MediaQuery.of(context).size.width * 0.2,
            decoration: const ShapeDecoration(
                color: Color.fromRGBO(46, 120, 85, 1), shape: StadiumBorder()),
            child: const Center(
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );

  Widget buildItemDetails(Map<dynamic, dynamic> cart) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            cart['title'],
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Hot ${cart['title']}',
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            '\$${cart['price']}',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );

  Widget buildCartHeader() => Padding(
        padding: const EdgeInsets.fromLTRB(15, 30, 15, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back_ios)),
            const Text(
              'Cart',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
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
      );
}
