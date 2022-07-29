// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.


import 'package:dong_phuc_296_web/src/data/model/product.dart';

import '../../util/strings.dart';

class ProductsRepository {
  static List<Product> loadProducts(Category category) {
    final allProducts = [
      Product(
        category: categoryAccessories,
        id: 0,
        isFeatured: true,
        name: (context) =>
            web296ProductVagabondSack,
        price: 120000,
        assetAspectRatio: 329 / 246,
      ),
      Product(
        category: categoryAccessories,
        id: 1,
        isFeatured: true,
        name: (context) =>
            web296ProductStellaSunglasses,
        price: 58000000,
        assetAspectRatio: 329 / 247,
      ),
      Product(
        category: categoryAccessories,
        id: 2,
        isFeatured: false,
        name: (context) =>
            web296ProductWhitneyBelt,
        price: 35000,
        assetAspectRatio: 329 / 228,
      ),
      Product(
        category: categoryAccessories,
        id: 3,
        isFeatured: true,
        name: (context) =>
            web296ProductGardenStrand,
        price: 98000,
        assetAspectRatio: 329 / 246,
      ),
      Product(
        category: categoryAccessories,
        id: 4,
        isFeatured: false,
        name: (context) =>
            web296ProductStrutEarrings,
        price: 34000,
        assetAspectRatio: 329 / 246,
      ),
      Product(
        category: categoryAccessories,
        id: 5,
        isFeatured: false,
        name: (context) =>
            web296ProductVarsitySocks,
        price: 12000,
        assetAspectRatio: 329 / 246,
      ),
      Product(
        category: categoryAccessories,
        id: 6,
        isFeatured: false,
        name: (context) =>
            web296ProductWeaveKeyring,
        price: 16000,
        assetAspectRatio: 329 / 246,
      ),
      Product(
        category: categoryAccessories,
        id: 7,
        isFeatured: true,
        name: (context) =>
            web296ProductGatsbyHat,
        price: 40000,
        assetAspectRatio: 329 / 246,
      ),
      Product(
        category: categoryAccessories,
        id: 8,
        isFeatured: true,
        name: (context) =>
            web296ProductShrugBag,
        price: 198000,
        assetAspectRatio: 329 / 246,
      ),
      Product(
        category: categoryHome,
        id: 9,
        isFeatured: true,
        name: (context) =>
            web296ProductGiltDeskTrio,
        price: 58000,
        assetAspectRatio: 329 / 246,
      ),
      Product(
        category: categoryHome,
        id: 10,
        isFeatured: false,
        name: (context) =>
            web296ProductCopperWireRack,
        price: 18000,
        assetAspectRatio: 329 / 246,
      ),
      Product(
        category: categoryHome,
        id: 11,
        isFeatured: false,
        name: (context) =>
            web296ProductSootheCeramicSet,
        price: 28000,
        assetAspectRatio: 329 / 247,
      ),
      Product(
        category: categoryHome,
        id: 12,
        isFeatured: false,
        name: (context) =>
            web296ProductHurrahsTeaSet,
        price: 34000,
        assetAspectRatio: 329 / 213,
      ),
      Product(
        category: categoryHome,
        id: 13,
        isFeatured: true,
        name: (context) =>
            web296ProductBlueStoneMug,
        price: 18000,
        assetAspectRatio: 329 / 246,
      ),
      Product(
        category: categoryHome,
        id: 14,
        isFeatured: true,
        name: (context) =>
            web296ProductRainwaterTray,
        price: 27000,
        assetAspectRatio: 329 / 246,
      ),
      Product(
        category: categoryHome,
        id: 15,
        isFeatured: true,
        name: (context) =>
            web296ProductChambrayNapkins,
        price: 16000,
        assetAspectRatio: 329 / 246,
      ),
      Product(
        category: categoryHome,
        id: 16,
        isFeatured: true,
        name: (context) =>
            web296ProductSucculentPlanters,
        price: 16000,
        assetAspectRatio: 329 / 246,
      ),
      Product(
        category: categoryHome,
        id: 17,
        isFeatured: false,
        name: (context) =>
            web296ProductQuartetTable,
        price: 175000,
        assetAspectRatio: 329 / 246,
      ),
      Product(
        category: categoryHome,
        id: 18,
        isFeatured: true,
        name: (context) =>
            web296ProductKitchenQuattro,
        price: 129000,
        assetAspectRatio: 329 / 246,
      ),
      Product(
        category: categoryClothing,
        id: 19,
        isFeatured: false,
        name: (context) =>
            web296ProductClaySweater,
        price: 48000,
        assetAspectRatio: 329 / 219,
      ),
      Product(
        category: categoryClothing,
        id: 20,
        isFeatured: false,
        name: (context) =>
            web296ProductSeaTunic,
        price: 45000,
        assetAspectRatio: 329 / 221,
      ),
      Product(
        category: categoryClothing,
        id: 21,
        isFeatured: false,
        name: (context) =>
            web296ProductPlasterTunic,
        price: 38000,
        assetAspectRatio: 220 / 329,
      ),
      Product(
        category: categoryClothing,
        id: 22,
        isFeatured: false,
        name: (context) =>
            web296ProductWhitePinstripeShirt,
        price: 70000,
        assetAspectRatio: 219 / 329,
      ),
      Product(
        category: categoryClothing,
        id: 23,
        isFeatured: false,
        name: (context) =>
            web296ProductChambrayShirt,
        price: 70000,
        assetAspectRatio: 329 / 221,
      ),
      Product(
        category: categoryClothing,
        id: 24,
        isFeatured: true,
        name: (context) =>
            web296ProductSeabreezeSweater,
        price: 60000,
        assetAspectRatio: 220 / 329,
      ),
      Product(
        category: categoryClothing,
        id: 25,
        isFeatured: false,
        name: (context) =>
            web296ProductGentryJacket,
        price: 178000,
        assetAspectRatio: 329 / 219,
      ),
      Product(
        category: categoryClothing,
        id: 26,
        isFeatured: false,
        name: (context) =>
            web296ProductNavyTrousers,
        price: 74000,
        assetAspectRatio: 220 / 329,
      ),
      Product(
        category: categoryClothing,
        id: 27,
        isFeatured: true,
        name: (context) =>
            web296ProductWalterHenleyWhite,
        price: 38000,
        assetAspectRatio: 219 / 329,
      ),
      Product(
        category: categoryClothing,
        id: 28,
        isFeatured: true,
        name: (context) =>
            web296ProductSurfAndPerfShirt,
        price: 48000,
        assetAspectRatio: 329 / 219,
      ),
      Product(
        category: categoryClothing,
        id: 29,
        isFeatured: true,
        name: (context) =>
            web296ProductGingerScarf,
        price: 98000,
        assetAspectRatio: 219 / 329,
      ),
      Product(
        category: categoryClothing,
        id: 30,
        isFeatured: true,
        name: (context) =>
            web296ProductRamonaCrossover,
        price: 68000,
        assetAspectRatio: 220 / 329,
      ),
      Product(
        category: categoryClothing,
        id: 31,
        isFeatured: false,
        name: (context) =>
            web296ProductChambrayShirt,
        price: 38000,
        assetAspectRatio: 329 / 223,
      ),
      Product(
        category: categoryClothing,
        id: 32,
        isFeatured: false,
        name: (context) =>
            web296ProductClassicWhiteCollar,
        price: 58000,
        assetAspectRatio: 221 / 329,
      ),
      Product(
        category: categoryClothing,
        id: 33,
        isFeatured: true,
        name: (context) =>
            web296ProductCeriseScallopTee,
        price: 42000,
        assetAspectRatio: 329 / 219,
      ),
      Product(
        category: categoryClothing,
        id: 34,
        isFeatured: false,
        name: (context) =>
            web296ProductShoulderRollsTee,
        price: 27000,
        assetAspectRatio: 220 / 329,
      ),
      Product(
        category: categoryClothing,
        id: 35,
        isFeatured: false,
        name: (context) =>
            web296ProductGreySlouchTank,
        price: 24000,
        assetAspectRatio: 222 / 329,
      ),
      Product(
        category: categoryClothing,
        id: 36,
        isFeatured: false,
        name: (context) =>
            web296ProductSunshirtDress,
        price: 58000,
        assetAspectRatio: 219 / 329,
      ),
      Product(
        category: categoryClothing,
        id: 37,
        isFeatured: true,
        name: (context) =>
            web296ProductFineLinesTee,
        price: 58000,
        assetAspectRatio: 219 / 329,
      ),
    ];
    if (category == categoryAll) {
      return allProducts;
    } else {
      return allProducts.where((p) => p.category == category).toList();
    }
  }
}
