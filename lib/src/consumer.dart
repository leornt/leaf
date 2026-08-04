// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'ref.dart';
import 'scope.dart';

abstract class ConsumerWidget extends StatefulWidget {
  const ConsumerWidget({super.key});

  Widget build(BuildContext context, Ref ref);

  @override
  State<ConsumerWidget> createState() => _ConsumerWidgetState();
}

class _ConsumerWidgetState extends State<ConsumerWidget> {
  final List<VoidCallback> _disposers = [];

  void _rebuild() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final scope = LeafScope.of(context);
    final ref = Ref(scope, _rebuild, _disposers, () => mounted);
    return widget.build(context, ref);
  }

  @override
  void dispose() {
    for (final dispose in _disposers) dispose();
    super.dispose();
  }
}
