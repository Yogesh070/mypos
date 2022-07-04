import 'dart:io';

import 'package:mypos/controllers/addon_controller.dart';
import 'package:mypos/controllers/category_controller.dart';
import 'package:mypos/controllers/customer_controller.dart';
import 'package:mypos/controllers/notificationcontroller.dart';
import 'package:mypos/controllers/product_controller.dart';
import 'package:mypos/controllers/settings_controller.dart';
import 'package:mypos/controllers/sidenav_controller.dart';
import 'package:mypos/controllers/ticket_controller.dart';
import 'package:mypos/model/addon.dart';
import 'package:mypos/model/bill.dart';
import 'package:mypos/model/category.dart';
import 'package:mypos/model/customer.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mypos/model/item.dart';
import 'package:mypos/model/ticket_item.dart';
import 'package:mypos/router/router.dart';
import 'package:mypos/utils/theme.dart';
import 'package:provider/provider.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(ItemAdapter());
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(AddonAdapter());
  Hive.registerAdapter(CustomerAdapter());
  Hive.registerAdapter(BillAdapter());
  Hive.registerAdapter(TicketItemAdapter());

  await Hive.openBox<ItemAdapter>('items');
  await Hive.openBox<Category>('category');
  await Hive.openBox<Addon>('addon');
  await Hive.openBox<Bill>('bill');
  await Hive.openBox<TicketItem>('ticketItem');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CustomerController(),
        ),
        ChangeNotifierProvider(
          create: (_) => SettingController(),
        ),
        ChangeNotifierProvider(
          create: (context) => SideNavController(),
        ),
        ChangeNotifierProvider(
          create: (_) => DiningNotifier(),
        ),
        ChangeNotifierProvider(
          create: (_) => NotificationController(),
        ),
        ChangeNotifierProvider(
          create: (_) => CategoryController(),
        ),
        ChangeNotifierProvider(
          create: (_) => AddonController(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductController(),
        ),
        ChangeNotifierProvider(
          create: (_) => TicketController(),
        ),
      ],
      child: MaterialApp.router(
        routerDelegate: DefaultRouter.route.routerDelegate,
        routeInformationParser: DefaultRouter.route.routeInformationParser,
        debugShowCheckedModeBanner: false,
        title: 'mypos',
        theme: MyPosTheme.defaultTheme(),
        // home: const Homepage(),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
