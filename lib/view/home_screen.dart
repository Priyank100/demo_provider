import 'package:demo_provider/view/fruit/fruit_screen.dart';
import 'package:demo_provider/view/product/product_screen.dart';
import 'package:demo_provider/view/document/documents_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Provider Demo', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          InkWell(
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.symmetric(horizontal: 50,vertical: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(20)
              ),
              child: const Text('Product Cart', style: TextStyle(color: Colors.white)),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductScreen()));
            },
          ),
          InkWell(
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.symmetric(horizontal: 50,vertical: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20)
              ),
              child: const Text('Document Checkbox', style: TextStyle(color: Colors.white)),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const DocumentsScreen()));
            },
          ),
          InkWell(
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.symmetric(horizontal: 50,vertical: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20)
              ),
              child: const Text('Fruit Price Cart', style: TextStyle(color: Colors.white)),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const FruitScreen()));
            },
          ),
        ],
      ),
    );
  }
}
