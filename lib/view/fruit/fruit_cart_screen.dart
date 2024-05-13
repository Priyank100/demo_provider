import 'package:demo_provider/provider/fruit_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FruitCartScreen extends StatefulWidget {
  const FruitCartScreen({super.key});

  @override
  State<FruitCartScreen> createState() => _FruitCartScreenState();
}

class _FruitCartScreenState extends State<FruitCartScreen> {
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
      body: Consumer<FruitProvider>(
        builder: (context, provider, child) {
          return provider.cartList.isEmpty ? const Center(child: Text('Empty Cart')) : ListView.separated(
              itemCount: provider.cartList.length,
              shrinkWrap: true,
              separatorBuilder: (context, i) { return Divider(); },
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
                      Column(
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: (){
                                  if(int.parse(provider.cartList[index].qty.toString()) == 1) {
                                    provider.removeProduct(provider.cartList[index]);
                                  } else {
                                    provider.decreaseQuantity(provider.cartList[index]);
                                  }
                                },
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    color: Colors.red.shade300
                                  ),
                                  child: Text('-', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                                ),
                              ),
                              Container(
                                width: 35,
                                height: 25,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)
                                ),
                                child: Text('${provider.cartList[index].qty}'),
                              ),
                              InkWell(
                                onTap: (){
                                  provider.increaseQuantity(provider.cartList[index]);
                                },
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      color: Colors.green.shade300
                                  ),
                                  child: Text('+', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                                ),
                              )
                            ],
                          ),
                          Text('Price: ₹${double.parse(provider.cartList[index].qty.toString()) * double.parse(provider.cartList[index].price.toString().split('₹')[1].toString())}', style: const TextStyle(fontSize: 14))
                        ],
                      ),
                      SizedBox(width: 20),
                      IconButton(
                          onPressed: (){
                            provider.removeProduct(provider.cartList[index]);
                          },
                          icon: const Icon(Icons.delete_forever, color: Colors.red)
                      )
                    ],
                  ),
                );
              },
            );
          },
        ),
      bottomNavigationBar: Consumer<FruitProvider>(
          builder: (context, provider, child) {
            return provider.cartList.isEmpty ? SizedBox() : Container(
              height: 100,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Divider(),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        Text('₹${provider.total}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
                      ]
                  ),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: (){},
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      alignment: Alignment.center,
                      color: Theme.of(context).primaryColor,
                      child: Text('Pay', style: TextStyle(color: Colors.white)),
                    ),
                  )
                ],
              ),
            );
          }
      )
    );
  }

}
