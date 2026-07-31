// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'provider.dart';
import 'scope.dart';

class Ref {
  final List<VoidCallback> _disposers;
  final ProviderScopeState _scope;
  final VoidCallback _rebuild;
  final bool Function() _isMounted;

  Ref(this._scope, this._rebuild, this._disposers, this._isMounted);

  bool exists<T extends ChangeNotifier>(
    Provider<T> provider,
  ) => _scope.exists(provider);

  bool get mounted => _isMounted();

  T read<T extends ChangeNotifier>(
    Provider<T> provider,
  ) => _scope.read(provider, this);

  T watch<T extends ChangeNotifier>(
    Provider<T> provider,
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
