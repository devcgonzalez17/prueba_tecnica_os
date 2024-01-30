// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io'; //InternetAddress utility
import 'dart:async'; //For StreamController/Stream

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConnectionStatusSingleton {
  //This creates the single instance by calling the `_internal` constructor specified below
  static final ConnectionStatusSingleton _singleton =
      ConnectionStatusSingleton._internal();

  ConnectionStatusSingleton._internal();

  factory ConnectionStatusSingleton() {
    return _singleton;
  }

  //This is how we'll allow subscribing to connection changes
  StreamController connectionChangeController = StreamController.broadcast();

  StreamController notificationCountController = StreamController.broadcast();

  //flutter_connectivity
  final Connectivity _connectivity = Connectivity();

  bool hasConnection = false;

  //Hook into flutter_connectivity's Stream to listen for changes
  //And check the connection status out of the gate
  void initialize() {
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    checkConnection();
  }

  Stream get connectionChange => connectionChangeController.stream;

  Stream get bildirimSayisiChange => notificationCountController.stream;

  //A clean up method to close our StreamController
  //   Because this is meant to exist through the entire application life cycle this isn't
  //   really an issue
  void dispose() {
    connectionChangeController.close();
    notificationCountController.close();
  }

  void _connectionChange(ConnectivityResult result) async {
    print("_connectivity connection changed: $result");
    //if ConnectivityResult.none, there's no need to "check"
    if (result != ConnectivityResult.none) {
      await checkConnection();
    } else {
      hasConnection = false;
    }
  }

  //The test to actually see if there is a connection
  Future<bool> checkConnection() async {
    bool previousConnection = hasConnection;

    late ConnectivityResult result;

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
      print("result -:");
      print(result);
    } on PlatformException catch (e) {
      print('Couldn\'t check connectivity status' +
          'Error:' +
          e.message.toString());
      hasConnection = false;
    }

    //The connection status changed send out an update to all listeners
    if (previousConnection != hasConnection) {
      connectionChangeController.add(hasConnection);
    }
    print("Am I Online? --->  $hasConnection");
    return hasConnection;
  }
}

final connectionStatus = ConnectionStatusSingleton();
