

// import 'package:e_commerece_app_with_admin_pannel/services/database.dart';
// import 'package:e_commerece_app_with_admin_pannel/services/shared_pref.dart';
// import 'package:e_commerece_app_with_admin_pannel/widgets/support_widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class OrderScreen extends StatefulWidget {
//   const OrderScreen({super.key});

//   @override
//   State<OrderScreen> createState() => _OrderScreenState();
// }

// class _OrderScreenState extends State<OrderScreen> {
//   String? email;
//   Stream? orderStream;

//   // Get current user's email
//   Future<void> getTheSharedPref() async {
//     email = await SharedPrefHelper().getUserEmail();
//   }

//   // Get orders from Firebase
//   Future<void> getOnTheLoad() async {
//     await getTheSharedPref();

//     if (email != null) {
//       orderStream = await DatabaseMethods().getOrders(email!);

//       setState(() {});
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     getOnTheLoad();
//   }

//   // Product Image
//   Widget productImage(String imagePath) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(10),
//       child: Image.asset(
//         imagePath,
//         height: 100,
//         width: 100,
//         fit: BoxFit.cover,
//         errorBuilder: (context, error, stackTrace) {
//           return Container(
//             height: 100,
//             width: 100,
//             color: Colors.grey.shade200,
//             child: const Icon(
//               Icons.image_not_supported,
//               size: 40,
//               color: Colors.grey,
//             ),
//           );
//         },
//       ),
//     );
//   }

//   // All Orders
//   Widget allOrders() {
//     return StreamBuilder(
//       stream: orderStream,
//       builder: (context, AsyncSnapshot snapshot) {
//         // Loading
//         if (!snapshot.hasData) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }

//         // No Orders
//         if (snapshot.data.docs.isEmpty) {
//           return const Center(
//             child: Text(
//               "No Orders Found",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           );
//         }

//         return ListView.builder(
//           padding: EdgeInsets.zero,
//           itemCount: snapshot.data.docs.length,
//           itemBuilder: (context, index) {
//             DocumentSnapshot document = snapshot.data.docs[index];

//             Map<String, dynamic> ds =
//                 document.data() as Map<String, dynamic>;

//             String docId = document.id;

//             // Product image from Firestore
//             String productImagePath =
//                 ds["Product_Image"]?.toString() ?? "";

//             String productName =
//                 ds["Product"]?.toString() ?? "Unknown Product";

//             String price =
//                 ds["Price"]?.toString() ?? "0";

//             return Container(
//               margin: const EdgeInsets.only(bottom: 12),
//               child: Material(
//                 elevation: 3,
//                 borderRadius: BorderRadius.circular(12),
//                 child: Container(
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Row(
//                     children: [

//                       // PRODUCT IMAGE
//                         productImagePath.isNotEmpty
//                           ? productImage(productImagePath)
//                           : Container(
//                               height: 100,
//                               width: 100,
//                               decoration: BoxDecoration(
//                                 color: Colors.grey.shade200,
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               child: const Icon(
//                                 Icons.image_not_supported,
//                                 size: 40,
//                                 color: Colors.grey,
//                               ),
//                             ),

//                       const SizedBox(width: 15),

//                       // PRODUCT DETAILS
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment:
//                               CrossAxisAlignment.start,
//                           children: [

//                             Text(
//                               productName,
//                               style: AppWidgets
//                                   .semiboldTextFieldStyle(),
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                             ),

//                             const SizedBox(height: 10),

//                             Text(
//                               "Rs. $price",
//                               style: const TextStyle(
//                                 color: Color(0xFFFD6F3E),
//                                 fontSize: 22,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),

//                       // DELETE BUTTON
//                       IconButton(
//                         icon: const Icon(
//                           Icons.delete,
//                           color: Colors.red,
//                         ),
//                         onPressed: () {
//                           showDialog(
//                             context: context,
//                             builder: (context) {
//                               return AlertDialog(
//                                 title: const Text(
//                                   "Delete Order",
//                                 ),
//                                 content: const Text(
//                                   "Are you sure you want to delete this order?",
//                                 ),
//                                 actions: [

//                                   // CANCEL
//                                   TextButton(
//                                     onPressed: () {
//                                       Navigator.pop(context);
//                                     },
//                                     child: const Text(
//                                       "Cancel",
//                                     ),
//                                   ),

//                                   // DELETE
//                                   TextButton(
//                                     onPressed: () async {
//                                       await DatabaseMethods()
//                                           .deleteOrder(docId);

//                                       if (context.mounted) {
//                                         Navigator.pop(context);
//                                       }
//                                     },
//                                     child: const Text(
//                                       "Delete",
//                                       style: TextStyle(
//                                         color: Colors.red,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               );
//                             },
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xfff2f2f2),

//       appBar: AppBar(
//         backgroundColor: const Color(0xfff2f2f2),
//         centerTitle: true,
//         elevation: 0,
//         title: Text(
//           "Current Orders",
//           style: AppWidgets.semiboldTextFieldStyle(),
//         ),
//       ),

//       body: Container(
//         margin: const EdgeInsets.symmetric(
//           horizontal: 20,
//         ),
//         child: Column(
//           children: [
//             Expanded(
//               child: allOrders(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:e_commerece_app_with_admin_pannel/services/database.dart';
import 'package:e_commerece_app_with_admin_pannel/services/shared_pref.dart';
import 'package:e_commerece_app_with_admin_pannel/widgets/support_widgets.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  String? email;
  Stream? orderStream;

  // Get current user's email
  Future<void> getTheSharedPref() async {
    email = await SharedPrefHelper().getUserEmail();
  }

  // Get orders from Firebase
  Future<void> getOnTheLoad() async {
    await getTheSharedPref();

    if (email != null) {
      orderStream = await DatabaseMethods().getOrders(email!);

      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getOnTheLoad();
  }

  // Product Image
  Widget productImage(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.asset(
        imagePath,
        height: 100,
        width: 100,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 100,
            width: 100,
            color: Colors.grey.shade200,
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

  // All Orders
  Widget allOrders() {
    return StreamBuilder(
      stream: orderStream,
      builder: (context, AsyncSnapshot snapshot) {
        // Loading
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // No Orders
        if (snapshot.data.docs.isEmpty) {
          return const Center(
            child: Text(
              "No Orders Found",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot document = snapshot.data.docs[index];

            Map<String, dynamic> ds =
                document.data() as Map<String, dynamic>;

            String docId = document.id;

            // Product image
            String productImagePath =
                ds["Product_Image"]?.toString() ?? "";

            // Product name
            String productName =
                ds["Product"]?.toString() ?? "Unknown Product";

            // Product price
            String price =
                ds["Price"]?.toString() ?? "0";

            // Order status
            String status =
                ds["Status"]?.toString() ?? "Pending";

            // Status color
            bool isDelivered =
                status.toLowerCase() == "delivered";

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // PRODUCT IMAGE
                      productImagePath.isNotEmpty
                          ? productImage(productImagePath)
                          : Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius:
                                    BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.image_not_supported,
                                size: 40,
                                color: Colors.grey,
                              ),
                            ),

                      const SizedBox(width: 15),

                      // PRODUCT DETAILS
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [

                            // PRODUCT NAME
                            Text(
                              productName,
                              style: AppWidgets
                                  .semiboldTextFieldStyle(),
                              maxLines: 2,
                              overflow:
                                  TextOverflow.ellipsis,
                            ),

                            const SizedBox(height: 10),

                            // PRICE
                            Text(
                              "Rs. $price",
                              style: const TextStyle(
                                color: Color(0xFFFD6F3E),
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 8),

                            // STATUS
                            Row(
                              children: [
                                const Text(
                                  "Status: ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight:
                                        FontWeight.w600,
                                  ),
                                ),

                                Text(
                                  status,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight:
                                        FontWeight.bold,
                                    color: isDelivered
                                        ? Colors.green
                                        : Colors.orange,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // DELETE BUTTON
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text(
                                  "Delete Order",
                                ),
                                content: const Text(
                                  "Are you sure you want to delete this order?",
                                ),
                                actions: [

                                  // CANCEL
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "Cancel",
                                    ),
                                  ),

                                  // DELETE
                                  TextButton(
                                    onPressed: () async {
                                      await DatabaseMethods()
                                          .deleteOrder(docId);

                                      if (context.mounted) {
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: const Text(
                                      "Delete",
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),

      appBar: AppBar(
        backgroundColor: const Color(0xfff2f2f2),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Current Orders",
          style: AppWidgets.semiboldTextFieldStyle(),
        ),
      ),

      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          children: [
            Expanded(
              child: allOrders(),
            ),
          ],
        ),
      ),
    );
  }
}