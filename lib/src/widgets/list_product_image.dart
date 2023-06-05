import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:collection/collection.dart';
import 'package:dongphuc296web/src/util/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/model/product_model.dart';
import '../layout/adaptive.dart';
import '../util/colors.dart';
import 'dart:html' as html;
import 'dart:io';

class ListProductImageWidget extends StatefulWidget {
  final ProductModel productModel;

  const ListProductImageWidget({super.key, required this.productModel});

  @override
  State<StatefulWidget> createState() {
    return ListProductImageWidgetState();
  }
}

class ListProductImageWidgetState extends State<ListProductImageWidget> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  final double imageSlidersHeight = 400.0;

  final List<String> lstImagePath = [];
  List lstImageFile = [];

  @override
  void initState() {
    super.initState();
    getImageList();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);

    return
        // CarouselSlider(
        //   items: imageSliders,
        //   carouselController: _controller,
        //   options: CarouselOptions(height: imageSlidersHeight,),
        // );
        Stack(
      children: [
        CarouselSlider(
          items: imageSliders(),
          carouselController: _controller,
          options: CarouselOptions(
              height: imageSlidersHeight,
              autoPlay: false,
              enlargeCenterPage: true,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Positioned(
          bottom: 5.0,
          left: 0.0,
          right: 0.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: lstImagePath.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                              ? web296Pink50
                              : web296BackgroundWhite)
                          .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  void getImageList() {
    // lstImageFile = html.Lis.File(imageFolderPath.codeUnits, imageFolderPath).listSync();
    // lstImageFile.forEachIndexed((item, index) {
    //   lstImagePath.add('$imageFolderPath/${index + 1}');
    // });

    for (var i = 1; i < 5; i++) {
      // if (await File("path/to/file").exists())
        lstImagePath.add('$i.jpg');
    }

    setState(() {
      lstImagePath;
    });
  }

  List<Widget> imageSliders() {
    return lstImagePath
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        // Image.network(item, fit: BoxFit.cover, width: 1000.0),
                        Image.asset(
                          item,
                          package: widget.productModel.getFullImageFolder,
                          width: 1000,
                        ),

                      ],
                    )),
              ),
            ))
        .toList();
  }
}
