// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'scope.dart';

class LeafInherited extends InheritedWidget {
  final LeafScopeState state;

  const LeafInherited({
    super.key,
    required this.state,
    required super.child,
  });

  @override
  bool updateShouldNotify(_) => false;
}
