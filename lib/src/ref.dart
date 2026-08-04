// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'provider.dart';
import 'scope.dart';

/// Main way to access [Leaf]
class Ref {
  final List<VoidCallback> _disposers;
  final LeafScopeState _scope;
  final VoidCallback _rebuild;
  final bool Function() _isMounted;

  /// Default constructor
  Ref(this._scope, this._rebuild, this._disposers, this._isMounted);

  /// Checks if a [Leaf] exist
  ///
  /// Useful to check before watching from child screen
  bool exists<T extends ChangeNotifier>(
    Leaf<T> provider,
  ) => _scope.exists(provider);

  /// Check if this [Ref] is mounted inside a widget
  bool get mounted => _isMounted();

  /// Reads [Leaf] value
  ///
  /// Useful when getting data without listening for updates
  T read<T extends ChangeNotifier>(
    Leaf<T> provider,
  ) => _scope.read(provider, this);

  /// Adds a watcher to the [Leaf]
  ///
  /// Useful when data needs to be updated in real time
  T watch<T extends ChangeNotifier>(
    Leaf<T> provider,
  ) {
    final notifier = _scope.read(provider, this)..addListener(_rebuild);

    _disposers.add(() {
      notifier.removeListener(_rebuild);
      _scope.unwatch(provider);
    });

    _scope.increment(provider);

    return notifier;
  }
}
