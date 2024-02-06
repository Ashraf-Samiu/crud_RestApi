import 'package:crud_restapi/Screen/ProductGridViewScreen.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const CrudApp());
}
class CrudApp extends StatelessWidget{
  const CrudApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductGridViewScreen(),
    );
  }
}