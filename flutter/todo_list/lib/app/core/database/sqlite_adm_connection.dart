
import 'package:flutter/material.dart';
import 'package:todo_list/app/core/database/sqlite_connection_factory.dart';

class SqliteAdmConnection  with WidgetsBindingObserver{
  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final connection = SqliteConnectionFactory();
    switch(state){
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.hidden:
        break;
      case AppLifecycleState.inactive:
        connection.closeConnection();
        break;
      case AppLifecycleState.paused:
        connection.closeConnection();
        break;
      case AppLifecycleState.detached:
        connection.closeConnection();
        break;
    }
    super.didChangeAppLifecycleState(state);
  }
}