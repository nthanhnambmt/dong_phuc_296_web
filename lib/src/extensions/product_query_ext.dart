
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../data/model/product_model.dart';
// import '../util/query_enum.dart';
//
// extension on CollectionReference<Product> {
//   /// Create a firebase query from a [ProductQueryEnum]
//   Query<Product> createQueryBy(ProductQueryEnum queryEnum, Object query) {
//     switch (queryEnum) {
//       case ProductQueryEnum.name:
//         return where('productName', isEqualTo: query);
//
//       case ProductQueryEnum.categoryId:
//         return where('catId', isEqualTo: query);
//
//       case ProductQueryEnum.id:
//         return where('productId', isEqualTo: query);
//
//       case ProductQueryEnum.dateCreatedDesc:
//         return orderBy('dateCreated', descending: true);
//
//       case ProductQueryEnum.priceAsc:
//       case ProductQueryEnum.priceDesc:
//         return orderBy('productPrice', descending: query == ProductQueryEnum.priceDesc);
//     }
//   }
// }