// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'inherited.dart';
import 'provider.dart';
import 'ref.dart';

class LeafScope extends StatefulWidget {
  final Widget child;

  const LeafScope({super.key, required this.child});

  static LeafScopeState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<LeafInherited>();
    assert(scope != null, 'No LeafScope found in context');
    return scope!.state;
  }

  static LeafScopeState read(BuildContext context) {
    final element = context.getElementForInheritedWidgetOfExactType<LeafInherited>();

    final widget = element?.widget as LeafInherited?;
    assert(widget != null, 'No LeafScope found in context');

    return widget!.state;
  }

  @override
  State<LeafScope> createState() => LeafScopeState();
}

class LeafScopeState extends State<LeafScope> {
  final Map<Leaf, ChangeNotifier> _instances = {};
  final Map<Leaf, int> _listenersCount = {};

  bool exists(Leaf provider) => (_listenersCount[provider] ?? 0) > 0;

  void increment(Leaf provider) {
    _listenersCount[provider] = (_listenersCount[provider] ?? 0) + 1;
  }

  T read<T extends ChangeNotifier>(
    Leaf<T> provider,
    Ref ref,
  ) =>
      _instances.putIfAbsent(provider, () {
            final instance = provider.create(ref);
            _listenersCount[provider] = 0;
            return instance;
          })
          as T;

  void unwatch(Leaf provider) {
    final notifier = _instances[provider];
    if (notifier == null) return;

    _listenersCount[provider] = (_listenersCount[provider] ?? 1) - 1;

    if (_listenersCount[provider] == 0 && !provider.keepAlive) {
      notifier.dispose();
      _instances.remove(provider);
      _listenersCount.remove(provider);
    }
  }

  T watch<T extends ChangeNotifier>(
    Leaf<T> provider,
    VoidCallback onChange,
    Ref ref,
  ) {
    final notifier = read(provider, ref);

    _listenersCount[provider] = (_listenersCount[provider] ?? 0) + 1;

    notifier.addListener(onChange);

    return notifier;
  }

  @override
  Widget build(BuildContext context) => LeafInherited(
    state: this,
    child: widget.child,
  );
}
