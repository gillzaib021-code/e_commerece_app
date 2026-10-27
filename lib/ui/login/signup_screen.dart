import 'package:e_commerece_app_with_admin_pannel/services/database.dart';
import 'package:e_commerece_app_with_admin_pannel/services/shared_pref.dart';
import 'package:e_commerece_app_with_admin_pannel/ui/login/login_screen.dart';
import 'package:e_commerece_app_with_admin_pannel/ui/pages/bottomnav.dart';
import 'package:e_commerece_app_with_admin_pannel/widgets/support_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

   String? name, email, password;
   
   TextEditingController namectrl=TextEditingController();
   TextEditingController emailctrl=TextEditingController();
   
   TextEditingController passwordctrl=TextEditingController();
    
    final _formkey=GlobalKey<FormState>();

   registration()async{
    if (password!=null && email!=null && password!=null) {
      try {
        UserCredential userCredential= await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email!, password: password!);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text("Register Successfully", style: TextStyle(fontSize: 20),)));
           

           
           String Id= randomAlphaNumeric(10);
          await SharedPrefHelper().saveUserEmail(emailctrl.text);
          await SharedPrefHelper().saveUserId(Id); 
          await SharedPrefHelper().saveUserName(namectrl.text);
          await SharedPrefHelper().saveUserImage("https://png.pngtree.com/png-clipart/20230927/original/pngtree-man-avatar-image-for-profile-png-image_13001882.png");





          
          

          Map<String,dynamic> userInfoMap={
            "Name":namectrl.text,
            "Email":emailctrl.text,
              "Id": Id,
              "image":
              "https://png.pngtree.com/png-clipart/20230927/original/pngtree-man-avatar-image-for-profile-png-image_13001882.png"
          };

             await DatabaseMethods().addUserDetail(userInfoMap, Id);


          Navigator.push(context, MaterialPageRoute(builder: (context)=>Bottomnav()));

      } on FirebaseAuthException catch (e) {
        if (e.code=="weak_password") {
           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text("Your password is weak,select strong password", style: TextStyle(fontSize: 20),)));
        }
        else if(e.code=="email_already_in_use"){
           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text("Email already in use", style: TextStyle(fontSize: 20),)));
        }
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
                  Center(child: Text('Sign Up', style: AppWidgets.semiboldTextFieldStyle(),)),
                
                  Center(child: Text('Please enter the detail below to continue.', style: AppWidgets.lightTextFieldStyle(),)),
                  SizedBox(height: 10,),
                  Text('   Name', style: AppWidgets.semiboldTextFieldStyle(),),
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
                          return "Please enter your name";
                        }
                       
                        return null;
                        
                      },
                      controller: namectrl,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "  Name"
                      ),
                    ),
                  ),
                      
                      
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
                          return "Please enter your Email";
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
                      obscureText: true,
                      validator: (value) {
                        if (value==null || value.isEmpty) {
                          return "Please enter your Password";
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
                  GestureDetector(
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        setState(() {
                          name=namectrl.text;
                          email=emailctrl.text;
                          password=passwordctrl.text;
                        });
                      }
                      registration();
                    },
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width/2,
                        padding: EdgeInsets.all(18),
                        decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(child: Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),)),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? ", style: AppWidgets.lightTextFieldStyle(),),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                        },
                        child: Text("Login", style: TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.w500, decoration: TextDecoration.underline),)),
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