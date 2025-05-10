import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/components/Crud.dart';
import 'package:flutter_application_1/constant/link_api.dart';
import 'package:flutter_application_1/db_local.dart';

class catogry_provide extends ChangeNotifier{
Crud _crud = Crud();



bool _lodding = false;
bool get islodding => _lodding;


  getcatogry() async{
    
 try{
    _lodding = true;
    var response = await _crud.getRequst(link_view_CATOGRY)
    .timeout(Duration(seconds: 5));
    if (response != null ) {
      //  notifyListeners();
       await LocalDB.insertCategories(response['catogry']);
      print("✅ البيانات تم تحميلها من السيرفر");
      // notifyListeners();
        return (response['catogry']);
        
     
    }else {
      print("⚠️ استجابة السيرفر غير صالحة، سيتم تحميل البيانات من SQLite");
    throw Exception("Invalid response from server");
    }
  }catch(e){
    // notifyListeners();
    // print("fail connect whith server$e");
    final localData = await LocalDB.getCategories();
    // print("📦 تم تحميل البيانات من SQLite: ${localData.length} عنصر");
    return localData;
    
    

  }

  }


}