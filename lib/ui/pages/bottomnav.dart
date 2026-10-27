import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:e_commerece_app_with_admin_pannel/ui/pages/home/home_screen.dart';
import 'package:e_commerece_app_with_admin_pannel/ui/pages/order_screen.dart';
import 'package:e_commerece_app_with_admin_pannel/ui/pages/profile_screen.dart';
import 'package:flutter/material.dart';

class Bottomnav extends StatefulWidget {
  const Bottomnav({super.key});

  @override
  State<Bottomnav> createState() => _BottomnavState();
}

class _BottomnavState extends State<Bottomnav> {

  late List<Widget> pages;
  late HomeScreen HomePage;
  late OrderScreen order;
  late ProfileScreen profile;
  int currentTableindex=0;


  @override
  void initState() {
    HomePage=HomeScreen();
    order=OrderScreen();
    profile=ProfileScreen();
    pages=[HomePage, order, profile];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:CurvedNavigationBar(
        height: 65,
        backgroundColor: Color(0xfff2f2f2),
        color: Colors.black,
        animationDuration: Duration(microseconds: 1000),
        onTap: (int index){
          setState(() {
            currentTableindex=index;
          });
        },
        items: [
        Icon(Icons.home, color: Colors.white,),

        Icon(Icons.shopping_bag_outlined, color: Colors.white,),

        Icon(Icons.person, color: Colors.white,),


        
        ]) ,
        body: pages[currentTableindex],
    );
  }
}