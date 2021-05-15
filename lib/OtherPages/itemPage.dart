import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Classes/Cart.dart';
import '../Classes/DatabaseHelper.dart';
import './CartPage.dart';

// ignore: must_be_immutable
class Item extends StatefulWidget {
  List itemCategory;
  String name;
  Item(this.itemCategory, this.name);
  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  final dbHelper = DatabaseHelper.instance;
  Cart item;
  int newQty, length = 0;

  getCartLength() async {
    int x = await dbHelper.queryRowCount();
    length = x;
    setState(() {
      print('Length Updated: $length');
    });
  }

  @override
  void initState() {
    super.initState();
    getCartLength();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    double pWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
        ],
      ),
      body: widget.itemCategory.length == 0
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
            itemCount:widget.itemCategory.length,
            itemBuilder: (_, index){
              _query(widget.itemCategory[index].name);
                return itemsUI(
                  widget.itemCategory[index].name,
                  widget.itemCategory[index].imageUrl,
                  widget.itemCategory[index].merchant,
                  widget.itemCategory[index].price,
                  widget.itemCategory[index].quantity,
                );
            }
          ),
          // GridView.builder(
          //     itemCount: widget.itemCategory.length,
          //     scrollDirection: Axis.vertical,
          //     itemBuilder: (_, index) {
          //       _query(widget.itemCategory[index].name);
          //       return itemsUI(
          //         widget.itemCategory[index].name,
          //         widget.itemCategory[index].imageUrl,
          //         widget.itemCategory[index].merchant,
          //         widget.itemCategory[index].price,
          //         widget.itemCategory[index].quantity,
          //       );
          //       // return ui(
          //       //   widget.itemCategory[index].name,
          //       //   widget.itemCategory[index].imageUrl,
          //       //   widget.itemCategory[index].price,
          //       // );
          //     },
          //     gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          //         crossAxisCount: 2, mainAxisSpacing: 10.0),
          //   ),
    );
  }

  Card itemsUI(name, imageUrl, merchant, price, quantity) {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            ListTile(
              leading: Image.asset(
                'images/vegetable.png',
                width: 50,
                height: 50,
              ),
              title: Text(
                name,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                merchant,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              trailing: Container(
                child: Text(
                  "RS $price",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            item == null
                ? InkWell(
                    onTap: () {
                      _query(name);
                      addToCart(
                          name: name,
                          imgUrl: imageUrl,
                          price: price.toString(),
                          qty: 1);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF900c3f),
                        borderRadius: BorderRadius.circular(33),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Container(
                          child: Text(
                            'Add to cart',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                if (item.qty == 1) {
                                  removeItem(item.productName);
                                } else {
                                  newQty = item.qty - 1;
                                  updateItem(
                                      id: item.id,
                                      name: item.productName,
                                      imgUrl: item.imgUrl,
                                      price: item.price,
                                      qty: newQty);
                                }
                              },
                              child: Icon(
                                Icons.indeterminate_check_box,
                                color: Color(0xFF900c3f),
                                size: MediaQuery.of(context).size.width * 0.07,
                              ),
                            ),
                            Container(
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  item.qty.toString(),
                                  style: TextStyle(
                                      fontFamily: 'sf_pro',
                                      color: Colors.black,
                                      fontSize: 17),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                newQty = item.qty + 1;
                                updateItem(
                                    id: item.id,
                                    name: item.productName,
                                    imgUrl: item.imgUrl,
                                    price: item.price,
                                    qty: newQty);
                              },
                              child: Icon(
                                Icons.add_box,
                                color: Color(0xFF900c3f),
                                size: MediaQuery.of(context).size.width * 0.07,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                removeItem(item.productName);
                              },
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                                size: MediaQuery.of(context).size.width * 0.07,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget ui(name, imageUrl, price) => Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Container(
            child: Column(
              children: [
                // Image.network(
                //   price,
                //   height: 75,
                //   width: 75,
                // ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    "RS $price",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Container(
                  child: Text(
                    name,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                item == null
                    ? InkWell(
                        onTap: () {
                          _query(name);
                          addToCart(
                              name: name,
                              imgUrl: imageUrl,
                              price: price.toString(),
                              qty: 1);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF900c3f),
                            borderRadius: BorderRadius.circular(33),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Container(
                              child: Text(
                                'Add to cart',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(18, 0, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    if (item.qty == 1) {
                                      removeItem(item.productName);
                                    } else {
                                      newQty = item.qty - 1;
                                      updateItem(
                                          id: item.id,
                                          name: item.productName,
                                          imgUrl: item.imgUrl,
                                          price: item.price,
                                          qty: newQty);
                                    }
                                  },
                                  child: Icon(
                                    Icons.indeterminate_check_box,
                                    color: Color(0xFF900c3f),
                                    size: MediaQuery.of(context).size.width *
                                        0.07,
                                  ),
                                ),
                                Container(
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      item.qty.toString(),
                                      style: TextStyle(
                                          fontFamily: 'sf_pro',
                                          color: Colors.black,
                                          fontSize: 17),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    newQty = item.qty + 1;
                                    updateItem(
                                        id: item.id,
                                        name: item.productName,
                                        imgUrl: item.imgUrl,
                                        price: item.price,
                                        qty: newQty);
                                  },
                                  child: Icon(
                                    Icons.add_box,
                                    color: Color(0xFF900c3f),
                                    size: MediaQuery.of(context).size.width *
                                        0.07,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    removeItem(item.productName);
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: MediaQuery.of(context).size.width *
                                        0.07,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
              ],
            ),
          ),
        ),
      );

  void addToCart({String name, String imgUrl, String price, int qty}) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnProductName: name,
      DatabaseHelper.columnImageUrl: imgUrl,
      DatabaseHelper.columnPrice: price,
      DatabaseHelper.columnQuantity: qty
    };
    Cart item = Cart.fromMap(row);
    // ignore: unused_local_variable
    final id = await dbHelper.insert(item);
    Fluttertoast.showToast(
        msg: 'Added to cart', toastLength: Toast.LENGTH_SHORT);
    getCartLength();
  }

  void _query(String name) async {
    final allRows = await dbHelper.queryRows(name);
    allRows.forEach((row) => item = Cart.fromMap(row));
    setState(() {
      // item;
      print('Updated');
    });
  }

  void updateItem(
      {int id,
      String name,
      String imgUrl,
      String merchant,
      String price,
      int qty}) async {
    // row to update
    Cart item = Cart(id, name, imgUrl, merchant, price, qty);
    // ignore: unused_local_variable
    final rowsAffected = await dbHelper.update(item);
    _query(name);
    Fluttertoast.showToast(msg: 'Updated', toastLength: Toast.LENGTH_SHORT);
    setState(() {
      _query(item.productName);
      print('Updated');
      // item;
    });
    getCartLength();
  }

  void removeItem(String name) async {
    // Assuming that the number of rows is the id for the last row.
    // ignore: unused_local_variable
    final rowsDeleted = await dbHelper.delete(name);
    _query(name);
    setState(() {
      print('Updated');
      // item;
    });
    getCartLength();
  }
}
