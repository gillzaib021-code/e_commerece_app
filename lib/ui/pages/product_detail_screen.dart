// import 'dart:convert';

// import 'package:e_commerece_app_with_admin_pannel/services/constants.dart';
// import 'package:e_commerece_app_with_admin_pannel/services/database.dart';
// import 'package:e_commerece_app_with_admin_pannel/services/shared_pref.dart';
// import 'package:e_commerece_app_with_admin_pannel/ui/pages/home/home_screen.dart';
// import 'package:e_commerece_app_with_admin_pannel/widgets/support_widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:http/http.dart' as http;

// class ProductDetailScreen extends StatefulWidget {
//   final String image;
//   final String name;
//   final String detail;
//   final String price;

//   const ProductDetailScreen({
//     super.key,
//     required this.image,
//     required this.name,
//     required this.detail,
//     required this.price,
//   });

//   @override
//   State<ProductDetailScreen> createState() => _ProductDetailScreenState();
// }

// class _ProductDetailScreenState extends State<ProductDetailScreen> {
 
//  String? name, mail, image;

//  getheshareprefs()async{
//   name=await SharedPrefHelper().getUserName();
//   mail=await SharedPrefHelper().getUserEmail();
//   image=await SharedPrefHelper().getUserImage();
//   setState(() {
    
//   });
//  }

//   ontheload()async{
//      await getheshareprefs();
//      setState(() {
       
//      });
//   }

//   @override
//   void initState() {
    
//     super.initState();
//     ontheload();
//   }


//   Map<String, dynamic>? paymentIntent;
//   bool isLoading = false;

//   // =========================
//   // MAKE PAYMENT
//   // =========================

//   Future<void> makePayment(String amount) async {
//     if (isLoading) return;

//     setState(() {
//       isLoading = true;
//     });

//     try {
//       debugPrint('==============================');
//       debugPrint('BUY NOW CLICKED');
//       debugPrint('Product: ${widget.name}');
//       debugPrint('Amount: $amount');
//       debugPrint('==============================');

//       // Create Payment Intent
//       paymentIntent = await createPaymentIntent(
//         amount,
//         'PKR',
//       );

//       debugPrint('Payment Intent Response:');
//       debugPrint(paymentIntent.toString());

//       // Check client secret
//       final clientSecret = paymentIntent?['client_secret'];

//       if (clientSecret == null || clientSecret.toString().isEmpty) {
//         throw Exception(
//           'PaymentIntent client_secret was not returned by Stripe.',
//         );
//       }

//       // Initialize Stripe Payment Sheet
//       await Stripe.instance.initPaymentSheet(
//         paymentSheetParameters: SetupPaymentSheetParameters(
//           paymentIntentClientSecret: clientSecret,
//           merchantDisplayName: 'Zaib Store',
//         ),
//       );

//       debugPrint('Payment Sheet initialized successfully.');

//       // Open Payment Sheet
//       await displayPaymentSheet();
//     } catch (e, stackTrace) {
//       debugPrint('==============================');
//       debugPrint('PAYMENT ERROR');
//       debugPrint(e.toString());
//       debugPrint(stackTrace.toString());
//       debugPrint('==============================');

//       if (!mounted) return;

//       await showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: const Text('Payment Error'),
//             content: Text(
//               e.toString(),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: const Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     } finally {
//       if (mounted) {
//         setState(() {
//           isLoading = false;
//         });
//       }
//     }
//   }

//   // =========================
//   // DISPLAY PAYMENT SHEET
//   // =========================

//   Future<void> displayPaymentSheet() async {
//     Map<String, dynamic> orderInfoMap={
//       "Product": widget.name,
//       "Price": widget.price,
//       "Name":name,
//       "Email":mail,
//       "Image":image,
//       "Product_Image":widget.image,
//     };
//     await DatabaseMethods().orderDetails(orderInfoMap);
//     try {
//       await Stripe.instance.presentPaymentSheet();

//       debugPrint('Payment completed successfully.');

//       if (!mounted) return;

//       await showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: const Text('Payment Successful'),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Icon(
//                   Icons.check_circle,
//                   color: Colors.green,
//                   size: 60,
//                 ),
//                 const SizedBox(height: 15),
//                 const Text(
//                   'Payment Successfully Completed!',
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 10),
//                 Text(
//                   'Product: ${widget.name}',
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: const Text('OK'),
//               ),
//             ],
//           );
//         },
//       );

//       paymentIntent = null;
//     } on StripeException catch (e) {
//       debugPrint('Stripe Exception: $e');

//       if (!mounted) return;

//       await showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: const Text('Payment Cancelled'),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Icon(
//                   Icons.cancel,
//                   color: Colors.red,
//                   size: 60,
//                 ),
//                 const SizedBox(height: 15),
//                 const Text(
//                   'Payment was cancelled.',
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: const Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     } catch (e) {
//       debugPrint('Payment Sheet Error: $e');

//       if (!mounted) return;

//       await showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: const Text('Payment Error'),
//             content: Text(
//               e.toString(),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: const Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }

//   // =========================
//   // CREATE PAYMENT INTENT
//   // =========================

//   Future<Map<String, dynamic>> createPaymentIntent(
//     String amount,
//     String currency,
//   ) async {
//     try {
//       final Map<String, dynamic> body = {
//         'amount': calculateAmount(amount),
//         'currency': currency.toLowerCase(),
//         'payment_method_types[]': 'card',
//       };

//       debugPrint('Creating PaymentIntent...');
//       debugPrint('Amount in smallest unit: ${body['amount']}');
//       debugPrint('Currency: ${body['currency']}');

//       final response = await http.post(
//         Uri.parse(
//           'https://api.stripe.com/v1/payment_intents',
//         ),
//         headers: {
//           'Authorization': 'Bearer $secretkey',
//           'Content-Type': 'application/x-www-form-urlencoded',
//         },
//         body: body,
//       );

//       debugPrint('Stripe Status Code: ${response.statusCode}');
//       debugPrint('Stripe Response: ${response.body}');

//       final responseData = jsonDecode(response.body);

//       if (response.statusCode < 200 || response.statusCode >= 300) {
//         throw Exception(
//           responseData['error']?['message'] ??
//               'Stripe PaymentIntent creation failed.',
//         );
//       }

//       return Map<String, dynamic>.from(responseData);
//     } catch (e) {
//       debugPrint('Create Payment Intent Error: $e');
//       rethrow;
//     }
//   }

//   // =========================
//   // CALCULATE AMOUNT
//   // =========================

//   String calculateAmount(String amount) {
//     final double parsedAmount = double.parse(
//       amount.replaceAll(',', '').trim(),
//     );

//     final int calculatedAmount = (parsedAmount * 100).round();

//     return calculatedAmount.toString();
//   }

//   // =========================
//   // UI
//   // =========================

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFFEF5F1),
//       body: Container(
//         padding: const EdgeInsets.only(top: 50),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // =========================
//             // IMAGE + BACK BUTTON
//             // =========================

//             Stack(
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                   child: Container(
//                     margin: const EdgeInsets.only(left: 20),
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       border: Border.all(),
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     child: const Icon(
//                       Icons.arrow_back_ios_new_outlined,
//                     ),
//                   ),
//                 ),

//                 Center(
//                   child: widget.image.startsWith('http')
//                       ? Image.network(
//                           widget.image,
//                           height: 400,
//                           fit: BoxFit.contain,
//                           errorBuilder: (
//                             context,
//                             error,
//                             stackTrace,
//                           ) {
//                             return const SizedBox(
//                               height: 400,
//                               child: Center(
//                                 child: Icon(
//                                   Icons.image_not_supported,
//                                   size: 80,
//                                 ),
//                               ),
//                             );
//                           },
//                         )
//                       : Image.asset(
//                           widget.image,
//                           height: 400,
//                           fit: BoxFit.contain,
//                         ),
//                 ),
//               ],
//             ),

//             // =========================
//             // PRODUCT DETAILS
//             // =========================

//             Expanded(
//               child: Container(
//                 width: MediaQuery.of(context).size.width,
//                 padding: const EdgeInsets.only(
//                   top: 16,
//                   left: 20,
//                   right: 20,
//                 ),
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topRight: Radius.circular(20),
//                     topLeft: Radius.circular(20),
//                   ),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // PRODUCT NAME + PRICE
//                     Row(
//                       mainAxisAlignment:
//                           MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           child: Text(
//                             widget.name,
//                             style: AppWidgets.boldTextFieldStyle(),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),

//                         const SizedBox(width: 10),

//                         Text(
//                           'Rs. ${widget.price}',
//                           style: const TextStyle(
//                             color: Color(0xFFFD6F3E),
//                             fontSize: 24,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ),

//                     const SizedBox(height: 10),

//                     // DETAIL
//                     Text(
//                       'Detail',
//                       style:
//                           AppWidgets.semiboldTextFieldStyle(),
//                     ),

//                     const SizedBox(height: 5),

//                     Text(
//                       widget.detail,
//                       style:
//                           AppWidgets.lightTextFieldStyle(),
//                     ),

//                     const Spacer(),

//                     // =========================
//                     // BUY NOW BUTTON
//                     // =========================

//                     GestureDetector(
//                       onTap: isLoading
//                           ? null
//                           : () {
//                               makePayment(widget.price);
//                             },
//                       child: Container(
//                         width: MediaQuery.of(context).size.width,
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 14,
//                         ),
//                         margin: const EdgeInsets.only(
//                           bottom: 25,
//                         ),
//                         decoration: BoxDecoration(
//                           color: isLoading
//                               ? Colors.grey
//                               : const Color(0xFFFD6F3E),
//                           borderRadius:
//                               BorderRadius.circular(10),
//                         ),
//                         child: Center(
//                           child: isLoading
//                               ? const SizedBox(
//                                   height: 25,
//                                   width: 25,
//                                   child:
//                                       CircularProgressIndicator(
//                                     color: Colors.white,
//                                     strokeWidth: 3,
//                                   ),
//                                 )
//                               : const Text(
//                                   'Buy Now',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 20,
//                                     fontWeight:
//                                         FontWeight.bold,
//                                   ),
//                                 ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:e_commerece_app_with_admin_pannel/services/constants.dart';
import 'package:e_commerece_app_with_admin_pannel/services/database.dart';
import 'package:e_commerece_app_with_admin_pannel/services/shared_pref.dart';
import 'package:e_commerece_app_with_admin_pannel/widgets/support_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class ProductDetailScreen extends StatefulWidget {
  final String image;
  final String name;
  final String detail;
  final String price;

  const ProductDetailScreen({
    super.key,
    required this.image,
    required this.name,
    required this.detail,
    required this.price,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String? name;
  String? mail;
  String? image;

  Map<String, dynamic>? paymentIntent;
  bool isLoading = false;

  // =========================
  // GET USER DATA
  // =========================

  Future<void> getheshareprefs() async {
    name = await SharedPrefHelper().getUserName();
    mail = await SharedPrefHelper().getUserEmail();
    image = await SharedPrefHelper().getUserImage();

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> ontheload() async {
    await getheshareprefs();
  }

  @override
  void initState() {
    super.initState();
    ontheload();
  }

  // =========================
  // MAKE PAYMENT
  // =========================

  Future<void> makePayment(String amount) async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    try {
      debugPrint('==============================');
      debugPrint('BUY NOW CLICKED');
      debugPrint('Product: ${widget.name}');
      debugPrint('Amount: $amount');
      debugPrint('==============================');

      // Create Payment Intent
      paymentIntent = await createPaymentIntent(
        amount,
        'PKR',
      );

      debugPrint('Payment Intent Response:');
      debugPrint(paymentIntent.toString());

      // Check client secret
      final clientSecret = paymentIntent?['client_secret'];

      if (clientSecret == null || clientSecret.toString().isEmpty) {
        throw Exception(
          'PaymentIntent client_secret was not returned by Stripe.',
        );
      }

      // Initialize Stripe Payment Sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Zaib Store',
        ),
      );

      debugPrint('Payment Sheet initialized successfully.');

      // Open Payment Sheet
      await displayPaymentSheet();
    } catch (e, stackTrace) {
      debugPrint('==============================');
      debugPrint('PAYMENT ERROR');
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());
      debugPrint('==============================');

      if (!mounted) return;

      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Payment Error'),
            content: Text(
              e.toString(),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  // =========================
  // DISPLAY PAYMENT SHEET
  // =========================

  Future<void> displayPaymentSheet() async {
    try {
      // =========================
      // OPEN STRIPE PAYMENT SHEET
      // =========================

      await Stripe.instance.presentPaymentSheet();

      debugPrint('Payment completed successfully.');

      // =========================
      // PAYMENT SUCCESS
      // SAVE ORDER IN FIRESTORE
      // =========================

      Map<String, dynamic> orderInfoMap = {
        "Product": widget.name,
        "Price": widget.price,
        "Name": name,
        "Email": mail,
        "Image": image,
        "Product_Image": widget.image,
        "Status": "Pending",
      };

      await DatabaseMethods().orderDetails(orderInfoMap);

      debugPrint('==============================');
      debugPrint('ORDER SAVED TO FIRESTORE');
      debugPrint('Product: ${widget.name}');
      debugPrint('Price: ${widget.price}');
      debugPrint('Name: $name');
      debugPrint('Email: $mail');
      debugPrint('==============================');

      if (!mounted) return;

      // =========================
      // SUCCESS DIALOG
      // =========================

      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Payment Successful'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 60,
                ),
                const SizedBox(height: 15),
                const Text(
                  'Payment Successfully Completed!',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Product: ${widget.name}',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5),
                Text(
                  'Price: Rs. ${widget.price}',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );

      paymentIntent = null;
    } on StripeException catch (e) {
      debugPrint('Stripe Exception: $e');

      if (!mounted) return;

      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Payment Cancelled'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.cancel,
                  color: Colors.red,
                  size: 60,
                ),
                const SizedBox(height: 15),
                const Text(
                  'Payment was cancelled.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      debugPrint('Payment Sheet Error: $e');

      if (!mounted) return;

      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Payment Error'),
            content: Text(
              e.toString(),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  // =========================
  // CREATE PAYMENT INTENT
  // =========================

  Future<Map<String, dynamic>> createPaymentIntent(
    String amount,
    String currency,
  ) async {
    try {
      final Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency.toLowerCase(),
        'payment_method_types[]': 'card',
      };

      debugPrint('Creating PaymentIntent...');
      debugPrint('Amount in smallest unit: ${body['amount']}');
      debugPrint('Currency: ${body['currency']}');

      final response = await http.post(
        Uri.parse(
          'https://api.stripe.com/v1/payment_intents',
        ),
        headers: {
          'Authorization': 'Bearer $secretkey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      debugPrint('Stripe Status Code: ${response.statusCode}');
      debugPrint('Stripe Response: ${response.body}');

      final responseData = jsonDecode(response.body);

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw Exception(
          responseData['error']?['message'] ??
              'Stripe PaymentIntent creation failed.',
        );
      }

      return Map<String, dynamic>.from(responseData);
    } catch (e) {
      debugPrint('Create Payment Intent Error: $e');
      rethrow;
    }
  }

  // =========================
  // CALCULATE AMOUNT
  // =========================

  String calculateAmount(String amount) {
    final double parsedAmount = double.parse(
      amount.replaceAll(',', '').trim(),
    );

    final int calculatedAmount = (parsedAmount * 100).round();

    return calculatedAmount.toString();
  }

  // =========================
  // UI
  // =========================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEF5F1),
      body: Container(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =========================
            // IMAGE + BACK BUTTON
            // =========================

            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 20),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                    ),
                  ),
                ),

                Center(
                  child: widget.image.startsWith('http')
                      ? Image.network(
                          widget.image,
                          height: 400,
                          fit: BoxFit.contain,
                          errorBuilder: (
                            context,
                            error,
                            stackTrace,
                          ) {
                            return const SizedBox(
                              height: 400,
                              child: Center(
                                child: Icon(
                                  Icons.image_not_supported,
                                  size: 80,
                                ),
                              ),
                            );
                          },
                        )
                      : Image.asset(
                          widget.image,
                          height: 400,
                          fit: BoxFit.contain,
                        ),
                ),
              ],
            ),

            // =========================
            // PRODUCT DETAILS
            // =========================

            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(
                  top: 16,
                  left: 20,
                  right: 20,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // PRODUCT NAME + PRICE

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.name,
                            style: AppWidgets.boldTextFieldStyle(),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        const SizedBox(width: 10),

                        Text(
                          'Rs. ${widget.price}',
                          style: const TextStyle(
                            color: Color(0xFFFD6F3E),
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // DETAIL

                    Text(
                      'Detail',
                      style: AppWidgets.semiboldTextFieldStyle(),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      widget.detail,
                      style: AppWidgets.lightTextFieldStyle(),
                    ),

                    const Spacer(),

                    // =========================
                    // BUY NOW BUTTON
                    // =========================

                    GestureDetector(
                      onTap: isLoading
                          ? null
                          : () {
                              makePayment(widget.price);
                            },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                        margin: const EdgeInsets.only(
                          bottom: 25,
                        ),
                        decoration: BoxDecoration(
                          color: isLoading
                              ? Colors.grey
                              : const Color(0xFFFD6F3E),
                          borderRadius:
                              BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: isLoading
                              ? const SizedBox(
                                  height: 25,
                                  width: 25,
                                  child:
                                      CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 3,
                                  ),
                                )
                              : const Text(
                                  'Buy Now',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}