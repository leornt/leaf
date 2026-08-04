// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'ref.dart';

abstract class Tree extends ChangeNotifier {
  Tree(this.ref);

  final Ref ref;

  @override
  @Deprecated('Use notify instead')
  void notifyListeners() => super.notifyListeners();

  void notify([_]) {
    if (hasListeners) super.notifyListeners();
  }
}
