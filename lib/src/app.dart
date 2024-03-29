// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:dongphuc296web/src/screen/admin/admin_add_product_screen.dart';
import 'package:dongphuc296web/src/screen/admin/admin_list_orders_screen.dart';
import 'package:dongphuc296web/src/screen/calendar_screen.dart';
import 'package:dongphuc296web/src/screen/contact_us_screen.dart';
import 'package:dongphuc296web/src/screen/web_mo/che_do_hoat_dong_screen.dart';
import 'package:dongphuc296web/src/screen/intro_screen.dart';
import 'package:dongphuc296web/src/screen/product_screen.dart';
import 'package:dongphuc296web/src/screen/web_mo/login_farm_screen.dart';
import 'package:dongphuc296web/src/screen/web_mo/registerr_farm_screen.dart';
import 'package:dongphuc296web/src/screen/web_mo/thong_tin_vuon_rau_screen.dart';
import 'package:dongphuc296web/src/widgets/page_status.dart';
import 'package:dongphuc296web/src/widgets/scrim.dart';
import 'package:dongphuc296web/src/widgets/layout_cache.dart';
import 'package:dongphuc296web/src/widgets/theme.dart';
import 'package:dongphuc296web/src/util/strings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:scoped_model/scoped_model.dart';

import 'data/gallery_options.dart';
import 'data/model/category_model.dart';
import 'layout/adaptive.dart';
import 'util/constants.dart';
import 'layout/backdrop.dart';
import 'widgets/category_menu_page.dart';
import 'widgets/expanding_bottom_sheet.dart';
import 'screen/home_screen.dart';
import 'screen/login_screen.dart';
import 'data/model/app_state_model.dart';
import 'data/model/product_model.dart';
import 'package:dongphuc296web/src/routing/routes.dart' as routes;

class Web296App extends StatefulWidget {
  const Web296App({super.key});

  static const String loginRoute = routes.loginRoute;
  static const String homeRoute = routes.homeRoute;
  static const String introRoute = routes.introduceRoute;
  static const String chooseSizeRoute = routes.chooseSizeRoute;
  static const String contactUsRoute = routes.contactUsRoute;
  static const String calendarRoute = routes.calendarRoute;

  //WEB MO
  static const String loginFarmRoute = routes.loginFarmRoute;
  static const String registerFarmRoute = routes.registerFarmRoute;
  static const String cheDoHoatDongRoute = routes.cheDoHoatDongRoute;
  static const String thongTinVuonRauRoute = routes.thongTinVuonRauRoute;

  //WEB ADMIN
  static const String adminCreateProductRoute = routes.createProduct;
  static const String adminListOrders = routes.orders;

  @override
  State<Web296App> createState() => _Web296AppState();
}

class _Web296AppState extends State<Web296App>
    with TickerProviderStateMixin, RestorationMixin {
  // Controller to coordinate both the opening/closing of backdrop and sliding
  // of expanding bottom sheet
  late AnimationController _controller;

  // Animation Controller for expanding/collapsing the cart menu.
  late AnimationController _expandingController;

  final _RestorableAppStateModel _model = _RestorableAppStateModel();
  final RestorableDouble _expandingTabIndex = RestorableDouble(0);
  final RestorableDouble _tabIndex = RestorableDouble(1);
  final Map<String, List<List<int>>> _layouts = {};

  @override
  String get restorationId => 'web296_app_state';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_model, 'app_state_model');
    registerForRestoration(_tabIndex, 'tab_index');
    registerForRestoration(
      _expandingTabIndex,
      'expanding_tab_index',
    );
    _controller.value = _tabIndex.value;
    _expandingController.value = _expandingTabIndex.value;
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
      value: 1,
    );
    // Save state restoration animation values only when the cart page
    // fully opens or closes.
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        _tabIndex.value = _controller.value;
      }
    });
    _expandingController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    // Save state restoration animation values only when the menu page
    // fully opens or closes.
    _expandingController.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        _expandingTabIndex.value = _expandingController.value;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _expandingController.dispose();
    _tabIndex.dispose();
    _expandingTabIndex.dispose();
    super.dispose();
  }

  Widget mobileBackdrop() {
    return Backdrop(
      // frontLayer: const ProductPage(),
      frontLayer: Container(),
      backLayer: CategoryMenuPage(onCategoryTap: () => _controller.forward()),
      frontTitle: Text(textDongPhuc296),
      backTitle: Text(textDongPhuc296),
      controller: _controller,
    );
  }

  Widget desktopBackdrop() {
    return  DesktopBackdrop(
      // frontLayer: ProductPage(),
      frontLayer: Container(),
      backLayer: CategoryMenuPage(),
    );
  }

  // Closes the bottom sheet if it is open.
  Future<bool> _onWillPop() async {
    final status = _expandingController.status;
    if (status == AnimationStatus.completed ||
        status == AnimationStatus.forward) {
      await _expandingController.reverse();
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    final backdrop = isDesktop ? desktopBackdrop() : mobileBackdrop();
    final options = GalleryOptions.of(context);

    final Widget homeScreenWidget = LayoutCache(
      layouts: _layouts,
      child: PageStatus(
        menuController: _controller,
        cartController: _expandingController,
        child:
        HomeScreen(
          backdrop: backdrop,
          scrim: Scrim(controller: _expandingController),
          expandingBottomSheet: ExpandingBottomSheet(
            hideController: _controller,
            expandingController: _expandingController,
          ),
        ),
      ),
    );

    return ModelBinding(
      initialModel: GalleryOptions(
        themeMode: ThemeMode.system,
        textScaleFactor: systemTextScaleFactorOption,
        customTextDirection: CustomTextDirection.localeBased,
        locale: vnLocales,
        timeDilation: timeDilation,
        platform: defaultTargetPlatform,
        isTestMode: false,
      ),
      child: Builder(
        builder: (context) {
          return MaterialApp(
              home: ScopedModel<AppStateModel>(
                  model: _model.value,
                  child: WillPopScope(
                    onWillPop: _onWillPop,
                    child: MaterialApp(
                      // By default on desktop, scrollbars are applied by the
                      // ScrollBehavior. This overrides that. All vertical scrollables in
                      // the gallery need to be audited before enabling this feature,
                      // see https://github.com/flutter/gallery/issues/541
                      scrollBehavior: const MaterialScrollBehavior()
                          .copyWith(scrollbars: false),
                      restorationScopeId: 'web296App',
                      title: textDongPhuc296,
                      debugShowCheckedModeBanner: false,

                      ///initRoute
                      initialRoute: Web296App.homeRoute,
                      // initialRoute: Web296App.loginFarmRoute,
                      routes: {
                        Web296App.homeRoute: (context) => homeScreenWidget,
                        Web296App.introRoute: (context) => const IntroScreen(),
                        Web296App.contactUsRoute: (context) =>
                            const ContactUsScreen(),
                        Web296App.calendarRoute: (context) =>
                            const CalendarScreen(),

                        Web296App.adminCreateProductRoute: (context) =>
                            const AdminAddProductScreen(),
                        Web296App.adminListOrders: (context) =>
                            const AdminListOrdersScreen(),
                        Web296App.cheDoHoatDongRoute: (context) =>
                            const CheDoHoatDongScreen(),
                        Web296App.thongTinVuonRauRoute: (context) =>
                            const ThongTinVuonRauScreen(),
                        Web296App.loginFarmRoute: (context) =>
                            const LoginFarmScreen(),
                        Web296App.registerFarmRoute: (context) =>
                            const RegisterFarmScreen(),
                      },
                      theme: web296Theme.copyWith(
                        platform: GetPlatform.isMobile
                            ? TargetPlatform.android
                            : TargetPlatform.windows,
                      ),
                      // L10n settings.
                      // localizationsDelegates: localizationsDelegates,
                      // supportedLocales: supportedLocales,
                      locale: vnLocales,
                    ),
                  )));
        },
      ),
    );

    // return MaterialApp(
    //     home: ScopedModel<AppStateModel>(
    //   model: _model.value,
    //   child: WillPopScope(
    //     onWillPop: _onWillPop,
    //     child: MaterialApp(
    //       // By default on desktop, scrollbars are applied by the
    //       // ScrollBehavior. This overrides that. All vertical scrollables in
    //       // the gallery need to be audited before enabling this feature,
    //       // see https://github.com/flutter/gallery/issues/541
    //       scrollBehavior:
    //           const MaterialScrollBehavior().copyWith(scrollbars: false),
    //       restorationScopeId: 'web296App',
    //       title: 'Shrine',
    //       debugShowCheckedModeBanner: false,
    //       initialRoute: ShrineApp.loginRoute,
    //       routes: {
    //         ShrineApp.loginRoute: (context) => const LoginPage(),
    //         ShrineApp.homeRoute: (context) => home,
    //       },
    //       theme: web296Theme.copyWith(
    //         platform: GetPlatform.isMobile? TargetPlatform.android: TargetPlatform.windows,
    //       ),
    //       // L10n settings.
    //       // localizationsDelegates: localizationsDelegates,
    //       // supportedLocales: supportedLocales,
    //       // locale: GalleryOptions.of(context).locale,
    //     ),
    //   ),
    // ));
  }
}

// const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
//     <LocalizationsDelegate<dynamic>>[
//   GlobalMaterialLocalizations.delegate,
//   GlobalCupertinoLocalizations.delegate,
//   GlobalWidgetsLocalizations.delegate,
// ];
//
// const List<Locale> supportedLocales = <Locale>[
//   Locale('en'),
//   Locale('vi'),
// ];

class _RestorableAppStateModel extends RestorableListenable<AppStateModel> {
  @override
  // AppStateModel createDefaultValue() => AppStateModel()..loadProducts();
  AppStateModel createDefaultValue() => AppStateModel();

  @override
  AppStateModel fromPrimitives(Object? data) {
    // final appState = AppStateModel()..loadProducts();
    final appState = AppStateModel();
    final appData = Map<String, dynamic>.from(data as Map);

    // Reset selected category.
    final categoryIndex = appData['category_index'] as int;
    appState.setCategory(categories[categoryIndex]);

    // Reset cart items.
    final cartItems = appData['cart_data'] as Map<dynamic, dynamic>;
    cartItems.forEach((dynamic id, dynamic quantity) {
      appState.addMultipleProductsToCart(id as int, quantity as int);
    });

    return appState;
  }

  @override
  Object toPrimitives() {
    return <String, dynamic>{
      'cart_data': value.productsInCart,
      'category_index': categories.indexOf(value.selectedCategory),
    };
  }
}
