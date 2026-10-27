// import 'package:cloud_firestore/cloud_firestore.dart';

// class DatabaseMethods {
//   Future addUserDetail(Map<String, dynamic> userInfoMap, String id) async {
//     return await FirebaseFirestore.instance
//         .collection("users")
//         .doc(id)
//         .set(userInfoMap);
//   }

//   Future addProduct(
//     Map<String, dynamic> userInfoMap,
//     String categoryname,
//   ) async {
//     return await FirebaseFirestore.instance
//         .collection(categoryname)
//         .add(userInfoMap);
//   }

//   //  updateStatus(
   
//   //   String id,
//   // ) async {
//   //   return await FirebaseFirestore.instance
//   //       .collection("Orders").doc(id)
//   //       .update({"Status":"Delivered"});
//   // }

//   Future<void> updateOrderStatus(
//     String docId,
//     String status,
// ) async {
//   await FirebaseFirestore.instance
//       .collection("Orders")
//       .doc(docId)
//       .update({
//     "Status": status,
//   });
// }

//   Future<Stream<QuerySnapshot>> getProducts(String category) async {
//     return await FirebaseFirestore.instance.collection(category).snapshots();
//   }

//   Future<Stream<QuerySnapshot>> allOrders() async {
//     return await FirebaseFirestore.instance
//         .collection("Orders")
//         .where("Status", isEqualTo: "On the way")
//         .snapshots();
//   }

//   Future<Stream<QuerySnapshot>> getOrders(String email) async {
//     return await FirebaseFirestore.instance
//         .collection("Orders")
//         .where("Email", isEqualTo: email)
//         .snapshots();
//   }

//   // Future<Stream<QuerySnapshot>> getProducts(String category) async {
//   //   return await FirebaseFirestore.instance
//   //       .collection("Products")
//   //       .where("Category", isEqualTo: category)
//   //       .snapshots();

//   Future orderDetails(Map<String, dynamic> userInfoMap) async {
//     return await FirebaseFirestore.instance
//         .collection("Orders")
//         .add(userInfoMap);
//   }

//   Future deleteOrder(String docId) async {
//     await FirebaseFirestore.instance.collection("Orders").doc(docId).delete();
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserDetail(
    Map<String, dynamic> userInfoMap,
    String id,
  ) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(userInfoMap);
  }

  Future addProduct(
    Map<String, dynamic> userInfoMap,
    String categoryname,
  ) async {
    return await FirebaseFirestore.instance
        .collection(categoryname)
        .add(userInfoMap);
  }

  // Update Order Status
  Future<void> updateOrderStatus(
    String docId,
    String status,
  ) async {
    await FirebaseFirestore.instance
        .collection("Orders")
        .doc(docId)
        .update({
      "Status": status,
    });
  }

  Future<Stream<QuerySnapshot>> getProducts(
    String category,
  ) async {
    return await FirebaseFirestore.instance
        .collection(category)
        .snapshots();
  }

  // Get ALL Orders for Admin
  Future<Stream<QuerySnapshot>> allOrders() async {
    return await FirebaseFirestore.instance
        .collection("Orders")
        .snapshots();
  }

  // Get Orders for Current User
  Future<Stream<QuerySnapshot>> getOrders(
    String email,
  ) async {
    return await FirebaseFirestore.instance
        .collection("Orders")
        .where(
          "Email",
          isEqualTo: email,
        )
        .snapshots();
  }

  // Save Order
  Future orderDetails(
    Map<String, dynamic> userInfoMap,
  ) async {
    return await FirebaseFirestore.instance
        .collection("Orders")
        .add(userInfoMap);
  }

  // Delete Order
  Future deleteOrder(
    String docId,
  ) async {
    await FirebaseFirestore.instance
        .collection("Orders")
        .doc(docId)
        .delete();
  }
}