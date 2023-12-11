import 'package:flutter/material.dart';
import 'package:untitled/feature/posts/presentation/pages/posts_page.dart';

import '../../main.dart';

class AppNavigator {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  Future<void> push({required Widget screen}) async {
    await navigatorKey.currentState!
        .push(MaterialPageRoute(builder: (BuildContext context) => screen));
  }

  Future<void> pushReplacement({required Widget screen}) async {
    await navigatorKey.currentState!
        .pushReplacement(MaterialPageRoute(builder: (BuildContext context) => screen));
  }

  Future pop({dynamic object}) async {
    return navigatorKey.currentState!.pop<dynamic>(object);
  }

  dynamic popUtill({required Widget screen}) {
    return navigatorKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext c) => screen), (Route route) => false);
  }

  dynamic popToFrist({dynamic object}) {
    return navigatorKey.currentState!.popUntil((Route rout) => rout.isFirst);
  }

  dynamic popToRawy({dynamic object}) {
    return navigatorKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => const PostsPage()),
            (Route<dynamic> route) => false);
  }
}