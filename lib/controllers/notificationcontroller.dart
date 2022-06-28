// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print, unnecessary_import, unused_import

import 'dart:typed_data';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class NotificationController extends ChangeNotifier {
  final List<CheckNotificationModel> notification = [
    CheckNotificationModel(title: 'Email'),
    CheckNotificationModel(title: 'App'),
    CheckNotificationModel(title: 'Sms'),
  ];

  final List<CheckNotificationModel> allNotification = [
    CheckNotificationModel(title: 'All'),
  ];

  isSingleCheck(int index, bool? value) {
    notification[index].value = !notification[index].value;
    allNotification.first.value =
        notification.every((element) => element.value);
    notifyListeners();
  }

  isCheckAll(bool? value) {
    allNotification.first.value = value!;
    notification.forEach((notification) => notification.value = value);
    notifyListeners();
  }

//local notification
  static final _notification = FlutterLocalNotificationsPlugin();

  static Future _notificationDetails() async {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
          'channelId',
          'channelName',
          channelDescription: '',
          importance: Importance.max,
          icon: "@mipmap/ic_launcher",
        ),
        iOS: IOSNotificationDetails());
  }

  Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notification.show(
        id,
        title,
        body,
        await _notificationDetails(),
        payload: payload,
      );

// uploading image

  XFile? file;
  Uint8List webImage = Uint8List(10);

  uploadImage() async {
    // MOBILE
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        // var selected = XFile(image.path);

        file = XFile(image.path);
        notifyListeners();
      }
    }
    // WEB
    else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();

        file = XFile(image.path);
        webImage = f;
        notifyListeners();
      }
    }
  }

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  ConnectivityResult get connectionStatus => _connectionStatus;

  bool hasInternetConnection = false;

  Future<void> updateConnectionStatus(ConnectivityResult result) async {
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      hasInternetConnection = true;
      notifyListeners();
    } else {
      hasInternetConnection = false;
      notifyListeners();
    }
    _connectionStatus = result;
    print("Internet Connection " + hasInternetConnection.toString());
    notifyListeners();
  }

  final Connectivity _connectivity = Connectivity();

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print('Couldn\'t check connectivity status' + e.toString());
      return;
    }
    updateConnectionStatus(result);
  }
}

class CheckNotificationModel {
  final String? title;
  bool value;

  CheckNotificationModel({
    required this.title,
    this.value = false,
  });
}
