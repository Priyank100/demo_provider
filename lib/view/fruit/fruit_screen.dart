import 'package:demo_provider/model/fruit_model.dart';
import 'package:demo_provider/provider/fruit_provider.dart';
import 'package:demo_provider/view/fruit/fruit_cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FruitScreen extends StatefulWidget {
  const FruitScreen({super.key});

  @override
  State<FruitScreen> createState() => _FruitScreenState();
}

class _FruitScreenState extends State<FruitScreen> {
  List<FruitModel> fruitList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Fruit List', style: TextStyle(color: Colors.white)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: InkWell(
              child: Consumer<FruitProvider>(
                builder: (context, provider, child) => Badge(
                    label: Text(provider.cartList.length.toString()),
                    child: const Icon(Icons.shopping_cart_outlined)
                ),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const FruitCartScreen()));
              },
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
          future: Provider.of<FruitProvider>(context, listen: false).fetchFruitList(),
          builder: (context, _) {
            return Consumer<FruitProvider>(
              builder: (context, provider, child) {
                return provider.loading
                    ? const Center(child: CircularProgressIndicator())
                    : provider.fruitList.isEmpty ? const Center(child: Text('No Data')) : ListView.builder(
                    itemCount: provider.fruitList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 80,
                              height: 80,
                              child: Image.network(
                                provider.fruitList[index].image.toString(),
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
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(provider.fruitList[index].title.toString(), style: const TextStyle(fontSize: 18)),
                                    Text('Price: ${provider.fruitList[index].price}', style: const TextStyle(fontSize: 15)),
                                  ],
                                )
                            ),
                            Consumer<FruitProvider>(
                                builder: (context, provider, child) =>
                                provider.cartList.contains(provider.fruitList[index]) ? const Icon(Icons.check_circle, color: Colors.green) :
                                ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                                    ),
                                    onPressed: () {
                                      provider.addProduct(provider.fruitList[index]);
                                    },
                                    child: const Text("Add", style: TextStyle(fontSize: 14, color: Colors.white))
                                )
                            )
                          ],
                        ),
                      );
                    }
                );
              },
            );
          },
        ),
      ),
    );
  }
}
