import 'package:e_commerece_app_with_admin_pannel/ui/login/signup_screen.dart';
import 'package:e_commerece_app_with_admin_pannel/ui/pages/bottomnav.dart';
import 'package:e_commerece_app_with_admin_pannel/widgets/support_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  String email="", password="";

  
   TextEditingController emailctrl=TextEditingController();
   
   TextEditingController passwordctrl=TextEditingController();
    
    final _formkey=GlobalKey<FormState>();

    useroLogin()async{
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Bottomnav()));
      }on FirebaseAuthException catch (e) {
        if (e.code=="user_not_found") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text("User Not Found", style: TextStyle(fontSize: 20),)));
        }

        else if(e.code=="Wrong_password"){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text("wrong Password", style: TextStyle(fontSize: 20),)));
        }
      }
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 40),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset("assets/images/login.png"),
                  SizedBox(height: 20,),
                  Center(child: Text('Sign In', style: AppWidgets.semiboldTextFieldStyle(),)),
                
                  Center(child: Text('Please enter the detail below to continue.', style: AppWidgets.lightTextFieldStyle(),)),
                  SizedBox(height: 10,),
                  Text('   Email', style: AppWidgets.semiboldTextFieldStyle(),),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                      color: Color(0xFFF4F5F9),
                       borderRadius: BorderRadius.circular(10)
                    ),
                    child: TextFormField(
                       validator: (value) {
                        if (value==null || value.isEmpty) {
                          return "Please enter your email";
                        }
                       
                        return null;
                        
                      },
                      controller: emailctrl,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "  Email"
                      ),
                    ),
                  ),
                      
                      
                  SizedBox(height: 10,),
                  Text('   Password', style: AppWidgets.semiboldTextFieldStyle(),),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                      color: Color(0xFFF4F5F9),
                       borderRadius: BorderRadius.circular(10)
                    ),
                    child: TextFormField(
                       validator: (value) {
                        if (value==null || value.isEmpty) {
                          return "Please enter your password";
                        }
                       
                        return null;
                        
                      },
                      controller: passwordctrl,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "  Password"
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Forgot Password", style: TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.w500, decoration: TextDecoration.underline),),
                    ],
                  ),
                  SizedBox(height: 15,),
                  GestureDetector(
                    onTap: () {
                       if (_formkey.currentState!.validate()) {
                        setState(() {
                         
                          email=emailctrl.text;
                          password=passwordctrl.text;
                        });
                      }
                      useroLogin();
                    },
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width/2,
                        padding: EdgeInsets.all(18),
                        decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),)),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account? ", style: AppWidgets.lightTextFieldStyle(),),
                      GestureDetector(
                        onTap: () {
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
                        },
                        child: Text("Sign Up", style: TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.w500, decoration: TextDecoration.underline),)),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}