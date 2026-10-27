import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerece_app_with_admin_pannel/admin/home_admin.dart';
import 'package:e_commerece_app_with_admin_pannel/widgets/support_widgets.dart';
import 'package:flutter/material.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController usernamectrl = TextEditingController();
  TextEditingController userpasswordctrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("assets/images/login.png"),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    'Admin Pannel',
                    style: AppWidgets.semiboldTextFieldStyle(),
                  ),
                ),

                SizedBox(height: 10),
                Text('   Username', style: AppWidgets.semiboldTextFieldStyle()),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: Color(0xFFF4F5F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: usernamectrl,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "  Username",
                    ),
                  ),
                ),

                SizedBox(height: 10),
                Text('   Password', style: AppWidgets.semiboldTextFieldStyle()),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: Color(0xFFF4F5F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    obscureText: true,
                    controller: userpasswordctrl,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "  Password",
                    ),
                  ),
                ),

                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {},
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      padding: EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  loginAdmin() {
    FirebaseFirestore.instance.collection("Admin").get().then((snapshot) {
      snapshot.docs.forEach((result) {
        if (result.data()["username"] != usernamectrl.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text(
                "Your Id is not correct",
                style: TextStyle(fontSize: 20),
              ),
            ),
          );
        } else if (result.data()["userpassoword"] !=
            userpasswordctrl.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text(
                "Your password is incorrect",
                style: TextStyle(fontSize: 20),
              ),
            ),
          );
        }
        else{
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeAdmin()));
        }
      });
    });
  }
}
