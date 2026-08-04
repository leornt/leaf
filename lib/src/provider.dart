// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'ref.dart';

/// The replacement for Provider
class Leaf<T extends ChangeNotifier> {
  final T Function(Ref) _create;

  /// Keeps [Leaf] alive even without any listener
  final bool keepAlive;

  /// Gets disposed when there's no listeners
  const Leaf(this._create, {this.keepAlive = false});

  /// Does not dispose, even without any listener
  const Leaf.keepAlive(this._create, {this.keepAlive = true});

  /// Create function to use with short .new
  T create(Ref ref) => _create(ref);
}
