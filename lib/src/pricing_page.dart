import 'dart:async';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:babel_text/babel_text.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pricing_page/src/prices_model.dart';

class PricingPage extends StatefulWidget {
  final int crossAxisCount;
  final double width;
  final BoxDecoration Function(BoxDecoration decoration)? decorationMapper;
  final List<PricesModel> pricesList;
  final double childAspectRatio;
  final String title;
  final String subtitle;
  const PricingPage({
    super.key,
    required this.pricesList,
    int? crossAxisCount,
    this.title = 'Pricing',
    required this.subtitle,
    this.decorationMapper,
    this.childAspectRatio = 1,
    this.width = double.infinity,
  }) : crossAxisCount = crossAxisCount ?? pricesList.length;

  @override
  State<PricingPage> createState() => _PricingPageState();
}

class _PricingPageState extends State<PricingPage> {
  bool isYearly = false;
  bool didSwitchAnimation = false;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    final defaultDecoration = BoxDecoration(
      color: Theme.of(context).colorScheme.primaryContainer,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2), // Shadow color with opacity
          spreadRadius: 5, // How much the shadow spreads
          blurRadius: 7, // How blurry the shadow is
          offset: Offset(0, 3), // Shadow position (x, y)
        ),
      ],
    );

    final decoration =
        widget.decorationMapper?.call(defaultDecoration) ?? defaultDecoration;
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: widget.width),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BabelText('<b>${widget.title}<b>', style: TextStyle(fontSize: 40)),
            BabelText(
              widget.subtitle,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: Theme.of(context).colorScheme.outline,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BabelText('Pay monthly', style: TextStyle(fontSize: 20)),
                Switch(
                  value: isYearly,
                  onChanged: (value) {
                    setState(() {
                      isYearly = value;
                    });
                    _timer?.cancel();
                    _timer = Timer(Duration(milliseconds: 700), () {
                      setState(() {
                        didSwitchAnimation = !didSwitchAnimation;
                      });
                    });
                  },
                ),
                BabelText('Pay yearly', style: TextStyle(fontSize: 20)),
              ],
            ),
            SizedBox(height: 36),
            Stack(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 300),
                    child: Transform.scale(
                      scale: 1.14,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 4,
                        children: List.generate(8, (index) => _row),
                      ),
                    ),
                  ),
                ),
                GridView.count(
                  shrinkWrap: true,
                  // cacheExtent: 100,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 16,
                  crossAxisCount: 3,
                  childAspectRatio: widget.childAspectRatio,
                  children:
                      widget.pricesList.map((PricesModel price) {
                        final tileDec =
                            price.decoration ??
                            decoration.copyWith(
                              border:
                                  price.emphasisText != null
                                      ? Border.all(
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                        width: 5,
                                      )
                                      : null,
                            );
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  Container(
                                    // height: widget.height,
                                    decoration: tileDec,
                                    child: Column(
                                      children: [
                                        SizedBox(height: 16),
                                        if (price.emphasisText == null)
                                          SizedBox(height: 5),
                                        BabelText(
                                          price.title,
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 60,
                                          child: Stack(
                                            children: [
                                              Align(
                                                    alignment: Alignment(
                                                      -0.6,
                                                      0,
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        AnimatedFlipCounter(
                                                          duration: Duration(
                                                            milliseconds: 500,
                                                          ),
                                                          value:
                                                              isYearly
                                                                  ? (price.yearlyPrice /
                                                                          12)
                                                                      .ceil()
                                                                  : price
                                                                      .monthlyPrice,
                                                          textStyle: TextStyle(
                                                            fontSize: 40,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            height: 0.85,
                                                          ),
                                                        ),
                                                        Text('/ MONTH'),
                                                      ],
                                                    ),
                                                  )
                                                  .animate(
                                                    target:
                                                        didSwitchAnimation
                                                            ? 1
                                                            : 0,
                                                  )
                                                  .slideX(begin: 0.22),
                                              Center(
                                                    child: VerticalDivider(
                                                      indent: 6,
                                                      endIndent: 6,
                                                      color: Colors.grey,
                                                    ),
                                                  )
                                                  .animate(
                                                    target:
                                                        didSwitchAnimation
                                                            ? 1
                                                            : 0,
                                                  )
                                                  .fadeIn(),
                                              Align(
                                                    alignment: Alignment(
                                                      0.67,
                                                      0,
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        AnimatedFlipCounter(
                                                          duration: Duration(
                                                            milliseconds: 500,
                                                          ),
                                                          value:
                                                              price.yearlyPrice,
                                                          textStyle: TextStyle(
                                                            fontSize: 40,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            height: 0.85,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        Text(
                                                          '/ PER YEAR',
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                  .animate(
                                                    target:
                                                        didSwitchAnimation
                                                            ? 1
                                                            : 0,
                                                  )
                                                  .fadeIn(),
                                            ],
                                          ),
                                        ),
                                        // BabelText(
                                        //   isYearly ? '/ YEAR' : '/ MONTH',
                                        //   baseTextStyle: TextStyle(),
                                        // ),
                                        // Text(price.monthlyPrice),
                                        // Text(price.yearlyPrice),
                                        SizedBox(height: 12),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          spacing: 12,
                                          children:
                                              price.advantagesListage.map((
                                                advantage,
                                              ) {
                                                return Container(
                                                  width: double.infinity,
                                                  // margin: EdgeInsets.symmetric(
                                                  //   horizontal: 12,
                                                  // ),
                                                  padding: EdgeInsets.only(
                                                    left: 8,
                                                    top: 6,
                                                    bottom: 6,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    // borderRadius:
                                                    //     BorderRadius.circular(8),
                                                    color:
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .tertiaryContainer,
                                                  ),
                                                  child: BabelText(
                                                    '@@ $advantage',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      height: 1.4,
                                                    ),
                                                    innerWidgetMapping: {
                                                      '@@':
                                                          (context, text) =>
                                                              Icon(
                                                                Icons.check_box,
                                                                size: 22,
                                                              ),
                                                    },
                                                  ),
                                                );
                                              }).toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (price.emphasisText != null)
                                    Align(
                                      alignment: Alignment(0, -1.1),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(14),
                                          ),
                                          color: tileDec.color,
                                          border: Border.all(
                                            width: 5,
                                            color:
                                                Theme.of(
                                                  context,
                                                ).colorScheme.primary,
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 7,
                                          vertical: 1,
                                        ),
                                        child: Text(price.emphasisText!),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            SizedBox(height: 12),
                            if (price.emphasisText != null)
                              FilledButton(
                                onPressed: () => price.onTap.call(isYearly),
                                style: FilledButton.styleFrom(
                                  fixedSize: Size.fromHeight(40),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text('START NOW'),
                              ),
                            if (price.emphasisText == null)
                              OutlinedButton(
                                onPressed: () => price.onTap.call(isYearly),
                                style: OutlinedButton.styleFrom(
                                  fixedSize: Size.fromHeight(40),
                                  backgroundColor: tileDec.color,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  side: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 3,
                                  ),
                                ),
                                child: Text('START NOW'),
                              ),
                          ],
                        );
                      }).toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

final _row = Row(
  mainAxisAlignment: MainAxisAlignment.center,
  spacing: 4,
  children: List.generate(50, (index) => _circle),
);
const _circle = Icon(
  Icons.circle,
  size: 12,
  color: Color.fromARGB(97, 191, 191, 191),
);
