import 'package:flutter/material.dart';

class sucss extends StatefulWidget {
  const sucss({super.key});

  @override
  State<sucss> createState() => _sucssState();
}

class _sucssState extends State<sucss> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: 
      Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            
                    Image.asset("image/logo.png", height: 220),
                    const SizedBox(height: 30,),
                    Text("تم انشاء الحساب بنجاح", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold ,color: Colors.teal),textAlign: TextAlign.center,),
                    const SizedBox(height: 10,),
                    Text("الان يمكنك تسجيل الدخول لحسابك", style: TextStyle(fontSize: 18 ,color: Colors.black87),textAlign: TextAlign.center,),
                    const SizedBox(height: 40,),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange[200],
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil("Login" ,(route) => false,);
                        },
                        icon: Icon(Icons.login),
                        label: Text(
                          "تسجيل الدخول",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              // color: Colors.black54
                              ),
                        ),
                        
                      ),
                   
                    ),
                  ],
                ),
              )
      
      ),
    );
  }
}