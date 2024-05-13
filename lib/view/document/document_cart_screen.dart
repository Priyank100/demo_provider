import 'package:demo_provider/provider/document_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DocumentCartScreen extends StatefulWidget {
  const DocumentCartScreen({super.key});

  @override
  State<DocumentCartScreen> createState() => _DocumentCartScreenState();
}

class _DocumentCartScreenState extends State<DocumentCartScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Selected Document', style: TextStyle(color: Colors.white)),
        ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Consumer<DocumentProvider>(
          builder: (context, provider, child) {
            return provider.selectedDocumentList.isEmpty ? const Center(child: Text('No Selected Document')) : ListView.builder(
              itemCount: provider.selectedDocumentList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${index+1}. ${provider.selectedDocumentList[index]}'),
                    IconButton(
                        onPressed: (){
                          provider.removeDocument(provider.selectedDocumentList[index]);
                        },
                        icon: const Icon(Icons.close)
                    )
                  ],
                );
              },
            );
          },
        )
      ),
    );
  }
}
