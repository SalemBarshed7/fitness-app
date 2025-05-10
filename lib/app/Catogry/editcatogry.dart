import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/Crud.dart';
import 'package:flutter_application_1/components/customtextfild.dart';
import 'package:flutter_application_1/components/valid.dart';
import 'package:flutter_application_1/constant/link_api.dart';
// import 'package:flutter_application_1/main.dart';
import 'package:image_picker/image_picker.dart';

class Editcatogry extends StatefulWidget {
  final int catogryid;
  final String name;
  final String image;

   const Editcatogry(
     {
      super.key, 
      required this.name,
      required this.catogryid, 
      required this.image, 
      });

  @override
  State<Editcatogry> createState() => _editCatogryState();
}

class _editCatogryState extends State<Editcatogry> {


  void initState() {
    super.initState();

    catogryid = widget.catogryid;
    catogryname.text = widget.name;
    image = widget.image;
  }



  File? myfile ;

  Crud _crud = Crud();
  
  bool islodding = false ;
  final GlobalKey<FormState> formstate = GlobalKey<FormState>();

  final TextEditingController catogryname = TextEditingController();
  late int catogryid ;
  late String image ;

  editcatogr() async{
    if (formstate.currentState!.validate()) {
      
      setState(() {
        islodding = true;
      });
      var response ;
      if (myfile == null){
        response = await _crud.postRequst(link_edit_CATOGRY, {
        "id": catogryid.toString(),
        "name": catogryname.text,//وصلت هنا
        "image": image   ,
        // "images": images.text,
      }); 
      }else{
        response = await _crud.postRequst_image(link_edit_CATOGRY, {
        "id": catogryid.toString(),
        "name": catogryname.text,
        "image": image ,
        // "images": images.text,
      },myfile!);
      }
       
     
      // setState(() {
         islodding = false;
      // });
      if (response["status"] == "sucssful") {
        // setState((){});
        Navigator.of(context).pop(true); 
        
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Error in Edit Catogry"),
          backgroundColor: Colors.red,
        ));
      }
    }
  }


  
  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      appBar: AppBar(
        title: Text("Edit Catogry"),centerTitle: true,backgroundColor: Colors.orange[200],),
      body: 
      islodding == true 
      ?Center(child: CircularProgressIndicator()) 
      :Container(
        decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [ Color.fromARGB(0, 255, 178, 44), Color(0xFF16222A)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              padding: const EdgeInsets.all(16),
        // child: Center(
          child: Form(
            key: formstate,
            child: ListView(
              children: [
                
                const SizedBox(height: 16),
                Card(
                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                   elevation: 4,
                   child: Padding(
                     padding: const EdgeInsets.all(16),
                     child: Column(
                      children: [
                     
                        // CircleAvatar(
                        //       radius: 70,
                        //       backgroundImage: myfile != null
                        //           ? FileImage(myfile!)
                        //           : NetworkImage("$linksimage/${widget.image}") as ImageProvider,
                        //     ),
                        //     IconButton(
                        //       icon: Icon(Icons.edit, color: Colors.white),
                        //       onPressed: _pickImage,
                        //     ),
                        SizedBox(height: 20,),
                        textfildcustom(
                          icon: Icon(Icons.category) ,
                          mycontroll: catogryname,
                          hint: "Catogrm Name",
                          valid: (val){
                            return validinput(val!, 3, 20);
                          },
                        ),
                        SizedBox(height: 16,),
                         MaterialButton(
                           padding: EdgeInsets.symmetric(horizontal: 24,vertical: 12),
                          color: myfile == null ? Colors.blue   : Colors.green,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          child: Text("choose image",style: TextStyle(color: Colors.white),),
                          onPressed: () {             
                            showModalBottomSheet(
                            context: context, 
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16),
                              )
                            ),

                            builder: (context) => Container(
                              height: 200,
                              child: Column(
                              children: [
                                SizedBox(height: 30),
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
                                SizedBox(height: 20),
                                ListTile(
                                  leading: Icon(Icons.camera ,size: 40,color: Colors.deepOrange,),
                                  title: Text("Camera" ,style: TextStyle(fontSize: 20),),
                                  onTap: () async {
                                    XFile? xfile = await ImagePicker().pickImage(source: ImageSource.camera); 
                                  
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
                          child: ElevatedButton.icon(
                            icon: Icon(Icons.check),

                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange[200],
                            padding: const EdgeInsets.symmetric( vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)
                            )
                          ),
                          label: Text("Edit Catogry",style: TextStyle( color: Colors.white, fontSize: 16),),
                          onPressed: () async{
                           await editcatogr();
                          },
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