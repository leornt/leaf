// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'ref.dart';
import 'scope.dart';

abstract class ConsumerStatefulWidget extends StatefulWidget {
  const ConsumerStatefulWidget({super.key});

  @override
  ConsumerState createState();
}

abstract class ConsumerState<T extends ConsumerStatefulWidget> extends State<T> {
  late Ref ref;

  final List<VoidCallback> _disposers = [];
  ProviderScopeState? _scope;

  void _rebuild() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();

    final scope = ProviderScope.read(context);
    _scope = scope;

    ref = Ref(scope, _rebuild, _disposers, () => mounted);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final newScope = ProviderScope.of(context);

    if (_scope != newScope) {
      for (final dispose in _disposers) dispose();
      _disposers.clear();
      _scope = newScope;
      ref = Ref(_scope!, _rebuild, _disposers, () => mounted);
    }
  }

  @override
  void dispose() {
    for (final dispose in _disposers) dispose();
    super.dispose();
  }
}
