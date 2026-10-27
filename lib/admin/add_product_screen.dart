
// import 'dart:convert';
// import 'dart:io';

// import 'package:e_commerece_app_with_admin_pannel/services/database.dart';
// import 'package:e_commerece_app_with_admin_pannel/widgets/support_widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:random_string/random_string.dart';

// class AddProductScreen extends StatefulWidget {
//   const AddProductScreen({super.key});

//   @override
//   State<AddProductScreen> createState() => _AddProductScreenState();
// }

// class _AddProductScreenState extends State<AddProductScreen> {

//  TextEditingController namectrl=TextEditingController();
//  TextEditingController pricectrl=TextEditingController();
//  TextEditingController detailctrl=TextEditingController();



//   final ImagePicker _imagePicker=ImagePicker();
//   File? selectedImage;
//   Future getImage()async{
//     final image = await _imagePicker.pickImage(
//       source: ImageSource.gallery,
//       imageQuality: 40,   // compress so it fits under Firestore's 1MB doc limit
//       maxWidth: 600,
//     );
//     if (image == null) return;

//     setState(() {
//       selectedImage = File(image.path);
//     });
//   }


//   uploadeItem()async{
//     if (selectedImage!=null && namectrl.text!="" && value!=null) {
//       try {
//         String addId= randomAlphaNumeric(10);

//         List<int> imageBytes = await selectedImage!.readAsBytes();
//         String base64Image = base64Encode(imageBytes);

//         Map<String, dynamic> addProduct={
//           "Name":namectrl.text,
//           "Image":base64Image,
//           "Price":pricectrl.text,
//           "Detail":detailctrl.text
//         };

//         await DatabaseMethods().addProduct(addProduct, value!).then((value){
//           setState(() {
//             selectedImage=null;
//             namectrl.text="";
//           });

//            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             backgroundColor: Colors.redAccent,
//             content: Text("Your Product has been uploaded successfully", style: TextStyle(fontSize: 20),)));
//         });
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text("Upload failed: $e")));
//       }
//     }
//   }

// String? value;
//   final List<String> categoryitem=[
//     "Watch","Laptop","TV","Headphones"
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Icon(Icons.arrow_back)),
//         title: Text("Add Product", style: AppWidgets.semiboldTextFieldStyle(),),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Container(
//             margin: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                Text("Uploade the product image", style: AppWidgets.lightTextFieldStyle(),),
               
//                SizedBox(height: 20,),
        
        
//                Center(
//                  child: GestureDetector(
//                   onTap: getImage,
//                   child: selectedImage==null
//                     ? Container(
//                         height: 150,
//                         width: 150,
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Colors.black38,
//                             width: 1.5,
//                           ),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Icon(Icons.camera),
//                       )
//                     : ClipRRect(
//                         borderRadius: BorderRadius.circular(10),
//                         child: Image.file(
//                           selectedImage!,
//                           height: 150,
//                           width: 150,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                  ),
//                ),
               
//                SizedBox(height: 20,),
//                Text("Product Name", style: AppWidgets.lightTextFieldStyle(),
//                ),
//                SizedBox(height: 20,),
//                Container(
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                   color: Color(0xFFececf8),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: TextFormField(
//                   controller: namectrl,
//                   decoration: InputDecoration(
//                     border: InputBorder.none,
        
//                   ),
//                 ),
//                ),



//                SizedBox(height: 20,),
//                Text("Product Price", style: AppWidgets.lightTextFieldStyle(),
//                ),
//                SizedBox(height: 20,),
//                Container(
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                   color: Color(0xFFececf8),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: TextFormField(
//                   controller: pricectrl,
//                   decoration: InputDecoration(
//                     border: InputBorder.none,
        
//                   ),
//                 ),
//                ),



//                SizedBox(height: 20,),
//                Text("Product detail", style: AppWidgets.lightTextFieldStyle(),
//                ),
//                SizedBox(height: 20,),
//                Container(
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                   color: Color(0xFFececf8),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: TextFormField(
//                   maxLines: 6,
//                   controller: detailctrl,
//                   decoration: InputDecoration(
//                     border: InputBorder.none,
        
//                   ),
//                 ),
//                ),
        
        



        
//                SizedBox(height: 20,),
//                Text("Product Category"),
//                SizedBox(height: 20,),
//                Container(
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                    color: Color(0xFFececf8),
//                    borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: DropdownButtonHideUnderline(
//                   child: DropdownButton<String>(
//                     isExpanded: true,
//                     items: categoryitem.map((item) {
//                       return DropdownMenuItem<String>(
//                         value: item,
//                         child: Text(
//                           item,
//                           style: AppWidgets.semiboldTextFieldStyle(),
//                         ),
//                       );
                      
//                     }).toList(),
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         value = newValue;
//                       });
//                     },
//                     dropdownColor: Colors.white,
//                     hint: Text("Select Category"),
//                     iconSize: 36,
//                     icon: Icon(Icons.arrow_drop_down, color: Colors.black,),
//                     value: value,
//                   ),
//                 ),
        
                
                
//                ),
        
//                SizedBox(height: 20,),
//                Center(
//                 child: ElevatedButton(onPressed: (){
//                   uploadeItem();
//                 }, child: Text("Add Product", style: TextStyle(fontSize: 30),)))
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }






import 'dart:convert';
import 'dart:io';

import 'package:e_commerece_app_with_admin_pannel/services/database.dart';
import 'package:e_commerece_app_with_admin_pannel/widgets/support_widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {

 TextEditingController namectrl=TextEditingController();
 TextEditingController pricectrl=TextEditingController();
 TextEditingController detailctrl=TextEditingController();



  final ImagePicker _imagePicker=ImagePicker();
  File? selectedImage;
  Future getImage()async{
    final image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,   // compress so it fits under Firestore's 1MB doc limit
      maxWidth: 600,
    );
    if (image == null) return;

    setState(() {
      selectedImage = File(image.path);
    });
  }


  uploadeItem()async{
    if (selectedImage!=null && namectrl.text!="" && value!=null) {
      try {
        List<int> imageBytes = await selectedImage!.readAsBytes();
        String base64Image = base64Encode(imageBytes);

        Map<String, dynamic> addProduct={
          "Name":namectrl.text,
          "Image":base64Image,
          "Price":pricectrl.text,
          "Detail":detailctrl.text,
          "Category":value
        };

        await DatabaseMethods().addProduct(addProduct, value!).then((value){
          setState(() {
            selectedImage=null;
            namectrl.text="";
          });

           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text("Your Product has been uploaded successfully", style: TextStyle(fontSize: 20),)));
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Upload failed: $e")));
      }
    }
  }

String? value;
  final List<String> categoryitem=[
    "Watch","Laptop","TV","Headphones"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back)),
        title: Text("Add Product", style: AppWidgets.semiboldTextFieldStyle(),),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               Text("Uploade the product image", style: AppWidgets.lightTextFieldStyle(),),
               
               SizedBox(height: 20,),
        
        
               Center(
                 child: GestureDetector(
                  onTap: getImage,
                  child: selectedImage==null
                    ? Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black38,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.camera),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          selectedImage!,
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                 ),
               ),
               
               SizedBox(height: 20,),
               Text("Product Name", style: AppWidgets.lightTextFieldStyle(),
               ),
               SizedBox(height: 20,),
               Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: namectrl,
                  decoration: InputDecoration(
                    border: InputBorder.none,
        
                  ),
                ),
               ),



               SizedBox(height: 20,),
               Text("Product Price", style: AppWidgets.lightTextFieldStyle(),
               ),
               SizedBox(height: 20,),
               Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: pricectrl,
                  decoration: InputDecoration(
                    border: InputBorder.none,
        
                  ),
                ),
               ),



               SizedBox(height: 20,),
               Text("Product detail", style: AppWidgets.lightTextFieldStyle(),
               ),
               SizedBox(height: 20,),
               Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  maxLines: 6,
                  controller: detailctrl,
                  decoration: InputDecoration(
                    border: InputBorder.none,
        
                  ),
                ),
               ),
        
        



        
               SizedBox(height: 20,),
               Text("Product Category"),
               SizedBox(height: 20,),
               Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                   color: Color(0xFFececf8),
                   borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    items: categoryitem.map((item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: AppWidgets.semiboldTextFieldStyle(),
                        ),
                      );
                      
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        value = newValue;
                      });
                    },
                    dropdownColor: Colors.white,
                    hint: Text("Select Category"),
                    iconSize: 36,
                    icon: Icon(Icons.arrow_drop_down, color: Colors.black,),
                    value: value,
                  ),
                ),
        
                
                
               ),
        
               SizedBox(height: 20,),
               Center(
                child: ElevatedButton(onPressed: (){
                  uploadeItem();
                }, child: Text("Add Product", style: TextStyle(fontSize: 30),)))
              ],
            ),
          ),
        ),
      ),
    );
  }
}