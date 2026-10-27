import 'package:e_commerece_app_with_admin_pannel/services/shared_pref.dart';
import 'package:e_commerece_app_with_admin_pannel/ui/pages/category_product.dart';
import 'package:e_commerece_app_with_admin_pannel/ui/pages/product_detail_screen.dart';
import 'package:e_commerece_app_with_admin_pannel/widgets/support_widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ================= CATEGORIES =================

  final List<String> category = [
    "assets/images/headphone_icon.png",
    "assets/images/laptop.png",
    "assets/images/watch.png",
    "assets/images/TV.png",
  ];

  final List<String> categoryname = [
    "Headphones",
    "Laptop",
    "Watch",
    "TV",
  ];

  // ================= USER DATA =================

  String? name;
  String? image;

  // ================= SEARCH =================

  final TextEditingController searchController = TextEditingController();

  String searchText = "";

  // ================= PRODUCTS =================

  final List<Map<String, dynamic>> products = [
    {
      "image": "assets/images/headphone2.png",
      "name": "HeadPhoene",
      "detail":
          "High-quality over-ear headphones with noise cancellation and long battery life.",
      "price": "300",
    },
    {
      "image": "assets/images/watch2.png",
      "name": "Apple Watch",
      "detail":
          "Stay connected and track your fitness with this sleek smartwatch. Features heart rate monitoring, GPS tracking, water resistance, and seamless notifications right on your wrist.",
      "price": "300",
    },
    {
      "image": "assets/images/laptop2.png",
      "name": "Hp Laptop",
      "detail":
          "Powerful and portable, this laptop is built for work and play. Features a fast processor, ample storage, a crisp full-HD display, and all-day battery life for productivity on the go.",
      "price": "500",
    },
    {
      "image": "assets/images/TV.png",
      "name": "TV",
      "detail":
          "Experience stunning 4K Ultra HD picture quality with vibrant colors and deep contrast. Smart TV features let you stream your favorite content, all on a sleek, slim design.",
      "price": "500",
    },
  ];

  // ================= FILTER PRODUCTS =================

  List<Map<String, dynamic>> get filteredProducts {
    if (searchText.trim().isEmpty) {
      return products;
    }

    final String search = searchText.trim().toLowerCase();

    return products.where((product) {
      final String productName =
          product["name"].toString().toLowerCase();

      final String productDetail =
          product["detail"].toString().toLowerCase();

      return productName.contains(search) ||
          productDetail.contains(search);
    }).toList();
  }

  // ================= GET SHARED PREF =================

  Future<void> getthesharedpref() async {
    name = await SharedPrefHelper().getUserName();
    image = await SharedPrefHelper().getUserImage();

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> ontheload() async {
    await getthesharedpref();
  }

  // ================= INIT =================

  @override
  void initState() {
    super.initState();
    ontheload();
  }

  // ================= DISPOSE =================

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // ================= OPEN PRODUCT =================

  void openProduct(Map<String, dynamic> product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailScreen(
          image: product["image"].toString(),
          name: product["name"].toString(),
          detail: product["detail"].toString(),
          price: product["price"].toString(),
        ),
      ),
    );
  }

  // ================= PROFILE IMAGE =================

  Widget profileImage() {
    // Agar user ki image available nahi hai
    if (image == null || image!.trim().isEmpty) {
      return Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Icon(
          Icons.person,
          color: Colors.grey,
          size: 28,
        ),
      );
    }

    // Agar user ki network image available hai
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        image!,
        height: 45,
        width: 45,
        fit: BoxFit.cover,

        // Agar network image 403 / 404 / kisi bhi error ki wajah
        // se load na ho to icon show hoga.
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.person,
              color: Colors.grey,
              size: 28,
            ),
          );
        },
      ),
    );
  }

  // ================= BUILD =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),

      // Keyboard open hone par screen resize hogi
      resizeToAvoidBottomInset: true,

      body: name == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 30,
                    left: 20,
                    right: 20,
                    bottom: 30,
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [

                      // ================= HEADER =================

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hey, $name",
                                style:
                                    AppWidgets.boldTextFieldStyle(),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                "Good Morning",
                                style:
                                    AppWidgets.lightTextFieldStyle(),
                              ),
                            ],
                          ),

                          // PROFILE IMAGE
                          profileImage(),
                        ],
                      ),

                      const SizedBox(height: 30),

                      // ================= SEARCH =================

                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: searchController,
                          onChanged: (value) {
                            setState(() {
                              searchText = value;
                            });
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search Products",
                            hintStyle:
                                AppWidgets.lightTextFieldStyle(),
                            prefixIcon:
                                const Icon(Icons.search),

                            suffixIcon:
                                searchText.isNotEmpty
                                    ? IconButton(
                                        icon: const Icon(
                                          Icons.clear,
                                        ),
                                        onPressed: () {
                                          searchController
                                              .clear();

                                          setState(() {
                                            searchText = "";
                                          });
                                        },
                                      )
                                    : null,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // ================= CATEGORIES TITLE =================

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Categories",
                            style: AppWidgets
                                .semiboldTextFieldStyle(),
                          ),
                          const Text(
                            "see all",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // ================= CATEGORIES =================

                      SizedBox(
                        height: 130,
                        child: Row(
                          children: [
                            Container(
                              height: 130,
                              padding:
                                  const EdgeInsets.all(20),
                              margin:
                                  const EdgeInsets.only(
                                left: 10,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    const Color(0xFFFD6F3E),
                                borderRadius:
                                    BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text(
                                  "All",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 10),

                            Expanded(
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: category.length,
                                scrollDirection:
                                    Axis.horizontal,
                                itemBuilder:
                                    (context, index) {
                                  return CategoriesTile(
                                    image: category[index],
                                    name:
                                        categoryname[index],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // ================= PRODUCTS TITLE =================

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "All Products",
                            style: AppWidgets
                                .semiboldTextFieldStyle(),
                          ),
                          const Text(
                            "see all",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      // ================= PRODUCTS =================

                      SizedBox(
                        height: 220,
                        child: filteredProducts.isEmpty
                            ? const Center(
                                child: Text(
                                  "No Product Found",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight:
                                        FontWeight.w600,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                scrollDirection:
                                    Axis.horizontal,
                                itemCount:
                                    filteredProducts.length,
                                itemBuilder:
                                    (context, index) {
                                  final product =
                                      filteredProducts[index];

                                  return GestureDetector(
                                    onTap: () {
                                      openProduct(product);
                                    },
                                    child: Container(
                                      width: 160,
                                      margin:
                                          const EdgeInsets.only(
                                        right: 20,
                                      ),
                                      padding:
                                          const EdgeInsets
                                              .symmetric(
                                        horizontal: 20,
                                      ),
                                      decoration:
                                          const BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        children: [

                                          // PRODUCT IMAGE

                                          Image.asset(
                                            product["image"]
                                                .toString(),
                                            height: 120,
                                            width: 120,
                                            fit: BoxFit.cover,
                                          ),

                                          // PRODUCT NAME

                                          Text(
                                            product["name"]
                                                .toString(),
                                            style: AppWidgets
                                                .semiboldTextFieldStyle(),
                                            maxLines: 1,
                                            overflow:
                                                TextOverflow
                                                    .ellipsis,
                                          ),

                                          const SizedBox(
                                            height: 20,
                                          ),

                                          // PRICE + ADD

                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            children: [
                                              Text(
                                                "\$${product["price"]}",
                                                style:
                                                    const TextStyle(
                                                  color: Color(
                                                    0xFFFD6F3E,
                                                  ),
                                                  fontSize: 20,
                                                  fontWeight:
                                                      FontWeight
                                                          .bold,
                                                ),
                                              ),

                                              Container(
                                                padding:
                                                    const EdgeInsets
                                                        .all(5),
                                                decoration:
                                                    BoxDecoration(
                                                  color:
                                                      const Color(
                                                    0xFFFD6F3E,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                    8,
                                                  ),
                                                ),
                                                child:
                                                    const Icon(
                                                  Icons.add,
                                                  color:
                                                      Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

// ============================================================
// CATEGORY TILE
// ============================================================

class CategoriesTile extends StatelessWidget {
  final String image;
  final String name;

  const CategoriesTile({
    super.key,
    required this.image,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryProduct(
              category: name,
            ),
          ),
        );
      },
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(20),
        margin:
            const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              image,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
            const Icon(Icons.forward),
          ],
        ),
      ),
    );
  }
}


// import 'package:e_commerece_app_with_admin_pannel/services/shared_pref.dart';
// import 'package:e_commerece_app_with_admin_pannel/ui/pages/category_product.dart';
// import 'package:e_commerece_app_with_admin_pannel/ui/pages/product_detail_screen.dart';
// import 'package:e_commerece_app_with_admin_pannel/widgets/support_widgets.dart';
// import 'package:flutter/material.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   List category = [
//     "assets/images/headphone_icon.png",
//     "assets/images/laptop.png",
//     "assets/images/watch.png",
//     "assets/images/TV.png",
//   ];

//   List categoryname = [
//     "Headphones",
//     "Laptop",
//     "Watch",
//     "TV",
//   ];

//   static const String defaultAvatarUrl =
//       "https://cdn-icons-png.flaticon.com/512/149/149071.png";

//   String? name, image;

//   final TextEditingController searchController = TextEditingController();

//   String searchText = "";

//   final List<Map<String, dynamic>> products = [
//     {
//       "image": "assets/images/headphone2.png",
//       "name": "HeadPhoene",
//       "detail":
//           "High-quality over-ear headphones with noise cancellation and long battery life.",
//       "price": "300",
//     },
//     {
//       "image": "assets/images/watch2.png",
//       "name": "Apple Watch",
//       "detail":
//           "Stay connected and track your fitness with this sleek smartwatch. Features heart rate monitoring, GPS tracking, water resistance, and seamless notifications right on your wrist.",
//       "price": "300",
//     },
//     {
//       "image": "assets/images/laptop2.png",
//       "name": "Hp Laptop",
//       "detail":
//           "Powerful and portable, this laptop is built for work and play. Features a fast processor, ample storage, a crisp full-HD display, and all-day battery life for productivity on the go.",
//       "price": "500",
//     },
//     {
//       "image": "assets/images/TV.png",
//       "name": "TV",
//       "detail":
//           "Experience stunning 4K Ultra HD picture quality with vibrant colors and deep contrast. Smart TV features let you stream your favorite content, all on a sleek, slim design.",
//       "price": "500",
//     },
//   ];

//   List<Map<String, dynamic>> get filteredProducts {
//     if (searchText.trim().isEmpty) {
//       return products;
//     }

//     final search = searchText.trim().toLowerCase();

//     return products.where((product) {
//       final productName = product["name"].toString().toLowerCase();
//       final productDetail = product["detail"].toString().toLowerCase();

//       return productName.contains(search) ||
//           productDetail.contains(search);
//     }).toList();
//   }

//   Future<void> getthesharedpref() async {
//     name = await SharedPrefHelper().getUserName();
//     image = await SharedPrefHelper().getUserImage();

//     if (mounted) {
//       setState(() {});
//     }
//   }

//   Future<void> ontheload() async {
//     await getthesharedpref();
//   }

//   @override
//   void initState() {
//     super.initState();
//     ontheload();
//   }

//   @override
//   void dispose() {
//     searchController.dispose();
//     super.dispose();
//   }

//   void openProduct(Map<String, dynamic> product) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => ProductDetailScreen(
//           image: product["image"],
//           name: product["name"],
//           detail: product["detail"],
//           price: product["price"],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xfff2f2f2),

//       // Keyboard ke waqt resize hoga.
//       resizeToAvoidBottomInset: true,

//       body: name == null
//           ? const Center(
//               child: CircularProgressIndicator(),
//             )
//           : SafeArea(
//               child: SingleChildScrollView(
//                 keyboardDismissBehavior:
//                     ScrollViewKeyboardDismissBehavior.onDrag,
//                 child: Padding(
//                   padding: const EdgeInsets.only(
//                     top: 30,
//                     left: 20,
//                     right: 20,
//                     bottom: 30,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // ================= HEADER =================
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Hey,$name",
//                                 style:
//                                     AppWidgets.boldTextFieldStyle(),
//                               ),
//                               const SizedBox(height: 3),
//                               Text(
//                                 "Good Morning",
//                                 style:
//                                     AppWidgets.lightTextFieldStyle(),
//                               ),
//                             ],
//                           ),

//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(20),
//                             child: Image.network(
//                               (image == null || image!.isEmpty)
//                                   ? defaultAvatarUrl
//                                   : image!,
//                               height: 45,
//                               width: 45,
//                               fit: BoxFit.cover,
//                               errorBuilder:
//                                   (context, error, stackTrace) {
//                                 return Image.network(
//                                   defaultAvatarUrl,
//                                   height: 45,
//                                   width: 45,
//                                   fit: BoxFit.cover,
//                                 );
//                               },
//                             ),
//                           ),
//                         ],
//                       ),

//                       const SizedBox(height: 30),

//                       // ================= SEARCH =================
//                       Container(
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: TextField(
//                           controller: searchController,
//                           onChanged: (value) {
//                             setState(() {
//                               searchText = value;
//                             });
//                           },
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             hintText: "Search Products",
//                             hintStyle:
//                                 AppWidgets.lightTextFieldStyle(),
//                             prefixIcon: const Icon(Icons.search),

//                             suffixIcon: searchText.isNotEmpty
//                                 ? IconButton(
//                                     icon: const Icon(Icons.clear),
//                                     onPressed: () {
//                                       searchController.clear();

//                                       setState(() {
//                                         searchText = "";
//                                       });
//                                     },
//                                   )
//                                 : null,
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 20),

//                       // ================= CATEGORIES TITLE =================
//                       Row(
//                         mainAxisAlignment:
//                             MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Categories",
//                             style:
//                                 AppWidgets.semiboldTextFieldStyle(),
//                           ),
//                           const Text(
//                             "see all",
//                             style: TextStyle(
//                               color: Colors.blue,
//                               fontSize: 20,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ],
//                       ),

//                       const SizedBox(height: 20),

//                       // ================= CATEGORIES =================
//                       SizedBox(
//                         height: 130,
//                         child: Row(
//                           children: [
//                             Container(
//                               height: 130,
//                               padding: const EdgeInsets.all(20),
//                               margin:
//                                   const EdgeInsets.only(left: 10),
//                               decoration: BoxDecoration(
//                                 color: const Color(0xFFFD6F3E),
//                                 borderRadius:
//                                     BorderRadius.circular(10),
//                               ),
//                               child: const Center(
//                                 child: Text(
//                                   "All",
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ),

//                             const SizedBox(width: 10),

//                             Expanded(
//                               child: ListView.builder(
//                                 padding: EdgeInsets.zero,
//                                 itemCount: category.length,
//                                 scrollDirection: Axis.horizontal,
//                                 itemBuilder: (context, index) {
//                                   return CategoriesTile(
//                                     image: category[index],
//                                     name: categoryname[index],
//                                   );
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),

//                       const SizedBox(height: 20),

//                       // ================= PRODUCTS TITLE =================
//                       Row(
//                         mainAxisAlignment:
//                             MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "All Products",
//                             style:
//                                 AppWidgets.semiboldTextFieldStyle(),
//                           ),
//                           const Text(
//                             "see all",
//                             style: TextStyle(
//                               color: Colors.blue,
//                               fontSize: 20,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ],
//                       ),

//                       const SizedBox(height: 30),

//                       // ================= PRODUCTS =================
//                       SizedBox(
//                         height: 220,
//                         child: filteredProducts.isEmpty
//                             ? const Center(
//                                 child: Text(
//                                   "No Product Found",
//                                   style: TextStyle(
//                                     fontSize: 17,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               )
//                             : ListView.builder(
//                                 scrollDirection: Axis.horizontal,
//                                 itemCount: filteredProducts.length,
//                                 itemBuilder: (context, index) {
//                                   final product =
//                                       filteredProducts[index];

//                                   return GestureDetector(
//                                     onTap: () {
//                                       openProduct(product);
//                                     },
//                                     child: Container(
//                                       width: 160,
//                                       margin: const EdgeInsets.only(
//                                         right: 20,
//                                       ),
//                                       padding:
//                                           const EdgeInsets.symmetric(
//                                         horizontal: 20,
//                                       ),
//                                       decoration: const BoxDecoration(
//                                         color: Colors.white,
//                                       ),
//                                       child: Column(
//                                         children: [
//                                           // PRODUCT IMAGE
//                                           Image.asset(
//                                             product["image"],
//                                             height: 120,
//                                             width: 120,
//                                             fit: BoxFit.cover,
//                                           ),

//                                           // PRODUCT NAME
//                                           Text(
//                                             product["name"],
//                                             style: AppWidgets
//                                                 .semiboldTextFieldStyle(),
//                                             maxLines: 1,
//                                             overflow:
//                                                 TextOverflow.ellipsis,
//                                           ),

//                                           const SizedBox(height: 20),

//                                           // PRICE + ADD
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment
//                                                     .spaceBetween,
//                                             children: [
//                                               Text(
//                                                 "\$${product["price"]}",
//                                                 style: const TextStyle(
//                                                   color:
//                                                       Color(0xFFFD6F3E),
//                                                   fontSize: 20,
//                                                   fontWeight:
//                                                       FontWeight.bold,
//                                                 ),
//                                               ),

//                                               Container(
//                                                 padding:
//                                                     const EdgeInsets
//                                                         .all(5),
//                                                 decoration:
//                                                     BoxDecoration(
//                                                   color:
//                                                       const Color(
//                                                     0xFFFD6F3E,
//                                                   ),
//                                                   borderRadius:
//                                                       BorderRadius
//                                                           .circular(8),
//                                                 ),
//                                                 child: const Icon(
//                                                   Icons.add,
//                                                   color: Colors.white,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//     );
//   }
// }

// // ============================================================
// // CATEGORY TILE
// // ============================================================

// class CategoriesTile extends StatelessWidget {
//   final String image;
//   final String name;

//   const CategoriesTile({
//     super.key,
//     required this.image,
//     required this.name,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => CategoryProduct(
//               category: name,
//             ),
//           ),
//         );
//       },
//       child: Container(
//         width: 100,
//         padding: const EdgeInsets.all(20),
//         margin: const EdgeInsets.only(right: 10),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Column(
//           mainAxisAlignment:
//               MainAxisAlignment.spaceBetween,
//           children: [
//             Image.asset(
//               image,
//               height: 50,
//               width: 50,
//               fit: BoxFit.cover,
//             ),
//             const Icon(Icons.forward),
//           ],
//         ),
//       ),
//     );
//   }
// }
