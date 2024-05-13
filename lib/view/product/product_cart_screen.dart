import 'package:demo_provider/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Cart List', style: TextStyle(color: Colors.white)),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          return provider.cartList.isEmpty ? const Center(child: Text('Empty Cart')) : ListView.builder(
            itemCount: provider.cartList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.network(
                          provider.cartList[index].image.toString(),
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (context, error, st) {
                            return Icon(Icons.image_outlined, color: Colors.grey[300]);
                          }
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                        child: Text(provider.cartList[index].title.toString(), style: const TextStyle(fontSize: 18))
                    ),
                    IconButton(
                        onPressed: (){
                          provider.removeProduct(provider.cartList[index]);
                        },
                        icon: const Icon(Icons.close, color: Colors.red)
                    )
                  ],
                ),
              );
            },
          );
        },
      )
    );
  }
}
