// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'scope.dart';

class ProviderInherited extends InheritedWidget {
  final ProviderScopeState state;

  const ProviderInherited({
    super.key,
    required this.state,
    required super.child,
  });

  @override
  bool updateShouldNotify(_) => false;
}
