// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'provider.dart';
import 'ref.dart';

/// Tree is the base class for a [Leaf]
/// But feel free to extend a [ChangeNotifier], it will also work
abstract class Tree extends ChangeNotifier {
  /// Default constructor for a Tree
  Tree(this.ref);

  /// Ref for read leafs inside a leaf (leaf inception)
  final Ref ref;

  @override
  @Deprecated('Use notify instead')
  void notifyListeners() => super.notifyListeners();

  /// [notifyListeners] with listener check
  void notify([_]) {
    if (hasListeners) super.notifyListeners();
  }
}
