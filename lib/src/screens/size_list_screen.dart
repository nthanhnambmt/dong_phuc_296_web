// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

import '../auth.dart';
import '../routing.dart';

const String _kGalleryAssetsPackage = 'flutter_gallery_assets';

class SizeListScreen extends StatefulWidget {
  const SizeListScreen({super.key});

  @override
  State<SizeListScreen> createState() => _SizeListScreenState();
}

class _SizeListScreenState extends State<SizeListScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Align(
                alignment: Alignment.topCenter, child: SizeListContent()
                // ConstrainedBox(
                //   constraints: const BoxConstraints(maxWidth: 1000),
                //   child: const Card(
                //     child: Padding(
                //       padding: EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                //       child: SizeListContent(),
                //     ),
                //   ),
                // ),
                ),
          ),
        ),
      );
}

class SizeListContent extends StatelessWidget {
  const SizeListContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(
            "destination.title",
            textAlign: TextAlign.center,
          ),
          Ink.image(
            image: AssetImage(
              'size/huong_dan_do_ao.png',
              package: _kGalleryAssetsPackage,
            ),
            fit: BoxFit.contain,
            child: Container(),
          )
        ],
      );
}
