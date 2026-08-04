// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'ref.dart';
import 'scope.dart';

/// Direct replacement to [StatefulWidget]
///
/// But with [Ref] support
abstract class ConsumerStatefulWidget extends StatefulWidget {
  /// Default constructor
  const ConsumerStatefulWidget({super.key});

  @override
  ConsumerState createState();
}

/// Acts just like a [State]
abstract class ConsumerState<T extends ConsumerStatefulWidget> extends State<T> {
  /// Used in constructor method
  late Ref ref;

  final List<VoidCallback> _disposers = [];
  LeafScopeState? _scope;

  void _rebuild() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();

    final scope = LeafScope.read(context);
    _scope = scope;

    ref = Ref(scope, _rebuild, _disposers, () => mounted);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final newScope = LeafScope.of(context);

    if (_scope != newScope) {
      for (final dispose in _disposers) {
        dispose();
      }
      _disposers.clear();
      _scope = newScope;
      ref = Ref(_scope!, _rebuild, _disposers, () => mounted);
    }
  }

  @override
  void dispose() {
    for (final dispose in _disposers) {
      dispose();
    }
    super.dispose();
  }
}
