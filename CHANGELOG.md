## 1.2.0
- **Breaking change**: Changed `onTap` callback from `void Function(bool isYearly)` to `Future<void> Function(bool isYearly)` to support async operations
- Added built-in loading state management for pricing buttons
- Buttons now display loading indicator when processing
- All buttons are disabled during loading to prevent multiple simultaneous actions
- Visual feedback includes grey background and circular progress indicator

## 1.1.0
- Dependencies update

## 1.0.0
* Initial release