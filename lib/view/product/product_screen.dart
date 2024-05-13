import 'package:demo_provider/provider/product_provider.dart';
import 'package:demo_provider/model/product_model.dart';
import 'package:demo_provider/view/product/product_cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<ProductModel> productList = [];

  @override
  void initState() {
    getProductList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Product List', style: TextStyle(color: Colors.white)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: InkWell(
              child: Consumer<ProductProvider>(
                builder: (context, provider, child) => Badge(
                    label: Text(provider.cartList.length.toString()),
                    child: const Icon(Icons.shopping_cart_outlined)
                ),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CartScreen()));
              },
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: productList.length,
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
                    productList[index].image.toString(),
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
                const SizedBox(width: 5),
                Expanded(
                    child: Text(productList[index].title.toString(), style: const TextStyle(fontSize: 18))
                ),
                Consumer<ProductProvider>(
                    builder: (context, provider, child) =>
                    provider.cartList.contains(productList[index]) ? const Icon(Icons.check_circle, color: Colors.green) :
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                        ),
                        onPressed: () {
                          provider.addProduct(productList[index]);
                        },
                        child: const Text("Add", style: TextStyle(fontSize: 14, color: Colors.white))
                    )
                )
              ],
            ),
          );
        },
      ),
    );
  }

  getProductList() {
    productList.add(ProductModel(id: 1, title: 'Android Mobile', image: 'https://purepng.com/public/uploads/large/purepng.com-android-smartphonepersonal-computersmartphonemobile-operating-systemcellular-phoneandroid-1701528391092ypwe7.png'));
    productList.add(ProductModel(id: 2, title: 'Iphone Mobile', image: 'https://e7.pngegg.com/pngimages/450/269/png-clipart-space-gray-iphone-x-showing-ios-and-iphone-4-iphone-8-plus-iphone-5-iphone-x-iphone-apple-gadget-electronics.png'));
    productList.add(ProductModel(id: 3, title: 'Windows Laptop', image: 'https://w7.pngwing.com/pngs/359/563/png-transparent-laptop-intel-atom-2-in-1-pc-lenovo-windows-10-laptop-electronics-gadget-netbook.png'));
    productList.add(ProductModel(id: 4, title: 'Mac Laptop', image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRoazvOj_ZBEwe-QPwseQPX-B-SOqQOH9wngz0lXbPxAw&s'));
    productList.add(ProductModel(id: 5, title: 'Keyboard', image: 'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/36a30296-48ab-4d5a-b8fd-16ee9aeb3427/dfxyqmn-90998eb2-ca26-4b90-8db7-8d2f55ab5ee8.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcLzM2YTMwMjk2LTQ4YWItNGQ1YS1iOGZkLTE2ZWU5YWViMzQyN1wvZGZ4eXFtbi05MDk5OGViMi1jYTI2LTRiOTAtOGRiNy04ZDJmNTVhYjVlZTgucG5nIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.C3QhLQ_mu0_uniXZryY4RCvBIyITeyVt4KHXae85bXM'));
    productList.add(ProductModel(id: 6, title: 'Mouse', image: 'https://w7.pngwing.com/pngs/240/71/png-transparent-computer-mouse-logitech-apple-usb-mouse-pc-mouse-electronics-computer-mouse.png'));
    productList.add(ProductModel(id: 7, title: 'Monitor', image: 'https://i.pinimg.com/originals/78/2d/ef/782defe3901f305f44cd27b90e09b81f.png'));
    productList.add(ProductModel(id: 8, title: 'CPU', image: 'https://w7.pngwing.com/pngs/234/254/png-transparent-computer-case-intel-usb-personal-computer-atx-cpu-cabinet-s-electronics-computer-vga-connector-thumbnail.png'));
    productList.add(ProductModel(id: 9, title: 'RAM', image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6I0AE8aO6MaMoaoAjNPa9uAgLuPaIWiYgozzYz1mFdA&s'));
    productList.add(ProductModel(id: 10, title: 'PenDrive', image: 'https://i.pinimg.com/originals/a0/67/82/a067828c005562830281d53d06c66be7.png'));
    productList.add(ProductModel(id: 11, title: 'Hard Disk', image: 'https://w7.pngwing.com/pngs/306/193/png-transparent-hdd-hard-disk-drive-disk-hard-disk-data-computer-data-storage-data-storage-device-drive-internal.png'));
    Provider.of<ProductProvider>(context, listen: false).cartList.clear();
  }
}
