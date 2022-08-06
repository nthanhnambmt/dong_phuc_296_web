import 'package:dongphuc296web/src/util/strings.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../layout/adaptive.dart';
import '../layout/image_placeholder.dart';
import '../util/colors.dart';
import '../util/utils.dart';
import 'button_widget.dart';
import 'contact_us_widget.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);

    double widthIcon = isDesktop ? 32 : 40;
    double heightIcon = isDesktop ? 32 : 40;
    double heightFooter = isDesktop ? 320 : 110;

    return Container(
        color: web296Pink50,
        // height: heightFooter,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: isDesktop
              ? buildDesktopFooter(context, widthIcon, heightIcon)
              : buildMobileFooter(context, widthIcon, heightIcon),
        ));
  }

  Row buildDesktopFooter(
      BuildContext context, double widthIcon, double heightIcon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              footerText1,
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
            ),
            SizedBox(height: 10.0),
            Text(footerText2),
            SizedBox(height: 10.0),
            buildSocialButton(widthIcon, heightIcon),
          ],
        ),
        SizedBox(width: 60.0),
        buildHotline(),
      ],
    );
  }

  Column buildMobileFooter(
      BuildContext context, double widthIcon, double heightIcon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              footerText1,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
            ),
            SizedBox(height: 20.0),
            Text(footerText2),
            SizedBox(height: 20.0),
            buildSocialButton(widthIcon, heightIcon),
          ],
        ),
        SizedBox(height: 20.0),
        buildHotlineMobile(),
      ],
    );
  }

  Column buildHotline() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            ContactUsWidget(
                icon: Icons.location_on,
                iconSize: 40,
                title: '$textAddress:',
                content: '$addressMobile',
                isClickable: false),
            SizedBox(width: 10.0),
            ButtonWidget(
                buttonText: footerTextHotLine,
                onTap: () => launchUrlString(callPhoneButton)),
          ],
        ),
        SizedBox(height: 20.0),
        Row(
          children: [
            ContactUsWidget(
                icon: Icons.location_on,
                iconSize: 40,
                title: '$textAddressHCM:',
                content: '$addressMobileHCM',
                isClickable: false),
            SizedBox(width: 35.0),
            ButtonWidget(
                buttonText: footerTextHotLineHCM,
                onTap: () => launchUrlString(callPhoneHCMButton)),
          ],
        ),
      ],
    );
  }

  Column buildHotlineMobile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ContactUsWidget(
                icon: Icons.location_on,
                iconSize: 40,
                title: '$textAddress:',
                content: '$addressMobile',
                isClickable: false),
            SizedBox(height: 10.0),
            ButtonWidget(
                buttonText: footerTextHotLine,
                onTap: () => launchUrlString(callPhoneButton)),
          ],
        ),
        SizedBox(height: 20.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ContactUsWidget(
                icon: Icons.location_on,
                iconSize: 40,
                title: '$textAddressHCM:',
                content: '$addressMobileHCM',
                isClickable: false),
            SizedBox(height: 10.0),
            ButtonWidget(
                buttonText: footerTextHotLineHCM,
                onTap: () => launchUrlString(callPhoneHCMButton)),
          ],
        ),
      ],
    );
  }

  Row buildSocialButton(double widthIcon, double heightIcon) {
    return Row(
      children: [
        InkWell(
          child: FadeInImagePlaceholder(
            image: AssetImage(icFaceBook),
            width: widthIcon,
            height: heightIcon,
            placeholder: SizedBox(
              width: widthIcon,
              height: heightIcon,
            ),
          ),
          onTap: () => {Utils.launchLink(faceBookLink)},
        ),
        SizedBox(width: 10.0),
        InkWell(
          child: FadeInImagePlaceholder(
            image: AssetImage(icZalo),
            width: widthIcon,
            height: heightIcon,
            placeholder: SizedBox(
              width: widthIcon,
              height: heightIcon,
            ),
          ),
          onTap: () => {Utils.launchLink(zaLoLink)},
        ),
        SizedBox(width: 10.0),
        InkWell(
          child: FadeInImagePlaceholder(
            image: AssetImage(icYoutube),
            width: widthIcon,
            height: heightIcon,
            placeholder: SizedBox(
              width: widthIcon,
              height: heightIcon,
            ),
          ),
          onTap: () => {Utils.launchLink(youtubeLink)},
        ),
        SizedBox(width: 10.0),
        InkWell(
          child: FadeInImagePlaceholder(
            image: AssetImage(icLazada),
            width: widthIcon,
            height: heightIcon,
            placeholder: SizedBox(
              width: widthIcon,
              height: heightIcon,
            ),
          ),
          onTap: () => {Utils.launchLink(faceBookLink)},
        ),
        SizedBox(width: 10.0),
        InkWell(
          child: FadeInImagePlaceholder(
            image: AssetImage(icShopee),
            width: widthIcon,
            height: heightIcon,
            placeholder: SizedBox(
              width: widthIcon,
              height: heightIcon,
            ),
          ),
          onTap: () => {Utils.launchLink(faceBookLink)},
        ),
      ],
      // ),
      // ],
    );
  }
}
