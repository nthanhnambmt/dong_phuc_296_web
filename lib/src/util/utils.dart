import 'dart:async';
import 'dart:convert';
import 'dart:js';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:dong_phuc_296_web/src/data/model/order_model.dart';
import 'package:dong_phuc_296_web/src/util/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../data/gallery_options.dart';
import '../layout/text_scale.dart';
import '../widgets/dialog_button_widget.dart';
import 'constants.dart';
import 'package:http/http.dart' as http;

class Utils {
  // bool isTablet = context.isTablet;
  // bool isPhone = context.isPhone;
  bool isAndroid = GetPlatform.isAndroid;
  bool isIos = GetPlatform.isIOS;
  bool isMacOs = GetPlatform.isMacOS;
  bool isWindows = GetPlatform.isWindows;
  bool isLinux = GetPlatform.isLinux;
  bool isFuchsia = GetPlatform.isFuchsia;
  bool isMobile = GetPlatform.isMobile;
  bool isWeb = GetPlatform.isWeb;
  bool isDesktop = GetPlatform.isDesktop;

  // bool isLandScape = context.isLandscape;
  // bool isPortrait = context.isPortrait;
  // double screenHeight = Get.height;
  // double screenWidth = Get.width;

  static int getProductGridItem() {
    try {
      if (GetPlatform.isMobile) {
        return 2;
      } else
        return 4;
    } catch (e) {
      //running on web
      return 3;
    }
  }

  static double desktopLoginScreenMainAreaWidth(
      {required BuildContext context}) {
    return min(
      360 * reducedTextScale(context),
      MediaQuery.of(context).size.width - 2 * horizontalPadding,
    );
  }

  static void showAlertDialog(BuildContext context, String content) {
    final theme = Theme.of(context);
    final dialogTextStyle = theme.textTheme.subtitle1!
        .copyWith(color: theme.textTheme.caption!.color);
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text(
                content,
                style: dialogTextStyle,
              ),
              // actions: [
              //   DialogButtonWidget(text: dialogCancelButton),
              //
              // ],
            ));
  }

  static void showTwoButtonDialog(
      BuildContext context, String content, VoidCallback onTap) {
    final theme = Theme.of(context);
    final dialogTextStyle = theme.textTheme.subtitle1!
        .copyWith(color: theme.textTheme.caption!.color);
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text(
                content,
                style: dialogTextStyle,
              ),
              actions: [
                DialogButtonWidget(text: dialogCancelButton),
                DialogButtonWidget(
                  text: dialogClearButton,
                  onTap: onTap,
                ),
              ],
            ));
  }

  // static int axisCount(BuildContext context) {
  //   return DeviceInfoService.isTablet(context) ? 5 : 3;
  // }
  //
  // static int gridPageSize(BuildContext context) {
  //   return DeviceInfoService.isTablet(context) ? 10 : 9;
  // }
  //
  // static int gridShimmerCount(BuildContext context) {
  //   return DeviceInfoService.isTablet(context) ? 20 : 9;
  // }

  // static String getDeviceToken() {
  //   return AppStorage().user.read(SharefKey.DEVICE_TOKEN);
  // }

  // static String formatMoney(BuildContext context, dynamic value) {
  //   // if you want to add currency symbol then
  //   // pass that in this else leave it empty.
  //   return NumberFormat.currency(decimalDigits: 0, symbol: '', locale: 'en')
  //       .format(value);
  // }

  static String formatTime(BuildContext context, int value) {
    final dur = Duration(
      minutes: value,
    );

    var seconds = dur.inSeconds;
    final days = seconds ~/ Duration.secondsPerDay;
    seconds -= days * Duration.secondsPerDay;
    final hours = seconds ~/ Duration.secondsPerHour;
    seconds -= hours * Duration.secondsPerHour;
    final minutes = seconds ~/ Duration.secondsPerMinute;
    seconds -= minutes * Duration.secondsPerMinute;

    final tokens = [];
    if (days != 0) {
      tokens.add('${days}d');
    }
    if (tokens.isNotEmpty || hours != 0) {
      tokens.add('${hours}h');
    }
    if (minutes != 0) {
      tokens.add('${minutes}m');
    }

    return tokens.join();
  }

  // static String formatTimeLong(BuildContext context, int value) {
  //   final dur = Duration(
  //     minutes: value,
  //   );
  //
  //   var seconds = dur.inSeconds;
  //   final days = seconds ~/ Duration.secondsPerDay;
  //   seconds -= days * Duration.secondsPerDay;
  //   final hours = seconds ~/ Duration.secondsPerHour;
  //   seconds -= hours * Duration.secondsPerHour;
  //   final minutes = seconds ~/ Duration.secondsPerMinute;
  //   seconds -= minutes * Duration.secondsPerMinute;
  //
  //   final tokens = [];
  //   if (days != 0) {
  //     tokens
  //         .add(context.textPluralOf('day_count', params: days, quantity: days));
  //   }
  //   if (tokens.isNotEmpty || hours != 0) {
  //     tokens.add(
  //         context.textPluralOf('hour_count', params: hours, quantity: hours) +
  //             ' ');
  //   }
  //   if (minutes != 0) {
  //     tokens.add(context.textPluralOf('min_count',
  //         params: minutes, quantity: minutes));
  //   }
  //
  //   return tokens.join();
  // }
  //
  // static String formatedSearchResultCount(BuildContext context, int count) {
  //   if (count >= 500) {
  //     return '(500 ${Translations.of(context).text('results')})';
  //   } else if (count > 1) {
  //     return '($count ${context.textOf('results')})';
  //   } else {
  //     return '($count ${context.textOf('result')})';
  //   }
  // }
  //
  // static String formatSearchFilterSelectedCount(
  //     BuildContext context, int selectedCount) {
  //   return '${context.textOf('filter')} ($selectedCount)';
  // }
  //
  // static String formatShortNumber(BuildContext context, dynamic value) {
  //   // if you want to add currency symbol then pass that
  //   // in this else leave it empty.
  //   if (value != null) {
  //     return NumberFormat.compact(locale: 'en').format(value);
  //   }
  //   return '0';
  // }
  //
  // static String formattedRecipeInfo(
  //     BuildContext context, int? viewCount, int? likeCount, int? cookedCount) {
  //   var result = '';
  //   if (viewCount != null && viewCount > 0) {
  //     result =
  //         context.textPluralOf('view', quantity: viewCount, params: viewCount);
  //     if (likeCount != null && likeCount > 0) {
  //       result +=
  //           ' | ${context.textPluralOf('like', quantity: likeCount, params: likeCount)}';
  //     }
  //     if (cookedCount != null && cookedCount > 0) {
  //       result +=
  //           ' | ${context.textPluralOf('cooked', quantity: cookedCount, params: cookedCount)}';
  //     }
  //   } else {
  //     if (likeCount != null && likeCount > 0) {
  //       result += context.textPluralOf('like',
  //           quantity: likeCount, params: likeCount);
  //       if (cookedCount != null && cookedCount > 0) {
  //         result +=
  //             ' | ${context.textPluralOf('cooked', quantity: cookedCount, params: cookedCount)}';
  //       }
  //     } else {
  //       if (cookedCount != null && cookedCount > 0) {
  //         result += context.textPluralOf('cooked',
  //             quantity: cookedCount, params: cookedCount);
  //       }
  //     }
  //   }
  //   return result;
  // }
  //
  // static String formattedRecipeInfoNew(
  //     BuildContext context, int? viewCount, int? likeCount, int? cookedCount) {
  //   var result = '';
  //   if (viewCount != null && viewCount > 0) {
  //     result = context.textPluralRecipeOf('view', context,
  //         quantity: viewCount, params: viewCount);
  //     if (likeCount != null && likeCount > 0) {
  //       result +=
  //           ' | ${context.textPluralRecipeOf('like', context, quantity: likeCount, params: likeCount)}';
  //     }
  //     if (cookedCount != null && cookedCount > 0) {
  //       result +=
  //           ' | ${context.textPluralRecipeOf('cooked', context, quantity: cookedCount, params: cookedCount)}';
  //     }
  //   } else {
  //     if (likeCount != null && likeCount > 0) {
  //       result += context.textPluralRecipeOf('like', context,
  //           quantity: likeCount, params: likeCount);
  //       if (cookedCount != null && cookedCount > 0) {
  //         result +=
  //             ' | ${context.textPluralRecipeOf('cooked', context, quantity: cookedCount, params: cookedCount)}';
  //       }
  //     } else {
  //       if (cookedCount != null && cookedCount > 0) {
  //         result += context.textPluralRecipeOf('cooked', context,
  //             quantity: cookedCount, params: cookedCount);
  //       }
  //     }
  //   }
  //   return result;
  // }
  //
  // static String generateMd5(String input) {
  //   final content =
  //       const Utf8Encoder().convert(input + dotenv.env['CHECKSUM_KEY']!);
  //   final digest = md5.convert(content);
  //   return hex.encode(digest.bytes);
  // }
  //
  // static Future<void> makePhoneCall(String? phoneNumber) async {
  //   if (await canLaunch('tel:$phoneNumber')) {
  //     await launch('tel:$phoneNumber');
  //   } else {
  //     throw 'Could not launch $phoneNumber';
  //   }
  // }
  //

  static Future<void> launchLink(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(
        url,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  //
  // static Future<void> sendSms(String message) async {
  //   if (Platform.isAndroid) {
  //     final url = 'sms:?body=$message';
  //     await launch(url);
  //   } else if (Platform.isIOS) {
  //     final url = 'sms:&body=$message';
  //     await launch(url);
  //   }
  // }
  //
  // static String roundedPrice(dynamic price) {
  //   if (price != null) {
  //     if (price >= 1000) {
  //       final finalPrice = price / 1000;
  //       final value = double.parse(
  //           '$finalPrice'.substring(0, '$finalPrice'.indexOf('.') + 1 + 1));
  //       final value2 = value.toInt();
  //       return value == value2 ? '${value2}K' : '${value}K';
  //     } else {
  //       return '${price.toInt()}';
  //     }
  //   }
  //   return '';
  // }
  //

  static Future<void> sendToEmail(String mail, String message) async {
    // final url = 'mailto:$mail?body=$message';
    final emailLaunchUri = Uri(
      scheme: 'mailto',
      path: mail,
      query: encodeQueryParameters(<String, String>{'body': message}),
    );

    await launchUrl(emailLaunchUri);
  }

  static String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  // static Future<void> shareLink(String url) async {
  //   await Share.share(url);
  // }
  //
  // static Future<BitmapDescriptor> createMarker(
  //     {required BuildContext context,
  //     String res = Res.ic_marker,
  //     Size imageSize = const Size(28, 28),
  //     String? avatar}) async {
  //   final pictureRecorder = ui.PictureRecorder();
  //   final canvas = Canvas(pictureRecorder);
  //
  //   final queryData = MediaQuery.of(context);
  //   final devicePixelRatio = queryData.devicePixelRatio;
  //   final width =
  //       45 * devicePixelRatio; // where 32 is your SVG's original width
  //   final height = 54 * devicePixelRatio;
  //   final size = Size(width, height);
  //   final oval = Rect.fromLTWH(0, 0, size.width, size.height);
  //
  //   final svgString = await DefaultAssetBundle.of(context).loadString(res);
  //   //Draws string representation of svg to DrawableRoot
  //   final svgDrawableRoot = await svg.fromSvgString(svgString, '');
  //   svgDrawableRoot
  //     ..scaleCanvasToViewBox(canvas, size)
  //     ..draw(canvas, oval);
  //
  //   canvas.save();
  //   late final image;
  //
  //   try {
  //     if (avatar != null) {
  //       final response = await http.get(Uri.tryParse(
  //         avatar,
  //       )!);
  //       image = await decodeImageFromList(response.bodyBytes);
  //     } else {
  //       image = await decodeImageFromList(
  //           await getImageFileFromAssets('images/ic_avatar.png'));
  //     }
  //   } catch (e) {
  //     image = await decodeImageFromList(
  //         await getImageFileFromAssets('images/ic_avatar.png'));
  //   }
  //
  //   canvas.clipPath(Path()
  //     ..addOval(Rect.fromLTWH(4.5, 4, imageSize.width, imageSize.height)));
  //   paintImage(
  //       canvas: canvas,
  //       image: image,
  //       rect: Rect.fromLTWH(4.5, 4, imageSize.width, imageSize.height),
  //       fit: BoxFit.fitHeight);
  //
  //   // Convert canvas to image
  //   final markerAsImage = await pictureRecorder
  //       .endRecording()
  //       .toImage(size.width.toInt(), size.height.toInt());
  //
  //   final byteData = await (markerAsImage.toByteData(
  //       format: ui.ImageByteFormat.png) as FutureOr<ByteData>);
  //   final uint8List = byteData.buffer.asUint8List();
  //   return BitmapDescriptor.fromBytes(uint8List);
  //   // Convert image to bytes
  // }
  //
  // static Future<Uint8List> getImageFileFromAssets(String path) async {
  //   final byteData = await rootBundle.load('assets/$path');
  //
  //   return byteData.buffer
  //       .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
  // }
  //
  // static String formattedPrepareTime(BuildContext context, int min) {
  //   if (min < 1440) {
  //     if (min % 60 == 0) {
  //       return '${(min / 60.0).toStringAsFixed(0)}h';
  //     } else {
  //       return '${(min / 60.0).toStringAsFixed(1)}h';
  //     }
  //   } else if (min == 1440) {
  //     return context.textPluralOf('day_count', quantity: 1, params: 1);
  //   } else {
  //     final day = min ~/ 1440;
  //     return context.textPluralOf('day_count', quantity: day, params: day);
  //   }
  // }
  //
  // static String formatAwareShippingTime(BuildContext context, int min) {
  //   final prepareTime = Duration(minutes: min);
  //   final current = DateTime.now();
  //
  //   final closeTime = DateTime(current.year, current.month, current.day, 22);
  //   final startTime = DateTime(current.year, current.month, current.day, 7);
  //
  //   final shippingTime = current.add(prepareTime).roundUp();
  //   if (prepareTime.inDays >= 1) {
  //     final nextStartTime =
  //         DateTime(current.year, current.month, current.day, 7)
  //             .add(prepareTime);
  //     return DateFormat('dd-MM 7:00').format(nextStartTime);
  //   } else {
  //     if (shippingTime.isAfter(startTime) && shippingTime.isBefore(closeTime)) {
  //       Log.i('case 1');
  //       return DateFormat('HH:mm').format(shippingTime);
  //     } else if (shippingTime.isBefore(startTime)) {
  //       Log.i('case 2');
  //       return DateFormat('dd-MM HH:mm').format(startTime.add(prepareTime));
  //     } else if (shippingTime.isAfter(closeTime) ||
  //         shippingTime.isSameDateHour(closeTime)) {
  //       Log.i('case 3');
  //       final offset = shippingTime.difference(closeTime);
  //       final nextStartTime =
  //           DateTime(current.year, current.month, current.day + 1, 7);
  //
  //       return DateFormat('dd-MM HH:mm').format(nextStartTime);
  //     }
  //   }
  //
  //   return DateFormat('HH:mm').format(shippingTime);
  // }
  //
  // static String paymentIcon(PaymentMethodModel payment) {
  //   switch (payment.id) {
  //     case Constants.PAYMENT_METHOD_CASH:
  //       return Res.ic_payment_cash;
  //     case Constants.PAYMENT_METHOD_ZALOPAY:
  //       return Res.ic_payment_zalopay;
  //     case Constants.PAYMENT_METHOD_MOMO:
  //       return Res.ic_payment_momo;
  //     case Constants.PAYMENT_METHOD_VNPAY:
  //       return Res.ic_payment_vnpay;
  //     case Constants.PAYMENT_METHOD_AIRPAY:
  //       return Res.ic_payment_airpay;
  //     case Constants.PAYMENT_METHOD_COOKY_COIN:
  //       return Res.ic_credit;
  //     default:
  //       return Res.ic_payment_cash;
  //   }
  // }
  //
  // static String formatedTimeForNotify(String inputTime, BuildContext context) {
  //   var formatedTime = '';
  //
  //   final date = DateFormat('yyyy-MM-dd HH:mm:ss').parse(inputTime);
  //   final now = DateTime.now();
  //   final dayDiff = now.difference(date).inDays;
  //   if (dayDiff == 0) {
  //     final hourDiff = now.difference(date).inHours;
  //     if (hourDiff == 0) {
  //       final minDiff = now.difference(date).inMinutes;
  //       if (minDiff == 0) {
  //         formatedTime = context.textOf('now');
  //       } else {
  //         formatedTime = context.textPluralOf('min_ago',
  //             params: minDiff, quantity: minDiff);
  //       }
  //     } else {
  //       formatedTime = context.textPluralOf('hour_ago',
  //           params: hourDiff, quantity: hourDiff);
  //     }
  //   } else {
  //     if (dayDiff > 7) {
  //       formatedTime = DateFormat('dd/MM/yyyy HH:mm').format(date);
  //     } else {
  //       formatedTime =
  //           context.textPluralOf('day_ago', params: dayDiff, quantity: dayDiff);
  //     }
  //   }
  //   return formatedTime;
  // }
  //
  // static String formatedTimeForBlog(String inputTime) {
  //   return inputTime.formatStringDateTo(
  //       DateTimeFormatEnum.SERVER_YY_MM_DD_HHMM_FORMAT,
  //       DateTimeFormatEnum.DDMMYY_FORMAT);
  // }
  //
  // static String formatedTimeForVideo(String inputTime) {
  //   return inputTime.formatStringDateTo(
  //       DateTimeFormatEnum.SERVER_YY_MM_DD_HHMM_FORMAT,
  //       DateTimeFormatEnum.DDMMYY_FORMAT);
  // }
  //
  // static Map clone(obj) {
  //   final tempObj = {};
  //   for (final key in obj.keys) {
  //     tempObj[key] = obj[key];
  //   }
  //   return tempObj;
  // }
  //
  // static double roundDouble(double value, int places) {
  //   final mod = pow(10.0, places) as double;
  //   return (value * mod).round().toDouble() / mod;
  // }
  //
  // static String roundedCount(int count) {
  //   if (count > 1000) {
  //     if(count % 1000 != 0) {
  //       return '${((count / 1000.0).toStringAsFixed(1)).replaceAll(RegExp(r'.0'), '')}K';
  //     }else{
  //       return '${count / 1000}K';
  //     }
  //   }
  //   return double.parse(count.toString()).toStringAsFixed(0);
  // }
  //
  // static double gridItemWidth(int column, double fullWidth) {
  //   return (fullWidth - 30 - (column - 1) * 10) / column;
  // }
  //
  // static double gridItemHeight(int column, double itemWidth) {
  //   return itemWidth + 8 + 15 + 6 + 48 + 32 - 20 - 6;
  // }
  //
  // static double gridRecipeHeight(int column, double itemWidth) {
  //   return itemWidth + 8 + 15 + 6 + 48 + 32 - 20 - 7 + 2 + 2 + 4;
  // }
  //
  // static double shimmerGridItemHeight(int column, double itemWidth) {
  //   return itemWidth + 8 + 15 + 6 + 48 + 32 - 20 - 7 + 2 - 40;
  // }
  //
  // static String timeFormatter(double timeInMinutes) {
  //   final duration = Duration(seconds: timeInMinutes.round());
  //
  //   return [duration.inHours, duration.inMinutes, duration.inSeconds]
  //       .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
  //       .join(':');
  // }
  //
  // static Future<dynamic> showOrderRecipeDialog(
  //     BuildContext context, OrderRecipeUnreadModel orderRecipeUnreadModel) {
  //   debugPrint('CommonLog: showOrderRecipeDialog');
  //   return Navigator.of(context).pushNamed(Constants.ORDER_RECIPE_SCREEN,
  //       arguments: orderRecipeUnreadModel);
  // }
  //
  // static String statusOrder(BuildContext context, int status) {
  //   switch (status) {
  //     case Constants.ORDER_CANCELED:
  //       {
  //         return context.textOf('text_order_status_cancelled');
  //       }
  //     case Constants.ORDER_COMPLETED:
  //       {
  //         return context.textOf('text_order_status_completed');
  //       }
  //     case Constants.ORDER_ONGOING:
  //       {
  //         return context.textOf('text_order_status_ongoing');
  //       }
  //     default:
  //       return context.textOf('text_order_status_all');
  //   }
  // }
  //
  // static void hideKeyBoard(BuildContext context) {
  //   // FocusManager.instance.primaryFocus!.unfocus();
  //   final currentFocus = FocusScope.of(context);
  //   if (!currentFocus.hasPrimaryFocus) {
  //     currentFocus.unfocus();
  //   }
  // }
  //
  // static void hideKeyBoardAndPop(BuildContext context) {
  //   hideKeyBoard(context);
  //
  //   Future.delayed(const Duration(milliseconds: 250), () {
  //     Routes.pop(context);
  //   });
  // }
  //
  // static TextStyle styleForTag(String data){
  //   if(data.contains('<b>')){
  //     return priceBoldTextStyle;
  //   }else if(data.contains('<i>')){
  //     return largeDescItalicTextStyle.apply(color: ColorStyle.dark);
  //   }else if(data.contains('<ib>')){
  //     return largeDescBoldItalicTextStyle.apply(color: ColorStyle.dark);
  //   }else{
  //     return largeDescTextStyle.apply(color: ColorStyle.dark);
  //   }
  // }

  static int numberOfLine(double width, String text) {
    // final textPainter = TextPainter();
    // final selection = TextSelection(baseOffset: 0, extentOffset: text.length);
    // final boxes = textPainter.getBoxesForSelection(selection);
    // return boxes.length;
    //final textPainter = TextPainter();
    final span = TextSpan(text: text);
    final tp = TextPainter(text: span, textDirection: ui.TextDirection.ltr);
    tp.layout(maxWidth: width);
    List<ui.LineMetrics> lines = tp.computeLineMetrics();
    return lines.length;
  }

  //send notification
  static void sendFCM(BuildContext context, List<String?> lstDeviceToken,
      OrderModel orderModel, VoidCallback? onSendSuccess) async {
    lstDeviceToken.forEach((deviceToken) async {
      if (deviceToken == null) {
        print(
            '---------------------Unable to send FCM message, no token exists.');
        return;
      }
      try {
        await http
            .post(
              Uri.parse('https://fcm.googleapis.com/fcm/send'),
              headers: <String, String>{
                'Content-Type': 'application/json',
                'Authorization': 'key=$fcm_server_key'
              },
              body: json.encode({
                'to': deviceToken,
                'message': {
                  'token': deviceToken,
                },
                "notification": {
                  "title": "Push Notification",
                  "body": "Tesst cai nao"
                },
                "data": {
                  "click_action": "FLUTTER_NOTIFICATION_CLICK",
                  "sound": "default",
                  "status": "done",
                  "screen": "screenA",
                }
              }),
            )
            .then((value) => print(value.body));
        print('--------------------------FCM request for web sent!');
        if (onSendSuccess != null) onSendSuccess();
      } catch (e) {
        print(e);
      }
    });
  }
}
