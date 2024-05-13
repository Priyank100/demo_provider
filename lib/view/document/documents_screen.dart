import 'package:demo_provider/provider/document_provider.dart';
import 'package:demo_provider/view/document/document_cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({super.key});

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {

  @override
  void initState() {
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
          title: const Text('Documents List', style: TextStyle(color: Colors.white)),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: InkWell(
                child: const Icon(Icons.checklist),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DocumentCartScreen()));
                },
              ),
            )
          ]
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
          future: Provider.of<DocumentProvider>(context, listen: false).fetchDocumentList(),
          builder: (context, _) {
            return Consumer<DocumentProvider>(
              builder: (context, provider, child) {
                return provider.loading
                    ? const Center(child: CircularProgressIndicator())
                    : provider.documentList.isEmpty ? const Center(child: Text('No Data')) : ListView.builder(
                    itemCount: provider.documentList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Checkbox(
                              value: provider.checkList[index],
                              onChanged: (val) {
                                provider.toggleCheckDocument(index);
                              }
                          ),
                          Text(provider.documentList[index])
                        ],
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
