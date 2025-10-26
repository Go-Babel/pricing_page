## 1.3.0
- **Major UI/UX improvements**: Complete mobile experience refactor with beautiful, modern design
- **Fixed mobile overflow errors**: Pricing page now properly scrolls on small screens with no layout overflow
- **New desktop layout system**: Replaced fixed aspect ratio GridView with flexible Row layout
- **Added `forceAllColumnsToHaveSameSizeInDesktop` parameter**: Control whether desktop columns have equal height (default: false)
  - `false`: Cards size independently based on content (prevents overflow for varying feature counts)
  - `true`: All cards match the tallest card's height for uniform appearance
- **Enhanced mobile UI**:
  - Improved spacing and padding (40px vertical, 28px between cards)
  - Larger, more accessible buttons (48px height)
  - Better typography with refined font sizes and weights
  - Redesigned price display with dollar sign prefix
  - Modernized "MOST POPULAR" badge with pill shape and glow effect
  - Toggle switch now has background container for better visual hierarchy
  - Rounded feature containers with check_circle icons
- **Enhanced desktop UI**:
  - Fixed yearly price positioning (moved further from divider)
  - Better shadow effects (softer, more elegant)
  - Improved border radius (20px for modern look)
- **Responsive improvements**:
  - Mobile breakpoint now < 900px (better tablet support)
  - Removed tablet mode for simpler, more reliable responsive behavior
  - Content-aware layout that adapts to feature count

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