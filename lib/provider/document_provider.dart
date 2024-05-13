import 'package:demo_provider/service/api.dart';
import 'package:demo_provider/service/api_service.dart';
import 'package:flutter/cupertino.dart';

class DocumentProvider with ChangeNotifier {
  ApiService service = ApiService();

  bool _loading = false;
  bool get loading => _loading;

  List<String> _documentList = [];
  List<String> get documentList => _documentList;

  List<bool> _checkList = [];
  List<bool> get checkList => _checkList;


  Future<void> fetchDocumentList() async {
    _loading = true;
    var response = await service.getApiResponse(API.documentApi);
    _loading = false;
    if(response.statusCode == 200) {
      _documentList = response.data.cast<String>();
      _checkList = List<bool>.filled(_documentList.length, false);
    } else {
      print('Something went wrong');
    }
    notifyListeners();
  }

  List<String> _selectedDocumentList = [];
  List<String> get selectedDocumentList => _selectedDocumentList;

  toggleCheckDocument(int index) {
    _checkList[index] = !_checkList[index];
    if(_checkList[index]) {
      _selectedDocumentList.add(_documentList[index]);
    } else {
      _selectedDocumentList.remove(_documentList[index]);
    }
    notifyListeners();
  }

  removeDocument(doc) {
    _selectedDocumentList.remove(doc);
    notifyListeners();
    for(int i=0; i<_documentList.length; i++) {
      if(_documentList[i].contains(doc)) {
        _checkList[i] = false;
        break;
      }
    }
    notifyListeners();
  }

}