// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'ref.dart';

class Provider<T extends ChangeNotifier> {
  final T Function(Ref) _create;
  final bool keepAlive;

  const Provider(this._create, {this.keepAlive = false});
  const Provider.keepAlive(this._create, {this.keepAlive = true});

  T create(Ref ref) => _create(ref);
}
