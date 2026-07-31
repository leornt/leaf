// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'inherited.dart';
import 'provider.dart';
import 'ref.dart';

class ProviderScope extends StatefulWidget {
  final Widget child;

  const ProviderScope({super.key, required this.child});

  static ProviderScopeState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<ProviderInherited>();
    assert(scope != null, 'No ProviderScope found in context');
    return scope!.state;
  }

  static ProviderScopeState read(BuildContext context) {
    final element = context.getElementForInheritedWidgetOfExactType<ProviderInherited>();

    final widget = element?.widget as ProviderInherited?;
    assert(widget != null, 'No ProviderScope found in context');

    return widget!.state;
  }

  @override
  State<ProviderScope> createState() => ProviderScopeState();
}

class ProviderScopeState extends State<ProviderScope> {
  final Map<Provider, ChangeNotifier> _instances = {};
  final Map<Provider, int> _listenersCount = {};

  bool exists(Provider provider) => (_listenersCount[provider] ?? 0) > 0;

  void increment(Provider provider) {
    _listenersCount[provider] = (_listenersCount[provider] ?? 0) + 1;
  }

  T read<T extends ChangeNotifier>(
    Provider<T> provider,
    Ref ref,
  ) =>
      _instances.putIfAbsent(provider, () {
            final instance = provider.create(ref);
            _listenersCount[provider] = 0;
            return instance;
          })
          as T;

  void unwatch(Provider provider) {
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
    Provider<T> provider,
    VoidCallback onChange,
    Ref ref,
  ) {
    final notifier = read(provider, ref);

    _listenersCount[provider] = (_listenersCount[provider] ?? 0) + 1;

    notifier.addListener(onChange);

    return notifier;
  }

  @override
  Widget build(BuildContext context) => ProviderInherited(
    state: this,
    child: widget.child,
  );
}
