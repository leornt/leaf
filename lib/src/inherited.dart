// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'scope.dart';

/// Simple inherited widget used for references
class LeafInherited extends InheritedWidget {
  /// Current state
  final LeafScopeState state;

  /// Default constructor
  const LeafInherited({
    super.key,
    required this.state,
    required super.child,
  });

  @override
  bool updateShouldNotify(_) => false;
}
