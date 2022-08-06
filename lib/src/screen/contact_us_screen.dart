// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:dongphuc296web/src/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../data/gallery_options.dart';
import '../layout/adaptive.dart';
import '../util/constants.dart';
import '../util/strings.dart';
import '../widgets/contact_us_widget.dart';
import '../widgets/footer_widget.dart';
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
                    body: SingleChildScrollView(
                        child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            child: Web296LogoWidget(),
                            padding: const EdgeInsets.only(left: 12),
                          ),
                          SizedBox(height: 40),
                          buildContact(),
                          MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {
                                  Utils.launchLink(googleMapLink);
                                },
                                child: Container(
                                  width: 584,
                                  height: 416,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: ExactAssetImage(googleMapIconPath),
                                      fit: BoxFit.fill,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                  ),
                                  margin: isDesktop
                                      ? const EdgeInsetsDirectional.only(
                                          start: 12,
                                          end: 12,
                                          bottom: 16,
                                          top: 16)
                                      : const EdgeInsetsDirectional.only(
                                          start: 16),
                                ),
                              )),
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

  Row buildContact() {
    return Row(
      children: [
        ContactUsWidget(
            icon: Icons.location_on,
            iconSize: 40,
            title: '$textAddress:',
            content: '$address',
            isClickable: false),
        SizedBox(width: 56),
        ContactUsWidget(
            icon: Icons.mail_outline,
            iconSize: 45,
            title: '$textEmail:',
            content: '$email',
            isClickable: false),
        SizedBox(width: 56),
        ContactUsWidget(
            icon: Icons.phone_in_talk,
            iconSize: 40,
            title: '$textPhone:',
            content: '$phone',
            isClickable: true),
      ],
    );
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
