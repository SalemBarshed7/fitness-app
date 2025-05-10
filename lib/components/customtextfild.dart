import 'package:flutter/material.dart';

class textfildcustom extends StatelessWidget {
  final String hint ;
  final Icon icon ;
  final String? Function(String?)? valid;
  final TextEditingController mycontroll;
  const textfildcustom({super.key, required this.hint, required this.mycontroll,  required this.icon, required this.valid});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        validator: valid,
        controller: mycontroll,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 8 ,horizontal: 10),
          hintText: hint,
          prefixIcon:icon ,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: const Color.fromARGB(255, 51, 40, 40),width:1 ),
            borderRadius: BorderRadius.all(Radius.circular(10))
          )
        ),
      ),
    );
  }
}