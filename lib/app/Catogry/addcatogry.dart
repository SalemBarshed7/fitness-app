import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/Crud.dart';
import 'package:flutter_application_1/components/customtextfild.dart';
import 'package:flutter_application_1/components/valid.dart';
import 'package:flutter_application_1/constant/link_api.dart';
import 'package:image_picker/image_picker.dart';

class AddCatogry extends StatefulWidget {
  const AddCatogry({super.key});

  @override
  State<AddCatogry> createState() => _AddCatogryState();
}

class _AddCatogryState extends State<AddCatogry> {

  File? myfile ;

  Crud _crud = Crud();
  
  bool islodding = false ;
  final GlobalKey<FormState> formstate = GlobalKey<FormState>();
  final TextEditingController catogryname = TextEditingController();
  // final TextEditingController images = TextEditingController();

  addcatogr() async{
    if (myfile == null)  {
    return showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text("Warning"),
        content: Text("يجب اختيار صورة"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            }, 
            child: Text("ok"),
          ),
        ],
      ),);
    }
    if (formstate.currentState!.validate()) {
      setState(() {
        islodding = true;
      });
      
      var response = await _crud.postRequst_image(
        link_add_CATOGRY,
         {
        "name": catogryname.text,
      },myfile! );
      // setState(() {
        islodding = false;
      // });
      if (response["status"] == "sucssful") {
        
        Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
        
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("فشل في اضافة الفئة"),
            backgroundColor: Colors.redAccent,
          )
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      appBar: AppBar(
        title: Text("Add Catogry"),),
      body: 
      islodding == true 
      ?Center(child: CircularProgressIndicator()) 
      :Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color.fromARGB(0, 255, 178, 44), Color(0xFF16222A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          )
        ),
        padding: EdgeInsets.all(16),
        child: 
          Form(
            key: formstate,
            child: ListView(
              children: [
                const SizedBox(height: 16,),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        textfildcustom(
                          icon: Icon(Icons.category) ,
                          mycontroll: catogryname,
                          hint: "Catogrm Name",
                          valid: (val){
                            return validinput(val!, 3, 20);
                          },
                            
                        ),
                        const SizedBox(height: 16,),
                         MaterialButton(
                           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          color: myfile ==null ? Colors.blue   :Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text("Choose Image",style: TextStyle(color: Colors.white),),
                          onPressed: () {
                            showModalBottomSheet(
                            context: context, 
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                            ),
                            builder: (context) => Container(
                              height: 200,
                              child: Column(
                              children: [
                                SizedBox(height: 15),
                                 ListTile(
                                  leading: Icon(Icons.image,size: 40,color: Colors.teal, ),
                                  title: Text("Gallery" ,style: TextStyle(fontSize: 20),),
                                  onTap: () async {
                            
                                     XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery); 
                                     setState(() {});                                                            
                                     Navigator.of(context).pop();
                            
                                    myfile = File(xfile!.path);
                                    
                                    // Navigator.pop(context);
                                  },
                                ),
                                SizedBox(height: 15),
                                ListTile(
                                  leading: Icon(Icons.camera_alt ,size: 40,color: Colors.deepOrange,),
                                  title: Text("Camera" ,style: TextStyle(fontSize: 20),),
                                  onTap: () async {
                                    XFile? xfile = await ImagePicker().pickImage(source: ImageSource.camera); 
                                    setState(() {});
                                    Navigator.of(context).pop();
                                    myfile = File(xfile!.path);
                                    
                                  },
                                ),
                               
                              ],
                            ),
                            )
                         );
                          },
                        ),
                       
                        SizedBox(height: 24,),
                        SizedBox(
                          width: double.infinity,
                          child:ElevatedButton.icon(
                            onPressed: ()async{ 
                             await addcatogr();
                          }, 
                          icon: Icon(Icons.add ,size: 25,),
                          label: Text("Add Catogry" , style: TextStyle(fontSize:16)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orangeAccent[100],
                            padding: const EdgeInsets.symmetric( vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)
                            )
                          )
                          
                          
                        ) 
                       )
                      ],
                    ),
                  ),
          
                )
              ],
            ),
          ),
        ),
      // ),
    );
  }
}