import 'dart:convert';
import 'dart:io';

import 'package:dongphuc296web/src/data/model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../data/gallery_options.dart';
import '../layout/adaptive.dart';
import '../util/colors.dart';
import '../util/strings.dart';
import '../util/utils.dart';
import '../widgets/contact_us_widget.dart';
import '../widgets/footer_widget.dart';
import '../widgets/product_detail_widget.dart';
import '../widgets/web_296_logo_widget.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel productModel;

  const ProductDetailScreen({super.key, required this.productModel});

  @override
  ProductDetailScreenState createState() => ProductDetailScreenState();
}

class ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    super.initState();
    // loadModel();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    return ApplyTextOptions(
      child: isDesktop
          ? LayoutBuilder(
              builder: (context, constraints) => Scaffold(
                    body: SingleChildScrollView(
                        child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Padding(
                          //   child: Web296LogoWidget(),
                          //   padding: const EdgeInsets.only(left: 12),
                          // ),
                          // SizedBox(height: 40),
                          buildProductDetail(widget.productModel),
                          FooterWidget()
                        ],
                      ),
                    )),
                  ))

          ///MOBILE
          : Scaffold(
              body: SafeArea(
                child: ListView(
                  restorationId: 'login_list_view',
                  physics: const ClampingScrollPhysics(),
                  children: [
                    SizedBox(height: 30),
                    Web296LogoWidget(),
                    SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: buildContactMobile(),
                    ),
                    SizedBox(height: 20),
                    MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                            onTap: () {
                              Utils.launchLink(googleMapLink);
                            },
                            child: Image.asset(googleMapMobileIconPath))),
                    FooterWidget()
                  ],
                ),
              ),
            ),
    );
  }

  ProductDetailWidget buildProductDetail(ProductModel productModel) {
    return ProductDetailWidget(
      productModel: productModel,
    );
    // return Row(
    //   children: [
    //     ProductDetailWidget(
    //       productModel: productModel,
    //     ),
    //     SizedBox(width: 56),
    //   ],
    // );
  }

  Column buildContactMobile() {
    return Column(
      children: [
        ContactUsWidget(
            icon: Icons.location_on,
            iconSize: 40,
            title: '$textAddress:',
            content: '$addressMobile',
            isClickable: false),
        SizedBox(height: 20),
        ContactUsWidget(
            icon: Icons.mail_outline,
            iconSize: 45,
            title: '$textEmail:',
            content: '$email',
            isClickable: false),
        SizedBox(height: 20),
        ContactUsWidget(
            icon: Icons.phone_in_talk,
            iconSize: 40,
            title: '$textPhone:',
            content: '$phone',
            isClickable: true),
      ],
    );
  }
}
