import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import '../Classes/DatabaseHelper.dart';
import '../Classes/ItemsClass.dart';
import '../OtherPages/CartPage.dart';
import '../OtherPages/itemPage.dart';
import './navDrawer.dart';

class MainHome extends StatefulWidget {
  @override
  _MainHomeState createState() => _MainHomeState();
}

final FirebaseAuth mAuth = FirebaseAuth.instance;

class _MainHomeState extends State<MainHome> {
  final List<String> imageList = ['fruits.png', 'market.png', 'vegetable.png'];
  // ignore: non_constant_identifier_names
  final List<Items> Fruits = [];
  // ignore: non_constant_identifier_names
  final List<Items> Vegetables = [];
  // ignore: non_constant_identifier_names
  final List<Items> Dairy = [];
  // ignore: non_constant_identifier_names
  final List<Items> Food = [];
  // ignore: non_constant_identifier_names
  final List<Items> Bakery = [];
  // ignore: non_constant_identifier_names
  final List<Items> Meat = [];
  // ignore: non_constant_identifier_names
  final List<Items> Provisions = [];
  // ignore: non_constant_identifier_names
  final List<Items> Snacks = [];
  // ignore: non_constant_identifier_names
  final List<Items> Garden = [];

//  List<Orders> pastOrders = [];
//  List<Orders> ongoingOrders = [];
//
//  getOrders() async {
//    pastOrders.clear();
//    ongoingOrders.clear();
//    final User user = await mAuth.currentUser();
//    DatabaseReference orderRef =
//        FirebaseDatabase.instance.reference().child('Orders').child(user.uid);
//    orderRef.once().then((DataSnapshot snapshot) async {
//      Map<dynamic, dynamic> values = await snapshot.value;
//      values.forEach((key, values) async {
//        Orders newOrder = Orders();
//        newOrder.orderAmount = values['orderAmount'];
//        print(newOrder.orderAmount);
//        newOrder.itemsName = List<String>.from(values['itemsName']);
//        newOrder.itemsQty = List<int>.from(values['itemsQty']);
//        print(newOrder.itemsQty);
//        print(newOrder.itemsName);
//        if (values['isCompleted'] == false) {
//          print('Ongoing');
//          ongoingOrders.add(newOrder);
//        } else {
//          print('Past');
//          pastOrders.add(newOrder);
//        }
//      });
//    });
//
//    setState(() {
//      print('Orders fetched');
//    });
//
//    print(ongoingOrders.length);
//    print(pastOrders.length);
//  }

  void getItemsRef(List items, String category) {
    getCartLength();
    FirebaseFirestore.instance.collection(category).get().then((snapshot) {
      snapshot.docs.forEach((element) {
        Items c = Items(
          element.data()['Name'],
          element.data()['ImageUrl'],
          element.data()['Merchant'],
          element.data()['Price(per kg)'],
          element.data()['Quantity(in kg)'],
        );
        items.add(c);
      });
      print(items);
      setState(() {
        // length;
        print(items.length);
      });
    });
  }

  final dbHelper = DatabaseHelper.instance;
  int length = 0;

  getCartLength() async {
    int x = await dbHelper.queryRowCount();
    length = x;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getCartLength();
    getItemsRef(Fruits, 'Fruits');
    getItemsRef(Vegetables, 'Vegetables');
    getItemsRef(Snacks, 'Snacks');
    getItemsRef(Food, 'Food');
    getItemsRef(Dairy, 'Dairy');
    getItemsRef(Meat, 'Meat');
    getItemsRef(Provisions, 'Provisions');
    getItemsRef(Garden, 'Garden');
    getItemsRef(Bakery, 'Bakery');
    // getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text(
          'Mangwa Lai',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
              fontFamily: 'sf_pro'),
        ),
        backgroundColor: Color(0xFF900c3f),
        actions: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
              getCartLength();
              setState(() {});
            },
            child: Icon(
              Icons.shopping_cart,
              color: Colors.white,
              size: MediaQuery.of(context).size.height / 30,
            ),
          ),
          if (length >= 0)
            Padding(
              padding: const EdgeInsets.only(left: 0.0, right: 0.0),
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: CircleAvatar(
                  radius: 8.0,
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  child: Text(
                    length.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ),
            ),
//          Padding(
//            padding: const EdgeInsets.all(15.0),
//            child: InkWell(
//              onTap: () {
//                Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                      builder: (context) => OrdersPage(
//                        ongoingOrders: ongoingOrders,
//                        pastOrders: pastOrders,
//                      ),
//                    ));
//              },
//              child: Icon(
//                Icons.shopping_basket,
//                color: Colors.white,
//              ),
//            ),
//          ),
        ],
      ),
      // backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GFCarousel(
                items: imageList.map(
                  (url) {
                    return Card(
                      elevation: 8,
                      margin: EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          child: Image.asset('images/$url',
                              fit: BoxFit.cover, width: 1000.0),
                        ),
                      ),
                    );
                  },
                ).toList(),
                onPageChanged: (index) {
                  setState(() {});
                },
                autoPlay: true,
                enlargeMainPage: true,
                pagination: true,
                passiveIndicator: Colors.black,
                activeIndicator: Colors.white,
                pagerSize: 10,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.52,
                  child: GridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 3,
                    childAspectRatio: 0.7,
                    children: <Widget>[
                      categoryCard('Fruits', 'bananas.png', Fruits),
                      categoryCard('Dairy', 'milk.png', Dairy),
                      categoryCard('Vegetables', 'vegetable1.png', Vegetables),
                      categoryCard('Snacks', 'snacks.png', Snacks),
                      // categoryCard('Provisions', 'flour.png', Provisions),
                      categoryCard('Meat', 'meat.png', Meat),
                      categoryCard('Bakery', 'bread.png', Bakery),
                      // categoryCard('Garden', 'plant.png', Garden),
                      categoryCard('Food', 'cutlery.png', Food),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget categoryCard(name, image, List name1) {
    return InkWell(
      onTap: () {
        getCartLength();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Item(name1, name)),
        );
      },
      child: Card(
        elevation: 4,
        child: Column(
          children: [
            Image.asset('images/$image'),
            SizedBox(
              height: 10,
            ),
            Text(
              name,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
