🌿 **leaf** – Minimal Flutter state management with providers, consumers, and reactive refs.

A lightweight state management solution inspired by Riverpod, designed for simplicity and maintainability. No bloated dependencies — just Flutter and Dart.

[![pub.dev](https://img.shields.io/pub/v/leaf.svg)](https://pub.dev/packages/leaf)
[![license](https://img.shields.io/github/license/leornt/leaf)](https://github.com/leornt/leaf)

[![GitHub stars](https://img.shields.io/github/stars/leornt/leaf)](https://github.com/leornt/leaf)
[![GitHub forks](https://img.shields.io/github/forks/leornt/leaf)](https://github.com/leornt/leaf)

## Features

- ✅ **Minimal dependencies** — Only Flutter and Dart. No heavy abstractions.
- ✅ **Provider/Consumer pattern** — Clear separation between state providers and UI consumers.
- ✅ **Reactive refs** — Watch providers with `ref.watch()` for automatic rebuilds.
- ✅ **Liveness tracking** — Automatic disposal of unused providers (with `keepAlive` option).
- ✅ **BlocBase integration** — Extend `BlocBase` for Riverpod-compatible BLoCs.
- ✅ **Type-safe** — Compile-time type checking for provider lookups.
- ✅ **Build-aware** — Providers are recreated in debug, kept stable in release.

## Getting started

### Prerequisites

- Flutter SDK >= 1.17.0
- Dart SDK >= 3.12.2

### Installation

Add `leaf` to your `pubspec.yaml`:

```yaml
dependencies:
  leaf: <latest_version>
```

### Basic setup

Wrap your app with `ProviderScope`:

```dart
import 'package:flutter/material.dart';
import 'package:leaf/leaf.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}
```

## Usage

### Creating providers

```dart
import 'package:leaf/leaf.dart';

class BlocCounter extends BlocBase {
  BlocCounter(super.ref);

  int counter = 0;
  void increment() {
    counter++;
    notify();
  }
}
```

### Consuming state with `ConsumerWidget`

```dart
class MyPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, Ref ref) {
    final counter = ref.watch(myProvider);

    return Column(
      children: [
        Text('Count: ${counter.count}'),
        ElevatedButton(
          onPressed: () => counter.increment(),
          child: const Text('Increment'),
        ),
      ],
    );
  }
}
```

### Consuming state with `ConsumerStatefulWidget`

```dart
class MyPage extends ConsumerStatefulWidget {
  @override
  ConsumerState createState() => _MyPageState();
}

class _MyPageState extends ConsumerState<MyPage> {
  @override
  Widget build(BuildContext context) {
    final counter = ref.watch(myProvider);

    return ElevatedButton(
      onPressed: () => counter.increment(),
      child: const Text('Increment'),
    );
  }
}
```

## Additional information

### State Management Philosophy

Leaf follows a **declarative reactive approach**:

1. **Define providers** — Create state providers with business logic
2. **Read with `ref.read()`** — Get instances lazily
3. **Watch with `ref.watch()`** — Subscribe to changes
4. **Build with `ConsumerWidget`** — Automatic rebuilds on changes

This creates a clear separation of concerns:

- **Providers**: Contain state and side effects (network, database, etc.)
- **Consumers**: Only read state, no side effects
- **Refs**: The bridge between providers and consumers

### Build-Aware Providers

Providers are recreated automatically in debug builds (recommended for hot reload), but kept stable in release builds for production performance.

## License

Apache 2.0 License — See [LICENSE](LICENSE) for details.
