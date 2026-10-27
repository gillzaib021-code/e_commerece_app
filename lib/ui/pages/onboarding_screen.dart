import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 234, 235, 231),
      body: Container(
        margin: EdgeInsets.only(top: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Image.asset('assets/images/headphone.PNG'),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text("Explore\nThe Best\n Products", style: TextStyle(color: Colors.black, fontSize: 35.0, fontWeight: FontWeight.bold),),
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(right: 20),
                padding: EdgeInsets.all(20.0),
               decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle
               ),
                child:Text(
                  "Next",
                   style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold)) ,
              ),
            ],
          )
          ],
        ),
      ),
    );
  }
}