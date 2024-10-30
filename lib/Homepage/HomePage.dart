import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'CartPage.dart'; // Make sure to import the CartPage

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Mysore Pak',
      'price': 200.0,
      'image':
          'https://img.freepik.com/premium-photo/mysore-pak-is-indian-sweet-prepared-ghee-it-originated-city-mysuru_466689-72351.jpg?semt=ais_hybrid'
    },
    {
      'name': 'Laddu',
      'price': 150.0,
      'image':
          'https://img.freepik.com/premium-photo/indian-sweet-food-laddu-white-background_55610-1682.jpg?semt=ais_siglip'
    },
    {
      'name': 'Jalebi',
      'price': 180.0,
      'image':
          'https://t4.ftcdn.net/jpg/09/63/57/81/240_F_963578170_ul51mC2DpX4w7j7RzntjUQS4bV8WEThg.jpg'
    },
    {
      'name': 'Gaju Katli',
      'price': 250.0,
      'image':
          'https://t4.ftcdn.net/jpg/08/86/12/09/240_F_886120996_jtJXIAeaJnSy9L8VLpLHPbIXeLQmks1r.jpg'
    },
  ];

  final List<String> adImages = [
    'images/Screenshot 2024-09-21 104934.png',
    'images/240_F_174875723_A52cjk579GL36q2zt0q4GABh69mA1WJ2.jpg',
    'images/Screenshot 2024-09-21 104934.png',
  ];

  List<Map<String, dynamic>> cartItems = [];

  void _addToCart(
      String productName, double productPrice, String productImage) {
    setState(() {
      final existingItem =
          cartItems.indexWhere((item) => item['name'] == productName);
      if (existingItem >= 0) {
        cartItems[existingItem]['quantity']++;
      } else {
        cartItems.add({
          'name': productName,
          'price': productPrice,
          'image': productImage,
          'quantity': 1,
        });
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$productName added to cart!'),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ranganathan Sweet Stall'),
        backgroundColor: Colors.deepOrangeAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(cartItems: cartItems),
                ),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Rahith Founder'),
              accountEmail: Text('Rahith Founder@ranganathansweets.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage:
                    AssetImage('images/Screenshot 2024-09-21 104934.png'),
                radius: 40,
              ),
              decoration: BoxDecoration(
                color: Colors.deepOrangeAccent,
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to Settings page if implemented
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                // Handle logout logic if implemented
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        // Wrap the body with SingleChildScrollView
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.yellowAccent.shade700,
              child: Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 150,
                      autoPlay: true,
                      enlargeCenterPage: true,
                    ),
                    items: adImages.map((imagePath) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit.cover,
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Special Offer: Buy 1 kg Sweets and Get 250g Free!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                shrinkWrap: true, // Add this line to allow proper scrolling
                physics:
                    NeverScrollableScrollPhysics(), // Prevents scrolling within the GridView
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(15)),
                            child: Image.network(
                              product['image'],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(child: Text('Image not found'));
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['name'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '₹${product['price']}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () {
                                  _addToCart(product['name'], product['price'],
                                      product['image']);
                                },
                                child: Text('Add to Cart'),
                                style: ElevatedButton.styleFrom(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
