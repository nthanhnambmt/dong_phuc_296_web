// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../data.dart';
import '../screens/cards_demo.dart';

class ProductList extends StatelessWidget {
  final List<Product> lstProduct;
  final ValueChanged<Product>? onTap;

  const ProductList({
    required this.lstProduct,
    this.onTap,
    super.key,
  });

  // @override
  // Widget build(BuildContext context) =>
  // ListView.builder(
  //       itemCount: books.length,
  //       itemBuilder: (context, index) => ListTile(
  //         title: Text(
  //           books[index].title,
  //         ),
  //         subtitle: Text(
  //           books[index].author.name,
  //         ),
  //         onTap: onTap != null ? () => onTap!(books[index]) : null,
  //       ),
  //     );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: Text('Demo CardTitle'),
      // ),
      body: Scrollbar(
        child: GridView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          itemCount: destinations.length,
          itemBuilder: (ctx, index) {
            return Card(
              child: Container(
                height: 290,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(5),
                child: InkWell(
                  onTap: onTap != null ? () => onTap!(lstProduct[index]) : null,
                  // Generally, material cards use onSurface with 12% opacity for the pressed state.
                  splashColor:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
                  // Generally, material cards do not have a highlight overlay.
                  highlightColor: Colors.transparent,
                  child: TravelDestinationContent(
                    destination: destinations[index],
                  ),
                ),
              ),
            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1.0,
            crossAxisSpacing: 0.0,
            mainAxisSpacing: 5,
            mainAxisExtent: 264,
          ),
        ),
      ),
    );
  }
}
