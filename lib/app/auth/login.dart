import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/Crud.dart';
import 'package:flutter_application_1/components/customtextfild.dart';
import 'package:flutter_application_1/components/valid.dart';
import 'package:flutter_application_1/constant/link_api.dart';
import 'package:flutter_application_1/main.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  GlobalKey<FormState> formstate = GlobalKey() ;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool islodding = false ;

  Crud _crud = Crud();


  Login() async {
    if(formstate.currentState!.validate()){
      setState(() {
        islodding = true; 
      });

      var response = await _crud.postRequst(
        linksLOGIN, {
        "email" : email.text,
        "password" : password.text,
      });
        setState(() {
          islodding = false;
        });

      if(response ["status"] == "sucssful"){
        sharedPre.setString("id", response["data"]["id"].toString());
        sharedPre.setString("name", response["data"]["name"]);
        sharedPre.setString("email", response["data"]["email"]);
        Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
      }else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("البريد الالكتروني او كلمة المرور غير صحيحه او الحساب غير موجود"),
            backgroundColor: Colors.redAccent,
          )
        );
      }
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      islodding == true 
      ? Center(child : CircularProgressIndicator())
      :Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [ Color.fromARGB(0, 255, 178, 44), Color(0xFF16222A)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
        padding: EdgeInsets.all(16),
        child: Center(
          child: 
            SingleChildScrollView(
              child: Form(
                key: formstate,
                child: 
              // Center(
                 Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("image/logo.png",height: 250,),
                    const SizedBox(height: 20,),
                    textfildcustom(
                      valid: (val){
                          return validinput(val! ,10,50);
                        },
                      mycontroll: email,
                      icon: Icon(Icons.email),
                      hint: "email",),
                      const SizedBox(height: 5,),
                    textfildcustom(
                      valid: (val){
                          return validinput(val! ,6 ,20);
                        },
                      mycontroll: password,
                      icon: Icon(Icons.lock),
                      hint: "password"),

                      const SizedBox(height: 12,),
              

                     SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orangeAccent[100],
                          padding: const EdgeInsets.symmetric( vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                          )
                        ),
                        onPressed: () async{
                          await Login();
                        }, 
                      child: const Text("تسجيل الدخول",style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),)),
                     ),
                     const SizedBox(height: 10,),
                    // MaterialButton(
                    //   color: Colors.blueAccent,
                    //   textColor: Colors.white,
                    //   padding: EdgeInsets.symmetric(horizontal: 70 , vertical: 10),
                    //   height: 20,
                    //   minWidth: 20,
                    //   onPressed: () async{
                    //     await Login();
                    // },
                    // child: Text("login"),
                    // ),                   
                    TextButton.icon(onPressed: (){
                      Navigator.of(context).pushNamed("sign");
                    }, label: Text("ليس لديك حساب ؟ انشاء حساب",style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, 
                    ),) ,icon: const Icon(Icons.person_add_alt_1,color: Colors.blueAccent,),)
                    
                    
                    
                  ],
                ) ,
              )
              ),
            )
          // ],
        ),
      // ),
    );
  }
}