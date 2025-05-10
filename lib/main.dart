// import 'dart:convert';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/Catogry/addcatogry.dart';
// import 'package:flutter_application_1/app/auth/Catogry/editcatogry.dart';
import 'package:flutter_application_1/app/auth/Sucss.dart';
import 'package:flutter_application_1/app/auth/login.dart';
import 'package:flutter_application_1/app/auth/sign.dart';
import 'package:flutter_application_1/app/home.dart';
import 'package:flutter_application_1/provider/Catogry_provide.dart';
import 'package:http/http.dart' as http ;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';


late SharedPreferences sharedPre;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPre = await SharedPreferences.getInstance();
  
  runApp( myapp());
//     MultiProvider(
//       providers: [
//     ChangeNotifierProvider(create: (context) => catogry_provide())
//     ]
//     ,child:  myapp(),
//     ),
//   );
}

class myapp extends StatefulWidget {
  const myapp({super.key});

  @override
  State<myapp> createState() => _myappState();
}

class _myappState extends State<myapp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: "welcome",
      
      initialRoute: sharedPre.getString("id") == null ?'Login' : 'home',
      //  initialRoute: (context : "Login") ;
      routes: {
        "Login" : (context) => Login(),
        "sign" : (context) => sign(), 
        "sucss" : (context) => sucss(), 
        "home" : (context) => home(), 
        "addcatogry" : (context) => AddCatogry(), 
      },
    );
  }
}










Future<void> deepSeekQuery(String query) async {
  const apiKey = 'sk-44f54d8979724b309e30e93bc68fa2d1'; 
  // أو قم بتحميله من secure storage أو من config ثابت في بيئة الاختبار

  final response = await http.post(
    Uri.parse('https://chat.deepseek.com/'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    },
    body: jsonEncode({
      'query': query,
      // حسب مستندات DeepSeek يمكنك إضافة حقول أخرى مثل: filters, limit, إلخ.
    }),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print('نتيجة البحث: $data');
  } else {
    throw Exception(
      'خطأ (${response.statusCode}): ${response.body}'
    );
  }
}
