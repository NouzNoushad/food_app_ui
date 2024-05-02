import 'package:flutter/material.dart';
import 'package:pizza_ui/screens/cart_screen.dart';
import 'package:pizza_ui/screens/home_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int selectedIndex = 0;

  buildScreens(int index) {
    switch (index) {
      case 0:
        return const PizzaHomeScreen();
      case 1:
        return const Scaffold(
          body: Center(
            child: Text(
              'Location Screen',
              style: TextStyle(fontSize: 20),
            ),
          ),
        );
      case 2:
        return const Scaffold(
          body: Center(
            child: Text(
              '',
              style: TextStyle(fontSize: 20),
            ),
          ),
        );
      case 3:
        return const Scaffold(
          body: Center(
            child: Text(
              'Favorite Screen',
              style: TextStyle(fontSize: 20),
            ),
          ),
        );
      case 4:
        return const Scaffold(
          body: Center(
            child: Text(
              'Notification Screen',
              style: TextStyle(fontSize: 20),
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const CartScreen()));
        },
        backgroundColor: const Color.fromRGBO(255, 210, 88, 1),
        child: const Icon(
          Icons.shopping_bag,
          color: Color.fromRGBO(46, 120, 85, 1),
        ),
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          backgroundColor: Colors.transparent,
          unselectedItemColor: const Color.fromARGB(255, 67, 175, 125),
          selectedItemColor: const Color.fromARGB(255, 0, 63, 35),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0.0,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.location_on), label: ''),
            BottomNavigationBarItem(icon: SizedBox.shrink(), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ''),
          ],
        ),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: size.height,
            child: buildScreens(selectedIndex),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: BottomNavClipper(),
              child: Container(
                height: size.height * 0.12,
                width: size.width,
                color: const Color.fromRGBO(46, 120, 85, 1),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BottomNavClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;
    return Path()
      ..moveTo(0, h)
      ..lineTo(0, 0)
      ..quadraticBezierTo(w * 0.02, h * 0.35, w * 0.15, h * 0.35)
      ..lineTo(w * 0.3, h * 0.35)
      ..quadraticBezierTo(w * 0.38, h * 0.38, w * 0.44, h * 0.66)
      ..quadraticBezierTo(w * 0.5, h * 0.88, w * 0.56, h * 0.66)
      ..quadraticBezierTo(w * 0.62, h * 0.38, w * 0.7, h * 0.35)
      ..lineTo(w * 0.85, h * 0.35)
      ..quadraticBezierTo(w * 0.98, h * 0.35, w, 0)
      ..lineTo(w, h)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
