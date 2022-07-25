// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

const String _kGalleryAssetsPackage = 'flutter_gallery_assets';
// const String _kGalleryAssetsPackage = 'flutter_gallery_assets';

// BEGIN cardsDemo

enum CardType {
  standard,
  tappable,
  selectable,
}

class TravelDestination {
  const TravelDestination({
    required this.assetName,
    required this.assetPackage,
    required this.title,
    required this.description,
    required this.city,
    required this.location,
    required this.price,
    this.cardType = CardType.standard,
  });

  final String assetName;
  final String assetPackage;
  final String title;
  final String description;
  final String city;
  final String location;
  final CardType cardType;
  final String price;
}

List<TravelDestination> destinations = [
  TravelDestination(
    assetName: 'products/clothing/ao_1.jpg',
    assetPackage: _kGalleryAssetsPackage,
    title: 'Áo bóng bàn andro đỏ',
    description: '11',
    city: '111',
    location: '1111',
    cardType: CardType.selectable,
    price: '180.000 đ',
  ),
  TravelDestination(
    assetName: 'products/clothing/ao_2.jpg',
    assetPackage: _kGalleryAssetsPackage,
    title: 'Áo bóng bàn andro xanh',
    description: '22',
    city: '222',
    location: '2222',
    cardType: CardType.selectable,
    price: '180.000 đ',
  ),
  TravelDestination(
    assetName: 'products/clothing/ao_3.jpg',
    assetPackage: _kGalleryAssetsPackage,
    title: 'Áo bóng bàn andro đỏ',
    description: '33',
    city: '333',
    location: '3333',
    cardType: CardType.selectable,
    price: '180.000 đ',
  ),
  TravelDestination(
    assetName: 'products/clothing/ao_3.jpg',
    assetPackage: _kGalleryAssetsPackage,
    title: 'Áo bóng bàn andro đỏ',
    description: '33',
    city: '333',
    location: '3333',
    cardType: CardType.selectable,
    price: '180.000 đ',
  ),
  TravelDestination(
    assetName: 'products/clothing/ao_3.jpg',
    assetPackage: _kGalleryAssetsPackage,
    title: 'Áo bóng bàn andro đỏ',
    description: '33',
    city: '333',
    location: '3333',
    cardType: CardType.selectable,
    price: '180.000 đ',
  ),
  TravelDestination(
    assetName: 'products/clothing/ao_3.jpg',
    assetPackage: _kGalleryAssetsPackage,
    title: 'Áo bóng bàn andro đỏ',
    description: '33',
    city: '333',
    location: '3333',
    cardType: CardType.selectable,
    price: '180.000 đ',
  ),
  TravelDestination(
    assetName: 'products/clothing/ao_3.jpg',
    assetPackage: _kGalleryAssetsPackage,
    title: 'Áo bóng bàn andro đỏ',
    description: '33',
    city: '333',
    location: '3333',
    cardType: CardType.selectable,
    price: '180.000 đ',
  ),
  TravelDestination(
    assetName: 'products/clothing/ao_3.jpg',
    assetPackage: _kGalleryAssetsPackage,
    title: 'Áo bóng bàn andro đỏ',
    description: '33',
    city: '333',
    location: '3333',
    cardType: CardType.selectable,
    price: '180.000 đ',
  ),
];

class TravelDestinationItem extends StatelessWidget {
  const TravelDestinationItem(
      {super.key, required this.destination, this.shape});

  // This height will allow for all the Card's content to fit comfortably within the card.
  static const height = 330.0;
  final TravelDestination destination;
  final ShapeBorder? shape;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            SectionTitle(title: 'Test title 1'),
            SizedBox(
              height: height,
              child: Card(
                // This ensures that the Card's children are clipped correctly.
                clipBehavior: Clip.antiAlias,
                shape: shape,
                child: TravelDestinationContent(destination: destination),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TappableTravelDestinationItem extends StatelessWidget {
  const TappableTravelDestinationItem({
    super.key,
    required this.destination,
    this.shape,
  });

  // This height will allow for all the Card's content to fit comfortably within the card.
  static const height = 298.0;
  final TravelDestination destination;
  final ShapeBorder? shape;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            // SectionTitle(
            //     title: 'Test title 2'),
            SizedBox(
              height: height,
              child: Card(
                // This ensures that the Card's children (including the ink splash) are clipped correctly.
                clipBehavior: Clip.antiAlias,
                shape: shape,
                child: InkWell(
                  onTap: () {},
                  // Generally, material cards use onSurface with 12% opacity for the pressed state.
                  splashColor:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
                  // Generally, material cards do not have a highlight overlay.
                  highlightColor: Colors.transparent,
                  child: TravelDestinationContent(destination: destination),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectableTravelDestinationItem extends StatelessWidget {
  const SelectableTravelDestinationItem({
    super.key,
    required this.destination,
    required this.isSelected,
    required this.onSelected,
    this.shape,
  });

  final TravelDestination destination;
  final ShapeBorder? shape;
  final bool isSelected;
  final VoidCallback onSelected;

  // This height will allow for all the Card's content to fit comfortably within the card.
  static const height = 298.0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      top: false,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            //TODO: Top title của hình grid
            // SectionTitle(
            //     title: 'Test title 3'),
            SizedBox(
              height: height,
              child: Card(
                // This ensures that the Card's children (including the ink splash) are clipped correctly.
                clipBehavior: Clip.antiAlias,
                shape: shape,
                child: InkWell(
                  onLongPress: () {
                    onSelected();
                  },
                  // Generally, material cards use onSurface with 12% opacity for the pressed state.
                  splashColor: colorScheme.onSurface.withOpacity(0.12),
                  // Generally, material cards do not have a highlight overlay.
                  highlightColor: Colors.transparent,
                  child: Stack(
                    children: [
                      Container(
                        color: isSelected
                            // Generally, material cards use primary with 8% opacity for the selected state.
                            // See: https://material.io/design/interaction/states.html#anatomy
                            ? colorScheme.primary.withOpacity(0.08)
                            : Colors.transparent,
                      ),
                      TravelDestinationContent(destination: destination),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            Icons.check_circle,
                            color: isSelected
                                ? colorScheme.primary
                                : Colors.transparent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 4, 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(title, style: Theme.of(context).textTheme.subtitle1),
      ),
    );
  }
}

class TravelDestinationContent extends StatelessWidget {
  const TravelDestinationContent({super.key, required this.destination});

  final TravelDestination destination;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleStyle = theme.textTheme.headline5!.copyWith(color: Colors.white);
    final descriptionStyle = theme.textTheme.subtitle1!;
    final priceStyle = theme.textTheme.caption!;

    return
        Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Ink.image(
                image: AssetImage(
                  destination.assetName,
                  package: destination.assetPackage,
                ),
                //TODO; Chỉnh fit hình grid sản phẩm
                fit: BoxFit.contain,
                child: Container(),
              ),
              // Image.network(
              //   'https://tech.pelmorex.com/wp-content/uploads/2020/10/flutter.png',
              //   fit: BoxFit.contain,
              // ),
            ),
            Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // This array contains the three line description on each card
                // demo.
                SizedBox(
                  height: 5,
                ),
                Text(
                  destination.title,
                  textAlign: TextAlign.center,
                ),
                Text(
                  destination.price,
                  textAlign: TextAlign.left,
                  style: priceStyle.copyWith(color: Colors.red),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 8),
                //   child: Text(
                //     destination.description,
                //     style: descriptionStyle.copyWith(color: Colors.black54),
                //   ),
                // ),
                // Text(destination.city),
                // Text(destination.location),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class CardsDemo extends StatefulWidget {
  const CardsDemo({super.key});

  @override
  State<CardsDemo> createState() => _CardsDemoState();
}

class _CardsDemoState extends State<CardsDemo> with RestorationMixin {
  final RestorableBool _isSelected = RestorableBool(false);

  @override
  String get restorationId => 'cards_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_isSelected, 'is_selected');
  }

  @override
  void dispose() {
    _isSelected.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('AppBar demoCardTitle'),
      ),
      body: Scrollbar(
        child: ListView(
          restorationId: 'cards_demo_list_view',
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
          children: [
            for (final destination in destinations)
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: (destination.cardType == CardType.standard)
                    ? TravelDestinationItem(destination: destination)
                    : destination.cardType == CardType.tappable
                        ? TappableTravelDestinationItem(
                            destination: destination)
                        : SelectableTravelDestinationItem(
                            destination: destination,
                            isSelected: _isSelected.value,
                            onSelected: () {
                              setState(() {
                                _isSelected.value = !_isSelected.value;
                              });
                            },
                          ),
              ),
          ],
        ),
      ),
    );
  }
}

// END
