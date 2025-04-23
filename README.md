### ▶️ Pricing page:
A pre-made custom pricing page component. Easy for quick ui charging your customers.

## 🌟 Test the live demo!
<b>[Test the package in a online web demo:](https://go-babel.github.io/pricing_page/)</b><br>
[https://go-babel.github.io/pricing_page/](https://go-babel.github.io/pricing_page/)

[![Demo](https://github.com/Go-Babel/pricing_page/blob/main/assets/screenshot.png?raw=true)](https://go-babel.github.io/pricing_page/)

## Code implementation:

> #### 💡 Note:<p>This package have support for customizing the text style via [babel_text](https://pub.dev/packages/babel_text) package. Check documentation for macking bold text style, italic etc...
```dart
Scaffold(
  backgroundColor: const Color.fromARGB(255, 224, 240, 255),
  body: PricingBackground(
    child: PricingPage(
      width: 832,
      childAspectRatio: 0.7,
      subtitle:
          "We have you covered, whether you're an unique person running\na side-project, a startup or even an enterprise company.",
      decorationMapper: (decoration) {
        return decoration.copyWith(
          color: Theme.of(context).colorScheme.onSecondary,
        );
      },
      pricesList: [
        PricesModel(
          title: 'BASE',
          subTitle: 'SIDE-PROJECTS',
          monthlyPrice: 80,
          yearlyPrice: 850,
          advantagesListage: [
            '<b><u><tC>2<tC><u><b> projects',
            '<b><u><tC>4<tC><u><b> languages',
            '<b><u><tC>1<tC><u><b> account',
          ],
          onTap: (bool isYearly) {},
        ),
        PricesModel(
          title: 'PRO',
          subTitle: 'FOR STARTUP',
          emphasisText: 'MOST POPULAR',
          monthlyPrice: 99,
          yearlyPrice: 999,
          advantagesListage: [
            '<b><u><tC>10<tC><u><b> projects',
            '<b><u><tC>10<tC><u><b> languages',
            '<b><u><tC>5<tC><u><b> accounts',
          ],
          onTap: (bool isYearly) {},
        ),
        PricesModel(
          title: 'UNLIMITED',
          subTitle: 'ENTERPRISE',
          monthlyPrice: 250,
          yearlyPrice: 2500,
          advantagesListage: [
            '<b><u><tC>Unlimited<tC><u><b> projects',
            '<b><u><tC>Unlimited<tC><u><b> languages',
            '<b><u><tC>Unlimited<tC><u><b> accounts',
          ],
          onTap: (bool isYearly) {},
        ),
      ],
    ),
  ),
)
```