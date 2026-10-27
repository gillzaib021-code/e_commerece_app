// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:e_commerece_app_with_admin_pannel/services/database.dart';
// import 'package:e_commerece_app_with_admin_pannel/widgets/support_widgets.dart';
// import 'package:flutter/material.dart';

// class AllOrdersScreen extends StatefulWidget {
//   const AllOrdersScreen({super.key});

//   @override
//   State<AllOrdersScreen> createState() => _AllOrdersScreenState();
// }

// class _AllOrdersScreenState extends State<AllOrdersScreen> {

//   Stream? orderStram;


//   getontheload()async{
//     orderStram=await DatabaseMethods().allOrders();
//     setState(() {
      
//     });
//   }
//    @override
//   void initState() {
//     super.initState();
//     getontheload();
//   }

   
// Widget allOrders() {
//     return StreamBuilder(
//       stream: orderStram,
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
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [

//                       // PRODUCT IMAGE
//                         productImagePath.isNotEmpty
//                           ? ClipRRect(
//                               borderRadius: BorderRadius.circular(10),
//                               child: Image.network(
//                                 productImagePath,
//                                 height: 100,
//                                 width: 100,
//                                 fit: BoxFit.cover,
//                                 errorBuilder: (context, error, stackTrace) =>
//                                     Container(
//                                   height: 100,
//                                   width: 100,
//                                   color: Colors.grey.shade200,
//                                   child: const Icon(
//                                     Icons.image_not_supported,
//                                     size: 40,
//                                     color: Colors.grey,
//                                   ),
//                                 ),
//                               ),
//                             )
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

//                             // Text(
//                             //   "Rs. $price",
//                             //   style: const TextStyle(
//                             //     color: Color(0xFFFD6F3E),
//                             //     fontSize: 22,
//                             //     fontWeight: FontWeight.bold,
//                             //   ),
//                             // ),
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
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text("All Orders", style: AppWidgets.semiboldTextFieldStyle(),),
//       ),
//       body: Container(
//         margin: EdgeInsets.only( left: 20, right: 20),
//         child: Column(
//           children: [
//             Expanded(child: allOrders()),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerece_app_with_admin_pannel/services/database.dart';
import 'package:e_commerece_app_with_admin_pannel/widgets/support_widgets.dart';
import 'package:flutter/material.dart';

class AllOrdersScreen extends StatefulWidget {
  const AllOrdersScreen({super.key});

  @override
  State<AllOrdersScreen> createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {
  Stream? orderStream;

  Future<void> getOnTheLoad() async {
    orderStream = await DatabaseMethods().allOrders();

    setState(() {});
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
            DocumentSnapshot document =
                snapshot.data.docs[index];

            Map<String, dynamic> ds =
                document.data() as Map<String, dynamic>;

            String docId = document.id;

            // Product Image
            String productImagePath =
                ds["Product_Image"]?.toString() ?? "";

            // Product Name
            String productName =
                ds["Product"]?.toString() ??
                    "Unknown Product";

            // Product Price
            String price =
                ds["Price"]?.toString() ?? "0";

            // Customer Name
            String customerName =
                ds["Name"]?.toString() ??
                    "Unknown User";

            // Customer Email
            String customerEmail =
                ds["Email"]?.toString() ??
                    "No Email";

            // Order Status
            String status =
                ds["Status"]?.toString() ??
                    "Pending";

            bool isDelivered =
                status.toLowerCase() == "delivered";

            return Container(
              margin: const EdgeInsets.only(
                bottom: 15,
              ),
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [

                      // TOP ROW
                      Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [

                          // PRODUCT IMAGE
                          productImagePath.isNotEmpty
                              ? productImage(
                                  productImagePath,
                                )
                              : Container(
                                  height: 100,
                                  width: 100,
                                  decoration:
                                      BoxDecoration(
                                    color: Colors
                                        .grey.shade200,
                                    borderRadius:
                                        BorderRadius
                                            .circular(
                                                10),
                                  ),
                                  child: const Icon(
                                    Icons
                                        .image_not_supported,
                                    size: 40,
                                    color:
                                        Colors.grey,
                                  ),
                                ),

                          const SizedBox(width: 15),

                          // DETAILS
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                              children: [

                                // PRODUCT NAME
                                Text(
                                  productName,
                                  style: AppWidgets
                                      .semiboldTextFieldStyle(),
                                  maxLines: 2,
                                  overflow:
                                      TextOverflow
                                          .ellipsis,
                                ),

                                const SizedBox(
                                  height: 8,
                                ),

                                // PRICE
                                Text(
                                  "Rs. $price",
                                  style:
                                      const TextStyle(
                                    color: Color(
                                      0xFFFD6F3E,
                                    ),
                                    fontSize: 18,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(
                                  height: 8,
                                ),

                                // USER NAME
                                Text(
                                  "Username: $customerName",
                                  style:
                                      const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),

                                const SizedBox(
                                  height: 5,
                                ),

                                // EMAIL
                                Text(
                                  "Email: $customerEmail",
                                  style:
                                      const TextStyle(
                                    fontSize: 14,
                                  ),
                                  maxLines: 1,
                                  overflow:
                                      TextOverflow
                                          .ellipsis,
                                ),
                              ],
                            ),
                          ),

                          // DELETE
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder:
                                    (context) {
                                  return AlertDialog(
                                    title: const Text(
                                      "Delete Order",
                                    ),
                                    content:
                                        const Text(
                                      "Are you sure you want to delete this order?",
                                    ),
                                    actions: [

                                      // CANCEL
                                      TextButton(
                                        onPressed:
                                            () {
                                          Navigator.pop(
                                              context);
                                        },
                                        child:
                                            const Text(
                                          "Cancel",
                                        ),
                                      ),

                                      // DELETE
                                      TextButton(
                                        onPressed:
                                            () async {
                                          await DatabaseMethods()
                                              .deleteOrder(
                                                  docId);

                                          if (context
                                              .mounted) {
                                            Navigator.pop(
                                                context);
                                          }
                                        },
                                        child:
                                            const Text(
                                          "Delete",
                                          style:
                                              TextStyle(
                                            color: Colors
                                                .red,
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

                      const SizedBox(height: 12),

                      // STATUS
                      Row(
                        children: [
                          const Text(
                            "Status: ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          Text(
                            status,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight:
                                  FontWeight.bold,
                              color: isDelivered
                                  ? Colors.green
                                  : Colors.orange,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // DELIVER BUTTON
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: isDelivered
                              ? null
                              : () async {
                                  await DatabaseMethods()
                                      .updateOrderStatus(
                                    docId,
                                    "Delivered",
                                  );
                                },
                          style:
                              ElevatedButton.styleFrom(
                            backgroundColor:
                                isDelivered
                                    ? Colors.green
                                    : Colors.black,
                            foregroundColor:
                                Colors.white,
                            padding:
                                const EdgeInsets
                                    .symmetric(
                              vertical: 12,
                            ),
                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius
                                      .circular(8),
                            ),
                          ),
                          child: Text(
                            isDelivered
                                ? "Order Delivered"
                                : "Mark as Delivered",
                          ),
                        ),
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
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "All Orders",
          style: AppWidgets
              .semiboldTextFieldStyle(),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(
          left: 20,
          right: 20,
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