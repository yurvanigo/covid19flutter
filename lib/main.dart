import 'dart:convert';
import 'package:covid19tracer/app/services/api.dart';
import 'package:covid19tracer/app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:covid19tracer/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
     
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(),
       debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    
 
var screens = [
    HomeScreen(),
    
  ]; //screens for each tab

  int selectedTab = 0;
  


  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      backgroundColor: Color.fromRGBO(192, 192, 192, 192),
      
      

       bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home")
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.credit_card),
              title: Text("News")
          ),
        ],
        onTap: (index){
          setState(() {
            selectedTab = index;
          });
        },
        showUnselectedLabels: true,
        iconSize: 25,
   
      ),
     floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: screens[selectedTab],
      

      // This trailing comma makes auto-formatting nicer for build methods.
    );
    
  }
}
