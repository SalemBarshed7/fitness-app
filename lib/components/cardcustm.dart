import 'package:flutter/material.dart';
import 'package:flutter_application_1/constant/link_api.dart';
import 'package:flutter_application_1/model/Catogrymodel.dart';

class cardcustom extends StatelessWidget {

  final Catogrymodel catogrymodel;
  final void Function()? ontaping ;
  final void Function()? ontDElete ;
  // final String titles;
  // final String images;
  const cardcustom({super.key, required this.catogrymodel,  required this.ontaping, this.ontDElete});
  

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: ontaping,
    highlightColor: Colors.blueAccent,
    onHover: (value) => ontaping,
    hoverColor: Colors.brown,  
    
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          height: 220,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.25),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
            child: 
          
             Stack(
                children: [
          
                ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  "$linksimage/${catogrymodel.image}",
                  
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child:
                 Container(
                  padding: const EdgeInsets.symmetric(vertical: 8 , horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(16),
                    ),
                  ),
                  child: Text(
                    "${catogrymodel.name}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          
                 )),if (ontDElete != null)
                 Positioned(
                  // top: 20,
                  right: 2,
                  top: 2,
                  child: Container( 
                    decoration: BoxDecoration(
                      color:Colors.white.withOpacity(0.8),
                      shape: BoxShape.circle,
                       ),
                       child: IconButton(onPressed: ontDElete,
                        icon: Icon(Icons.delete_forever)),
                  ))
          
                 
                ],
              ),
            
          ),
        ],
      ),
    );
  }
}