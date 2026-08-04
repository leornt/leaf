// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'ref.dart';

class Leaf<T extends ChangeNotifier> {
  final T Function(Ref) _create;
  final bool keepAlive;

  const Leaf(this._create, {this.keepAlive = false});
  const Leaf.keepAlive(this._create, {this.keepAlive = true});

  T create(Ref ref) => _create(ref);
}
