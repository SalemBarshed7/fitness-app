import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';



// String _basicAuth =
//  'Basic ' + 
//  base64Encode(utf8.encode('admin@admin.com:admin12345'));

//  Map<String ,String> myheaders = {
//    "authorization": _basicAuth};



class Crud {


getRequst(String url) async{
    try{
        var response = await http.get(Uri.parse(url) ,
        // headers: myheaders
        );
        if(response.statusCode == 200){
          var respbody = jsonDecode(response.body);
          return respbody;
        } else{
          print("coneecionfaild");
        }
    }catch (e){
      print("catch error $e");
    }
  }





postRequst(String url ,Map data ) async{
  
  try{
        var response = await http.post(Uri.parse(url) , body: data 
        // ,headers: myheaders
        );
        
        if(response.statusCode == 200){
          var respbody = jsonDecode(response.body);
          
          return respbody;
        } else{
          print("coneecionfaild ${response.statusCode}");
        }
  }catch (e){
      print("catch error $e");
 }
}



postRequst_image(String url ,Map data , File file) async {
   var requst         = await http.MultipartRequest("POST", Uri.parse(url));
   
   var lengthfile = await file.length();
   var stream = http.ByteStream(file.openRead()); 

   var multypartimage   = http.MultipartFile("image" , stream ,lengthfile , filename: basename(file.path) );
   
  //  requst.headers.addAll(myheaders);

   requst.files.add(multypartimage);

   data.forEach((key , value) {
     requst.fields[key] = value;
   });

   var myrequst = await requst.send();

   var response = await http.Response.fromStream(myrequst);
   if(myrequst.statusCode == 200 ){
      return jsonDecode(response.body);
   }else {
      print("error ${myrequst.statusCode}");
   }
}









}