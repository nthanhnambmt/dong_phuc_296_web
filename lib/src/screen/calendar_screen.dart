// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:dongphuc296web/src/extensions/extensions.dart';
import 'package:dongphuc296web/src/util/utils.dart';
import 'package:flutter/material.dart';

import '../data/gallery_options.dart';
import '../layout/adaptive.dart';
import '../layout/image_placeholder.dart';
import '../util/strings.dart';
import '../widgets/edit_text_widget.dart';
import '../widgets/footer_widget.dart';
import '../widgets/web_296_logo_widget.dart';

const List<String> lstCalendar = <String>[
  'Lịch để bàn chữ A',
  'Lịch để bàn chữ A(có hộp + sổ ghi chú)',
  'Lịch gỗ tráng gương treo tường'
];
const List<String> lstCalendarPhotoPath = <String>[
  deBanChuA,
  deBanChuACoHop,
  goTrangGuong
];

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => CalendarScreenState();
}

class CalendarScreenState extends State<CalendarScreen> {
  String dropdownValue = lstCalendar.first;
  int dropdownIndex = 0;
  int quantity = 0;
  final quantityController = TextEditingController();
  final priceController = TextEditingController();
  final totalController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    quantityController.dispose();
    priceController.dispose();
    totalController.dispose();
    super.dispose();
  }

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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildCalculatePrice(context),
                    SizedBox(height: 60),
                    FooterWidget()
                  ],
                ),
              ))),
            )

          ///MOBILE
          : Scaffold(
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: buildCalculatePrice(context),
                      ),
                      SizedBox(height: 20),
                      FooterWidget()
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Container buildCalculatePrice(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    return Container(
        width: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text('Tính giá lịch 2023',
                style: Theme.of(context).primaryTextTheme.displaySmall),
            SizedBox(height: 20),
            buildDropdownButton(),
            SizedBox(height: 16),
            EditTextWidget(
              isReadOnly: false,
              hintText: strCalendarQuantity,
              myController: quantityController,
              onTextChange: (text) {
                if (text.valueOrEmptyString.isNotNullEmpty) {
                  quantity = int.parse(text!);
                  calculatePrice(quantity);
                }
              },
            ),
            SizedBox(height: 16),
            EditTextWidget(
              isReadOnly: true,
              hintText: strCalendarPrice,
              myController: priceController,
            ),
            SizedBox(height: 16),
            EditTextWidget(
              isReadOnly: true,
              hintText: strCalendarTotal,
              myController: totalController,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text('Liên hệ đặt hàng: '),
                InkWell(
                  child: FadeInImagePlaceholder(
                    image: AssetImage(icZalo),
                    width: isDesktop ? 40 : 45,
                    height: isDesktop ? 40 : 45,
                    placeholder: SizedBox(
                      width: isDesktop ? 40 : 45,
                      height: isDesktop ? 40 : 45,
                    ),
                  ),
                  onTap: () => {Utils.launchLink(zaLoLink)},
                ),
              ],
            ),
            SizedBox(height: 16),
            FadeInImagePlaceholder(
              image: AssetImage(lstCalendarPhotoPath[dropdownIndex]),
              placeholder: SizedBox(
                width: 100,
                height: 100,
              ),
            ),
          ],
        ));
  }

  DropdownButton<String> buildDropdownButton() {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          dropdownIndex = lstCalendar.indexOf(value);
          calculatePrice(quantity);
        });
      },
      items: lstCalendar.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  void calculatePrice(int quantity) {
    int price = 0;
    if (quantity < 50) {
      switch (dropdownIndex) {
        case 0:
          price = 120000;
          break;
        case 1:
          price = 122000;
          break;
        case 2:
          price = 160000;
          break;
      }
    } else if (quantity >= 50 && quantity < 100) {
      switch (dropdownIndex) {
        case 0:
          price = 107000;
          break;
        case 1:
          price = 109000;
          break;
        case 2:
          price = 144000;
          break;
      }
    } else if (quantity >= 100 && quantity < 200) {
      switch (dropdownIndex) {
        case 0:
          price = 87000;
          break;
        case 1:
          price = 90000;
          break;
        case 2:
          price = 101000;
          break;
      }
    } else if (quantity >= 200 && quantity < 300) {
      //+7
      switch (dropdownIndex) {
        case 0:
          price = 76000;
          break;
        case 1:
          price = 82000;
          break;
        case 2:
          price = 94000;
          break;
      }
    } else if (quantity >= 300 && quantity < 500) {
      //+6
      switch (dropdownIndex) {
        case 0:
          price = 65000;
          break;
        case 1:
          price = 76000;
          break;
        case 2:
          price = 89000;
          break;
      }
    } else if (quantity >= 500 && quantity < 700) {
      //+5
      switch (dropdownIndex) {
        case 0:
          price = 59000;
          break;
        case 1:
          price = 60000;
          break;
        case 2:
          price = 85000;
          break;
      }
    } else if (quantity >= 700 && quantity < 1000) {
      //+4
      switch (dropdownIndex) {
        case 0:
          price = 55000;
          break;
        case 1:
          price = 56000;
          break;
        case 2:
          price = 81000;
          break;
      }
    } else if (quantity >= 1000 && quantity < 2000) {
      //+3
      switch (dropdownIndex) {
        case 0:
          price = 49000;
          break;
        case 1:
          price = 51000;
          break;
        case 2:
          price = 78000;
          break;
      }
    } else if (quantity >= 2000 && quantity < 3000) {
      //+2
      switch (dropdownIndex) {
        case 0:
          price = 33000;
          break;
        case 1:
          price = 47000;
          break;
        case 2:
          price = 74000;
          break;
      }
    } else if (quantity >= 3000 && quantity < 5000) {
      //+2
      switch (dropdownIndex) {
        case 0:
          price = 27000;
          break;
        case 1:
          price = 46000;
          break;
        case 2:
          price = 72000;
          break;
      }
    } else if (quantity >= 5000 && quantity < 7000) {
      //+2
      switch (dropdownIndex) {
        case 0:
          price = 24000;
          break;
        case 1:
          price = 45000;
          break;
        case 2:
          price = 71000;
          break;
      }
    } else if (quantity >= 7000) {
      //+2
      switch (dropdownIndex) {
        case 0:
          price = 23000;
          break;
        case 1:
          price = 46000;
          break;
        case 2:
          price = 70000;
          break;
      }
    }

    setState(() {
      priceController.text = Utils.formatMoney(context, price);
      totalController.text = Utils.formatMoney(context, price * quantity);
    });
  }
}
