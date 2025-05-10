import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/crud.dart';
import 'package:flutter_application_1/components/customtextfild.dart';
import 'package:flutter_application_1/components/valid.dart';
import 'package:flutter_application_1/constant/link_api.dart';

class sign extends StatefulWidget {
  const sign({super.key});

  @override
  State<sign> createState() => _signState();
}

class _signState extends State<sign> {

  GlobalKey<FormState> formstate = GlobalKey() ;
  Crud _crud = Crud();

  bool islodding = false ;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();


  sign() async{
    if (formstate.currentState!.validate()){
      
    setState(() {
    islodding = true;
    });
    var response = await _crud.postRequst(linksign, {
      "email" : email.text,
      "password" : password.text,
      "name" : name.text,

    });
    
    setState(() {
    islodding = false;
    });
    
    if(response ["status"] == "sucssful"){
      Navigator.of(context).pushNamedAndRemoveUntil("sucss", (route) => false);
    }else {
       ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("فشل في إنشاء الحساب.")));
    }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: islodding ==true 
      ? Center(child : CircularProgressIndicator()) 
      : Container(
        decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF16222A) , Color.fromARGB(0, 255, 178, 44)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              padding:  EdgeInsets.all(16),
          
          child: Center(
            child: SingleChildScrollView(
              child: 
                Form(
                  key: formstate,
                  child: 
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("image/logoleft.png",height: 220,),
                      const SizedBox(height: 20,),
                      textfildcustom(
                        mycontroll: name,
                        icon: Icon(Icons.person),
                        hint: "name",
                        valid: (val){
                          return validinput(val! ,3 ,20);
                        },
                        ),
                        const SizedBox(height: 5,),
                      textfildcustom(
                        valid: (val){
                          return validinput(val! ,10 ,50);
                        },
                        mycontroll: email,
                        icon: Icon(Icons.email),
                        hint: "email",),
                        const SizedBox(height: 5,),
                      textfildcustom(
                        valid: (val){
                          return validinput(val! ,6 ,20);
                        },
                        icon: Icon(Icons.lock),
                        mycontroll: password,
                        hint: "password"),
                      
                        const SizedBox(height: 15),
            
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                       style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              backgroundColor: Colors.orange[200],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: (){
                              sign();
                            },
                             child: Text("تسجيل حساب" ,                              
                             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold ,color: Colors.black54),),
                      ),
                      ),
                       const SizedBox(height: 20,),
                      TextButton.icon(onPressed: (){
                        Navigator.of(context).pushNamed("Login");
                      }, label: Text("لديك حساب؟ تسجيل الدخول",style: TextStyle(
                        fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87, 
                      ),) ,icon: Icon(Icons.login,color: Colors.blueAccent,),) 
                    ],
                  ) ,
                )
              )
            
          ),
        ),
      ),
    );
  }
}