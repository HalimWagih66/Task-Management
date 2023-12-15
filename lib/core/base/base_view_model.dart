import 'package:flutter/material.dart';
import 'base_navigator.dart';

class BaseViewModel<Nav extends BaseNavigator> extends ChangeNotifier{
  late Nav navigator;
}