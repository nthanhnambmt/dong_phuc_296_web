// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:dong_phuc_296_web/src/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/gallery_options.dart';
import '../layout/adaptive.dart';
import '../layout/image_placeholder.dart';
import '../util/constants.dart';
import '../util/strings.dart';
import '../widgets/contact_us_widget.dart';
import '../widgets/web_296_logo_widget.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);

    return ApplyTextOptions(
      child: isDesktop
          ? LayoutBuilder(
              builder: (context, constraints) => Scaffold(
                body: SafeArea(
                    child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Web296LogoWidget(),
                      SizedBox(height: 40),
                      Row(
                        children: [
                          ContactUsWidget(
                            icon: Icons.location_on,
                            iconSize: 40,
                            title: '$textAddress:',
                            content: '$address',
                          ),
                          SizedBox(width: 56),
                          ContactUsWidget(
                            icon: Icons.mail_outline,
                            iconSize: 45,
                            title: '$textEmail:',
                            content: '$email',
                          ),
                          SizedBox(width: 56),
                          ContactUsWidget(
                            icon: Icons.phone_in_talk,
                            iconSize: 40,
                            title: '$textPhone:',
                            content: '$phone',
                          ),
                        ],
                      ),
                      MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              Utils.launchLink(
                                  'https://goo.gl/maps/Q1h7gMMuKNcAXg6v6');
                            },
                            child: Container(
                              width: 584,
                              height: 416,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: ExactAssetImage(googleMapIconPath),
                                  fit: BoxFit.fill,
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              margin: isDesktop
                                  ? const EdgeInsetsDirectional.only(
                                      start: 12, end: 12, bottom: 16, top: 16)
                                  : const EdgeInsetsDirectional.only(start: 16),
                            ),
                          )),
                    ],
                  ),
                )),
              ),
            )
          : Scaffold(
              body: SafeArea(
                child: ListView(
                  restorationId: 'login_list_view',
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                  ),
                  children: [
                    SizedBox(height: 80),
                    Web296LogoWidget(),
                    SizedBox(height: 40),
                    Column(
                      children: [
                        ContactUsWidget(
                          icon: Icons.location_on,
                          iconSize: 40,
                          title: '$textAddress:',
                          content: '$address',
                        ),
                        SizedBox(height: 20),
                        ContactUsWidget(
                          icon: Icons.mail_outline,
                          iconSize: 45,
                          title: '$textEmail:',
                          content: '$email',
                        ),
                        SizedBox(height: 20),
                        ContactUsWidget(
                          icon: Icons.phone_in_talk,
                          iconSize: 40,
                          title: '$textPhone:',
                          content: '$phone',
                        ),
                      ],
                    ),
                    MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            Utils.launchLink(
                                'https://goo.gl/maps/Q1h7gMMuKNcAXg6v6');
                          },
                          child: Container(
                            width: 97,
                            height: 69,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: ExactAssetImage(googleMapIconPath),
                                fit: BoxFit.fill,
                              ),
                              borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                            ),
                            margin: isDesktop
                                ? const EdgeInsetsDirectional.only(
                                start: 12, end: 12, bottom: 16, top: 16)
                                : const EdgeInsetsDirectional.only(start: 12),
                          ),
                        )),
                  ],
                ),
              ),
            ),
    );
  }
}
