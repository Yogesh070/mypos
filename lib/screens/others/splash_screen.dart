import 'dart:async';
import 'package:mypos/controllers/notificationcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isAsycCompleted = false;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    startTime();
    super.initState();
    initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      Provider.of<NotificationController>(context, listen: false)
          .updateConnectionStatus,
    );
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      debugPrint('Couldn\'t check connectivity status' + e.toString());
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    return Provider.of<NotificationController>(context, listen: false)
        .updateConnectionStatus(result);
  }

  startTime() async {
    var _duration = const Duration(seconds: 2);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedToken = prefs.getString("u_token") ?? "";

    final router = GoRouter.of(context);

    if (savedToken.trim().isEmpty) {
      if (router.location == '/' &&
          Provider.of<NotificationController>(context, listen: false)
              .hasInternetConnection) {
        context.goNamed('signin');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No Internet Connection'),
          ),
        );
      }
    } else {
      context.goNamed('home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isAsycCompleted,
        child: SafeArea(
          child: Container(
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Image.asset(
                'assets/images/cash.png',
                height: MediaQuery.of(context).size.height / 4,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
