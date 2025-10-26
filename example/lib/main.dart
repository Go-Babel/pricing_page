import 'package:flutter/material.dart';
import 'package:pricing_page/pricing_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pricing Page Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyanAccent),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 224, 240, 255),
      body: PricingBackground(
        child: PricingPage(
          forceAllColumnsToHaveSameSizeInDesktop: false,
          width: 865,
          childAspectRatio: 0.45,
          perMonthText: 'Per month',
          perYearText: 'Per year',
          subtitle:
              "We have you covered, whether you're an unique person running\na side-project, a startup or even an enterprise company.",
          decorationMapper: (decoration) {
            return decoration.copyWith(
              color: Theme.of(context).colorScheme.onSecondary,
            );
          },
          pricesList: [
            PricesModel(
              title: 'BASICA',
              subTitle: 'FOR SIDE-PROJECTS',
              monthlyPrice: 100,
              yearlyPrice: 1050,
              advantagesListage: [
                '<b><u><tC>250.000<tC><u><b> api credits',
                '<b><u><tC>10<tC><u><b> concurrent requests',
                '<b><u><tC>3<tC><u><b> active endpoints',
              ],
              onTap: (bool isYearly) async {},
            ),
            PricesModel(
              title: 'PRO',
              subTitle: 'FOR STARTUP',
              emphasisText: 'MOST POPULAR',
              monthlyPrice: 199,
              yearlyPrice: 1999,
              advantagesListage: [
                '<b><u><tC>1.000.000<tC><u><b> api credits',
                '<b><u><tC>30<tC><u><b> concurrent requests',
                '<b><u><tC>10<tC><u><b> active endpoints',
                'Access a best AI model',
              ],
              onTap: (bool isYearly) async {},
            ),
            PricesModel(
              title: 'ULTRA',
              subTitle: 'ENTERPRISE USAGE',
              monthlyPrice: 500,
              yearlyPrice: 5500,
              advantagesListage: [
                '<b><u><tC>4.000.000<tC><u><b> api credits',
                '<b><u><tC>100<tC><u><b> concurrent requests',
                '<b><u><tC>100<tC><u><b> active endpoints',
                'Access a best AI model',
                'Priority Support',
                'Hide your endpoints from marketplace',
                'Copy endpoints from marketplace',
                'Ability to purchase one time add-on api credits',
              ],
              onTap: (bool isYearly) async {},
            ),
          ],
        ),
      ),
    );
  }
}
