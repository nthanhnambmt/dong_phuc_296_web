// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:dong_phuc_296_web/src/data/gallery_options.dart';
import 'package:dong_phuc_296_web/src/layout/adaptive.dart';
import 'package:dong_phuc_296_web/src/app.dart';
import 'package:dong_phuc_296_web/src/util/strings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:window_size/window_size.dart';
import 'package:dong_phuc_296_web/src/app.dart'
    deferred as web296;

import 'src/widgets/deferred_widget.dart';

// class StudyWrapper extends StatefulWidget {
//   const StudyWrapper({
//     super.key,
//     required this.study,
//     this.alignment = AlignmentDirectional.bottomStart,
//     this.hasBottomNavBar = false,
//   });
//
//   final Widget study;
//   final bool hasBottomNavBar;
//   final AlignmentDirectional alignment;
//
//   @override
//   State<StudyWrapper> createState() => _StudyWrapperState();
// }
//
// class _StudyWrapperState extends State<StudyWrapper> {
//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;
//     final textTheme = Theme.of(context).textTheme;
//     return ApplyTextOptions(
//       child: Stack(
//         children: [
//           Semantics(
//             sortKey: const OrdinalSortKey(1),
//             child: RestorationScope(
//               restorationId: 'study_wrapper',
//               child: widget.study,
//             ),
//           ),
//           if (!isDisplayFoldable(context))
//             SafeArea(
//               child: Align(
//                 alignment: widget.alignment,
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(
//                       horizontal: 16.0,
//                       vertical: widget.hasBottomNavBar
//                           ? kBottomNavigationBarHeight + 16.0
//                           : 16.0),
//                   child: Semantics(
//                     sortKey: const OrdinalSortKey(0),
//                     label: backToGallery,
//                     button: true,
//                     enabled: true,
//                     excludeSemantics: true,
//                     child: FloatingActionButton.extended(
//                       heroTag: _BackButtonHeroTag(),
//                       key: const ValueKey('Back'),
//                       onPressed: () {
//                         Navigator.of(context)
//                             .popUntil((route) => route.settings.name == '/');
//                       },
//                       icon: IconTheme(
//                         data: IconThemeData(color: colorScheme.onPrimary),
//                         child: const BackButtonIcon(),
//                       ),
//                       label: Text(
//                         MaterialLocalizations.of(context).backButtonTooltip,
//                         style: textTheme.button!
//                             .apply(color: colorScheme.onPrimary),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
//
// class _BackButtonHeroTag {}

Future<void> main() async {
  // Use package:url_strategy until this pull request is released:
  // https://github.com/flutter/flutter/pull/77103

  // Use to setHashUrlStrategy() to use "/#/" in the address bar (default). Use
  // setPathUrlStrategy() to use the path. You may need to configure your web
  // server to redirect all paths to index.html.
  //
  // On mobile platforms, both functions are no-ops.
  setHashUrlStrategy();
  // setPathUrlStrategy();

  //TODO: tạm bỏ
  // setupWindow();

  // runApp(const DongPhuc296Web());
  // runApp(const ShrineApp());
  // GoogleFonts.config.allowRuntimeFetching = false;

  runApp(new MediaQuery(
      data: new MediaQueryData(),
      child:
          // DeferredWidget(web296.loadLibrary,
          //         () => web296.ShrineApp())
          MaterialApp(
        home: DeferredWidget(web296.loadLibrary,
            () => web296.ShrineApp()), // ignore: prefer_const_constructors
      )));
}

const double windowWidth = 480;
const double windowHeight = 854;

void setupWindow() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    WidgetsFlutterBinding.ensureInitialized();
    setWindowTitle('Đồng phục 296');
    setWindowMinSize(const Size(windowWidth, windowHeight));
    setWindowMaxSize(const Size(windowWidth, windowHeight));
    getCurrentScreen().then((screen) {
      setWindowFrame(Rect.fromCenter(
        center: screen!.frame.center,
        width: windowWidth,
        height: windowHeight,
      ));
    });
  }
}
