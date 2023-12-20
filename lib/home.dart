// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, library_private_types_in_public_api

import 'package:EvilBank/login.dart';
import 'package:flutter/material.dart';
import 'package:awesome_card/awesome_card.dart';
import 'bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  final String? username;

  const HomeScreen({
    Key? key,
    required this.username, // Define parameter here
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  String cardNumber = '';
  String cardHolderName = loggedInUser!;
  String expiryDate = '';
  String cvv = '';

  late FocusNode _cvvFocusNode;
  bool _showBackSide = false;

  @override
  void initState() {
    super.initState();
    _cvvFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _cvvFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awesome Credit Card Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: Color(0xFF171738),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _showBackSide = !_showBackSide;
                    });
                  },
                  child: CreditCard(
                    cardNumber: cardNumber,
                    cardExpiry: expiryDate,
                    cardHolderName: cardHolderName,
                    cvv: cvv,
                    bankName: 'Evil Bank',
                    showBackSide: _showBackSide,
                    frontBackground: CardBackgrounds.black,
                    backBackground: Container(
                      // Wrap the color in a Container
                      color: Color(0xFF8D86C9),
                    ),
                    showShadow: true,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomNavBar(
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awesome Credit Card Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(
        username: loggedInUser,
      ),
    );
  }
}
