// global_controller.dart
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class TabControllerSingleton {
  static final TabControllerSingleton _instance = TabControllerSingleton._internal();
  late final PersistentTabController controller;

  factory TabControllerSingleton() {
    return _instance;
  }

  TabControllerSingleton._internal() {
    controller = PersistentTabController(initialIndex: 0);
  }

}

