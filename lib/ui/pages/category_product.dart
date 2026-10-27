
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerece_app_with_admin_pannel/services/database.dart';
import 'package:e_commerece_app_with_admin_pannel/ui/pages/product_detail_screen.dart';
import 'package:e_commerece_app_with_admin_pannel/widgets/support_widgets.dart';
import 'package:flutter/material.dart';

class CategoryProduct extends StatefulWidget {
  final String category;

  const CategoryProduct({
    super.key,
    required this.category,
  });

  @override
  State<CategoryProduct> createState() => _CategoryProductState();
}

class _CategoryProductState extends State<CategoryProduct> {
  Stream<QuerySnapshot>? categoryStream;

  // ================= LOAD PRODUCTS =================

  Future<void> getOnTheLoad() async {
    try {
      final stream = await DatabaseMethods()
          .getProducts(widget.category);

      if (mounted) {
        setState(() {
          categoryStream = stream;
        });
      }
    } catch (e) {
      debugPrint("Category Product Error: $e");

      if (mounted) {
        setState(() {
          categoryStream = null;
        });
      }
    }
  }

  // ================= INIT =================

  @override
  void initState() {
    super.initState();
    getOnTheLoad();
  }

  // ================= PRODUCT IMAGE =================

  Widget productImage(String imageUrl) {
    if (imageUrl.trim().isEmpty) {
      return Container(
        height: 110,
        width: 110,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(
          Icons.image_not_supported,
          size: 40,
          color: Colors.grey,
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        imageUrl,
        height: 110,
        width: 110,
        fit: BoxFit.cover,
        errorBuilder: (
          BuildContext context,
          Object error,
          StackTrace? stackTrace,
        ) {
          return Container(
            height: 110,
            width: 110,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.image_not_supported,
              size: 40,
              color: Colors.grey,
            ),
          );
        },
      ),
    );
  }

  // ================= ALL PRODUCTS =================

  Widget allProduct() {
    if (categoryStream == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return StreamBuilder<QuerySnapshot>(
      stream: categoryStream,
      builder: (
        BuildContext context,
        AsyncSnapshot<QuerySnapshot> snapshot,
      ) {
        // ================= LOADING =================

        if (snapshot.connectionState ==
            ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // ================= ERROR =================

        if (snapshot.hasError) {
          debugPrint(
            "Firestore Category Error: ${snapshot.error}",
          );

          return const Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Unable to load products.\nPlease try again.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                ),
              ),
            ),
          );
        }

        // ================= NO DATA =================

        if (!snapshot.hasData) {
          return const Center(
            child: Text(
              "No Products Found",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        }

        final List<QueryDocumentSnapshot> docs =
            snapshot.data!.docs;

        // ================= EMPTY CATEGORY =================

        if (docs.isEmpty) {
          return Center(
            child: Text(
              "No Products Found in ${widget.category}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        }

        // ================= PRODUCT GRID =================

        return GridView.builder(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 20,
          ),
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.55,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final dynamic rawData = docs[index].data();

            // Safety check
            if (rawData is! Map<String, dynamic>) {
              return const SizedBox();
            }

            final Map<String, dynamic> ds = rawData;

            // ================= SAFE DATA =================

            final String productImageUrl =
                ds["Image"]?.toString() ?? "";

            final String productName =
                ds["Name"]?.toString().trim().isNotEmpty == true
                    ? ds["Name"].toString()
                    : "Unknown Product";

            final String productDetail =
                ds["Detail"]?.toString() ?? "";

            final String productPrice =
                ds["Price"]?.toString() ?? "0";

            // ================= PRODUCT CARD =================

            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [

                  // ================= IMAGE =================

                  const SizedBox(height: 10),

                  productImage(productImageUrl),

                  const SizedBox(height: 8),

                  // ================= NAME =================

                  Text(
                    productName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                        AppWidgets.semiboldTextFieldStyle(),
                  ),

                  const SizedBox(height: 5),

                  // ================= DETAIL =================

                  Expanded(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        productDetail.isEmpty
                            ? "No description available"
                            : productDetail,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style:
                            AppWidgets.lightTextFieldStyle(),
                      ),
                    ),
                  ),

                  // ================= PRICE + ADD =================

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [

                      Expanded(
                        child: Text(
                          "\$$productPrice",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xFFFD6F3E),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(width: 8),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailScreen(
                                image: productImageUrl,
                                name: productName,
                                detail: productDetail,
                                price: productPrice,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding:
                              const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color:
                                const Color(0xFFFD6F3E),
                            borderRadius:
                                BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // ================= BUILD =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),

      // ================= APP BAR =================

      appBar: AppBar(
        backgroundColor: const Color(0xfff2f2f2),
        elevation: 0,
        title: Text(
          widget.category,
          style: AppWidgets.semiboldTextFieldStyle(),
        ),
      ),

      // ================= BODY =================

      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          children: [
            Expanded(
              child: allProduct(),
            ),
          ],
        ),
      ),
    );
  }
}






// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:e_commerece_app_with_admin_pannel/services/database.dart';
// import 'package:e_commerece_app_with_admin_pannel/ui/pages/product_detail_screen.dart';
// import 'package:e_commerece_app_with_admin_pannel/widgets/support_widgets.dart';
// import 'package:flutter/material.dart';

// class CategoryProduct extends StatefulWidget {
//   String category;
//   CategoryProduct({required this.category});

//   @override
//   State<CategoryProduct> createState() => _CategoryProductState();
// }

// class _CategoryProductState extends State<CategoryProduct> {
//    Stream? CategoryStream;

//    getontheload()async{
// CategoryStream=await DatabaseMethods().getProducts(widget.category);

//      setState(() {
       
//      });
//    }

//       @override
//       void initState(){
//       getontheload();
//         super.initState();
//       }  
   


 
//   Widget allProduct() {
//     return StreamBuilder(
//       stream: CategoryStream,
//       builder: (context, AsyncSnapshot snapshot) {
//         return snapshot.hasData
//             ? GridView.builder(
//                 padding: EdgeInsets.zero,
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   childAspectRatio: 0.55,
//                   mainAxisSpacing: 10,
//                   crossAxisSpacing: 10,
//                 ),
//                 itemCount: snapshot.data.docs.length,
//                 itemBuilder: (context, index) {
//                   Map<String, dynamic> ds =
//                       snapshot.data.docs[index].data() as Map<String, dynamic>;
//                   return Container(
                    
//                     padding: EdgeInsets.symmetric(horizontal: 20),
//                     decoration: BoxDecoration(color: Colors.white),
//                     child: Column(
//                       children: [
//                         SizedBox(height: 10,),
//                         Image.network(
//                           ds["Image"],
//                           height: 110,
//                           width: 110,
//                           fit: BoxFit.cover,
//                         ),
//                         Text(
//                           ds["Name"],
//                           style: AppWidgets.semiboldTextFieldStyle(),
//                         ),
//                         SizedBox(height: 5),
//                         Text(
//                           ds["Detail"] ?? "",
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           style: AppWidgets.lightTextFieldStyle(),
//                         ),
//                         SizedBox(height: 10),
//                         // Spacer(),
//                         Row(
//                           children: [
//                             Text(
                             
//                               "\$" + (ds["Price"] ?? "0").toString(),
//                               style: TextStyle(
//                                 color: Color(0xFFFd6F3e),
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             SizedBox(width: 20),
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailScreen(
//                                   image: (ds["Image"] ?? "").toString(),
//                                   name: (ds["Name"] ?? "").toString(),
//                                   detail: (ds["Detail"] ?? "").toString(),
//                                   price: (ds["Price"] ?? "0").toString(),
//                                 )));
//                               },
//                               child: Container(
//                                 padding: EdgeInsets.all(5),
//                                 decoration: BoxDecoration(
//                                   color: Color(0xFFFd6F3e),
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 child: Icon(Icons.add, color: Colors.white),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               )
//             : Container();
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xfff2f2f2),
//       appBar: AppBar(backgroundColor: Color(0xfff2f2f2), title: Text(widget.category),),
//       body: Container(
//         margin: EdgeInsets.only(left: 20, right: 20),
//         child: 
//       Column(
        
//         children: [
//           Expanded(child: allProduct()),
//           ],
//         )),
//     );
//   }
// }