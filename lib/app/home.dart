
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/Catogry/editcatogry.dart';
import 'package:flutter_application_1/components/cardcustm.dart';
import 'package:flutter_application_1/components/crud.dart';
import 'package:flutter_application_1/constant/link_api.dart';
import 'package:flutter_application_1/db_local.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/model/Catogrymodel.dart';
import 'package:flutter_application_1/provider/Catogry_provide.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_application_1/provider/Catogry_provide.dart';

class home extends StatefulWidget {
  const home({super.key});

  

  @override
  State<home> createState() => _homeState();
  
}

class _homeState extends State<home> {
  Crud _crud = Crud();

  void _update() {
  setState(() {});
}
  


  

  // @override
  // void dispose() {
  //   super.dispose();
  // }






catogry_provide _provide_cat = catogry_provide();


  // @override
  // void initState() {
  //   super.initState();
  //   _provide_cat.getcatogry();
  // }


//    getcatogry() async {
//     try{
//     var response = await _crud.getRequst(link_view_CATOGRY)
//     .timeout(const Duration(seconds: 3));
//     if (response != null) {
//       //  setState(() {
//       //     // _update();
//       //   });
//        await LocalDB.insertCategories(response['catogry']);
//       // print("البيانات تم تحميلها من السيرفر");
//         // _update();
//         return (response['catogry']);  
//     } 
//     else {
//     throw Exception("Invalid response from server");   
//     }
//   }catch(e){
//     setState(() {});
//     final localData = await LocalDB.getCategories();
//     return localData;
//   }
// }


  @override
  Widget build(BuildContext context) {
    // final _provide_cat = Provider.of<catogry_provide>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[200],
        title: Text("Home Page"),centerTitle: true, 
      actions: [
        IconButton(
          onPressed: () {
            sharedPre.clear();
             setState(() {});
            Navigator.of(context).pushNamedAndRemoveUntil("Login", (route) => false);
          },
          icon: Icon(Icons.logout),
        )
      ],),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            
          //// final result = 
          Navigator.of(context).pushNamed("addcatogry");    
        },
        child: Icon(Icons.add),
      ),
      body:
        Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [ Color.fromARGB(255, 219, 167, 90),Color.fromARGB(0, 255, 178, 44),],
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
          )
        ),
        // padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          // child: Column(
          child: 
            // children: [
              FutureBuilder(  
                      // future:  _provide_cat.getcatogry() ,
                      future: _provide_cat.getcatogry(),
                      builder: (BuildContext context, AsyncSnapshot  snapshot) {
                      
                       
                       if(snapshot.hasData){
                        
                        var categories = snapshot.data; //snapshot.data
                        return 
                        ListView.builder(
                          
                          shrinkWrap: true ,
                          physics: NeverScrollableScrollPhysics(), 
                          itemCount: categories.length ,
                          itemBuilder: ( context,  index) {
        
                           
                            var category = categories[index]; //snapshot.data[index];
                            return 
                            cardcustom(  
                              catogrymodel: Catogrymodel.fromJson( 
                                category
                                // Map<String, dynamic>.from(snapshot.data[index]),
                                ),
                            // titles: "${category["name"]}" ,
                            ontDElete: () async{
                             var response = await _crud.postRequst(link_delete_Catogry, {
                                "id": snapshot.data[index]["id"].toString(),
                                "image": snapshot.data[index]["image"].toString(),
                              }).then((response) {
                                if (response["status"] == "sucssful") {
                                 
                                  Navigator.pushNamedAndRemoveUntil(context, "home", (route) => false);
                                } else {
                                  AlertDialog(
                                    title: Text("تنبية"),
                                    content: Text("فشل في حذف الفئة"),
                                  );
                                }
                              });
                            },
                            
                            
                            ontaping: () async{
                               _update();
                               print("===========================================================${snapshot.data[index]["id"]}");
                               final result = await Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => 
                                Editcatogry(
              
                                   catogryid: snapshot.data[index]["id"],
                                   name: snapshot.data[index]["name"],
                                   image: snapshot.data[index]["image"],
                                  //  id: category["id"],
                                  )
              
                                
                              ));  if(result == true)  { _update(); 
                               }
                            },);
                          },
                          
                        );
                       }
                        if (snapshot.connectionState == ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator(backgroundColor: Colors.amberAccent, color: Colors.lightBlue,),);      
                        }
                       if(!snapshot.hasData){
                        return Center(child: Text("لايوجد بيانات"));
                       }
                       
                       
                      //  else if (snapshot.data['status'] == 'Faild'){
                      //     return Center(child: Text("no data"),);}
                       return Center(child: Text("خطا "));
                      }  
                  ),
          //  ],
          // ),
        ),
      ),

      );
    
  }
}