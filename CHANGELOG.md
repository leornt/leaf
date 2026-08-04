## 0.0.2

- Rename classes and documents to keep project idea
- Hide imports
- Better score (description, public api doc, analytics)

## 0.0.1

- Initial release with minimal Flutter state management.
- Core features: Provider/Consumer pattern, reactive refs, and BlocBase.
- ProviderScope for managing provider instances and liveness tracking.
- BlocBase for Riverpod-compatible BLoCs with automatic Ref access.
- ConsumerWidget and ConsumerStatefulWidget for declarative state consumption.
- Build-aware providers (auto-recreate in debug, stable in release).
- Support for automatic disposal of unused providers or manual with `keepAlive` option.
