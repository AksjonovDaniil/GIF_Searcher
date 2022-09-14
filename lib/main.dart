import 'package:flutter/material.dart';
import 'package:untitled/gif_page.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Gif Searcher',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      ),
      home: GifPage(),
    );
  }
}