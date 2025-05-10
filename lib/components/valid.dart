import 'package:flutter_application_1/constant/massege.dart';

validinput(String val ,int min ,int max){
  if(val.length > max){
    return "$massageOfMAX $max";
  }
  if(val.isEmpty){
    return "$massageOfempty";
  }
  if(val.length < min){
    return "$massageOfMIN $min";
  }
  
   
  
}