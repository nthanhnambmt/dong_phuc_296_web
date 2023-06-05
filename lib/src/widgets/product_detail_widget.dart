import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../data/model/product_model.dart';
import '../util/colors.dart';
import '../util/strings.dart';
import 'list_product_image.dart';

class ProductDetailWidget extends StatelessWidget {
  const ProductDetailWidget({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 400,
      child: ListProductImageWidget(productModel: productModel),
    );
    // return Row(
    //   children: [
    //     Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         ListProductImageWidget(),
    //       ],
    //     )
    //   ],
    // );
  }
}
