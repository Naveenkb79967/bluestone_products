import 'package:bluestone_products/pages/product_list.dart';
import 'package:flutter/material.dart';

void main()=>runApp(MyApp());


class MyApp extends StatelessWidget{
  const MyApp({super. key });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Products',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Color.fromRGBO(33, 33, 33, 1.0)
      ),
     home: ProductListPage(),
    );
  }
}