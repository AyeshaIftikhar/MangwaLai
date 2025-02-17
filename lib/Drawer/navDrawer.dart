import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import '../Classes/Orders.dart';
import '../Drawer/PrivacyPolicy.dart';
import '../Drawer/support_page_main.dart';
import '../LoginPages/WelcomeScreen.dart';
import '../OtherPages/OrdersPage.dart';
import '../OtherPages/ProfilePage.dart';

// ignore: must_be_immutable
class NavDrawer extends StatefulWidget {
  List<Orders> pastOrders = [];
  List<Orders> ongoingOrders = [];

  NavDrawer({this.ongoingOrders, this.pastOrders});
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    print('out');
  }

  List<Orders> pastOrders = [];
  List<Orders> ongoingOrders = [];
  FirebaseAuth mAuth = FirebaseAuth.instance;

  getOrders() async {
    pastOrders.clear();
    ongoingOrders.clear();
    // ignore: unused_local_variable
    final User user = mAuth.currentUser;
    // DatabaseReference orderRef =
    //     FirebaseDatabase.instance.reference().child('Orders').child(user.uid);
    // orderRef.once().then((DataSnapshot snapshot) async {
    //   Map<dynamic, dynamic> values = await snapshot.value;
    //   values.forEach((key, values) async {
    //     Orders newOrder = Orders();
    //     newOrder.orderAmount = values['orderAmount'];
    //     print(newOrder.orderAmount);
    //     newOrder.itemsName = List<String>.from(values['itemsName']);
    //     newOrder.itemsQty = List<int>.from(values['itemsQty']);
    //     newOrder.dateTime = values['DateTime'];
    //     print(newOrder.dateTime);
    //     newOrder.completedTime = values['CompletedTime'];
    //     print(newOrder.completedTime);
    //     newOrder.shippedTime = values['ShippedTime'];
    //     newOrder.status = values['Status'];
    //     print(newOrder.status);
    //     print(newOrder.shippedTime);
    //     print(newOrder.itemsQty);
    //     print(newOrder.itemsName);
    //     if (values['isCompleted'] == false) {
    //       print('Ongoing');
    //       ongoingOrders.add(newOrder);
    //     } else {
    //       print('Past');
    //       pastOrders.add(newOrder);
    //     }
    //   });
    // });

    setState(() {
      print('Orders fetched');
    });

    print(ongoingOrders.length);
    print(pastOrders.length);
  }

  @override
  void initState() {
    super.initState();
    getOrders();
    setState(() {
      print('Fetched again');
    });
  }

  @override
  Widget build(BuildContext context) {
    return GFDrawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 50,
            child: Container(
              color: Color(0xFF900c3f),
            ),
          ),
          Container(
            color: Color(0xFF900c3f),
            height: 150,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GFAvatar(
                    size: 65,
                    backgroundColor: Colors.white,
                    child: Text(
                      'ML',
                      style: TextStyle(
                          fontSize: 50,
                          color: Colors.black,
                          fontFamily: 'sf_pro',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Mangwa Lai',
                      style: TextStyle(
                          fontFamily: 'nunito',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Text(
                      'mangwalaiapp@gmail.com',
                      style: TextStyle(
                          fontFamily: 'nunito',
                          fontSize: 12,
                          color: Color(0xFFFFE600)),
                    )
                  ],
                )
              ],
            ),
          ),
          ListTile(
            title: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Text(
                'Shop By Categories',
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'nunito',
                    fontWeight: FontWeight.w600),
              ),
            ),
            onTap: () {
              Navigator.of(context).pop(true);
            },
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 0.5,
            color: Colors.black26,
          ),
          ListTile(
            title: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Text(
                'Your Orders',
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'nunito',
                    fontWeight: FontWeight.w600),
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrdersPage(
                        ongoingOrders: ongoingOrders, pastOrders: pastOrders),
                  ));
            },
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 0.5,
            color: Colors.black26,
          ),
          ListTile(
            title: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Text(
                'Your Account',
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'nunito',
                    fontWeight: FontWeight.w600),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 0.5,
            color: Colors.black26,
          ),
          ListTile(
            title: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Text(
                'Support',
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'nunito',
                    fontWeight: FontWeight.w600),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactUsPage()),
              );
            },
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 0.5,
            color: Colors.black26,
          ),
          ListTile(
            title: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Text(
                'Privacy Policy',
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'nunito',
                    fontWeight: FontWeight.w600),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PrivacyPolicy()),
              );
            },
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 0.5,
            color: Colors.black26,
          ),
          ListTile(
            title: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Text(
                'Log Out',
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'nunito',
                    fontWeight: FontWeight.w600),
              ),
            ),
            onTap: () async {
              await signOut();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WelcomeScreen(),
                  ));
            },
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 0.5,
            color: Colors.black26,
          ),
        ],
      ),
    );
  }
}
