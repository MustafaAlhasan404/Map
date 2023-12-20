// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, library_private_types_in_public_api, avoid_print, depend_on_referenced_packages

import 'package:EvilBank/login.dart';
import 'package:flutter/material.dart';
import 'package:awesome_card/awesome_card.dart';
import 'bottom_navigation_bar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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

  Future<void> fetchCreditCardInfo() async {
    final String url =
        'http://10.0.2.2:3000/getCreditCardInfo/${widget.username}';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Parse the credit card information from the response
        final Map<String, dynamic> creditCardInfo = jsonDecode(response.body);

        // Update the state with the fetched credit card information
        setState(() {
          cardNumber = creditCardInfo['cardNumber'];
          cvv = creditCardInfo['cvv'];
          expiryDate = creditCardInfo['expiryDate'];
        });
      } else {
        // Handle errors
        print(
            'Failed to fetch credit card information. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or server errors
      print('Error fetching credit card information: $error');
    }
  }

  late FocusNode _cvvFocusNode;
  bool _showBackSide = false;

  @override
  void initState() {
    super.initState();
    _cvvFocusNode = FocusNode();

    // Fetch credit card information when the screen is initialized
    fetchCreditCardInfo();
  }

  @override
  void dispose() {
    _cvvFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
