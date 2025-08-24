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
  final String payMonthly;
  final String payYearly;
  final String perYearText;
  final String perMonthText;
  final String buttonName;
  const PricingPage({
    super.key,
    required this.pricesList,
    int? crossAxisCount,
    this.title = 'Pricing',
    required this.subtitle,
    this.buttonName = 'START NOW',
    this.perYearText = 'START NOW',
    this.perMonthText = 'START NOW',
    this.payMonthly = 'Pay monthly',
    this.payYearly = 'Pay yearly',
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
  final ValueNotifier<int?> loadingIndex = ValueNotifier<int?>(null);

  @override
  void dispose() {
    _timer?.cancel();
    loadingIndex.dispose();
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
          color: Colors.black.withAlpha(50), // Shadow color with opacity
          spreadRadius: 5, // How much the shadow spreads
          blurRadius: 7, // How blurry the shadow is
          offset: Offset(0, 3), // Shadow position (x, y)
        ),
      ],
    );

    final decoration =
        widget.decorationMapper?.call(defaultDecoration) ?? defaultDecoration;

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final isMobile = screenWidth < 600;
        final isTablet = screenWidth >= 600 && screenWidth < 900;

        int crossAxisCount;
        double fontSize;
        double titleFontSize;
        double priceFontSize;
        double toggleFontSize;
        double spacing;
        double aspectRatio;

        if (isMobile) {
          crossAxisCount = 1;
          fontSize = 14;
          titleFontSize = 28;
          priceFontSize = 32;
          toggleFontSize = 16;
          spacing = 16;
          aspectRatio = 1.2;
        } else if (isTablet) {
          crossAxisCount = 2;
          fontSize = 15;
          titleFontSize = 34;
          priceFontSize = 36;
          toggleFontSize = 18;
          spacing = 18;
          aspectRatio = 0.8;
        } else {
          crossAxisCount = widget.crossAxisCount;
          fontSize = 16;
          titleFontSize = 40;
          priceFontSize = 40;
          toggleFontSize = 20;
          spacing = 20;
          aspectRatio = widget.childAspectRatio;
        }

        return SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isMobile ? double.infinity : widget.width,
                minHeight: constraints.maxHeight,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 0,
                  vertical: isMobile ? 20 : 0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BabelText(
                      '<b>${widget.title}<b>',
                      style: TextStyle(fontSize: titleFontSize),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 0 : 20,
                      ),
                      child: BabelText(
                        widget.subtitle,
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.w300,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: spacing),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BabelText(
                          widget.payMonthly,
                          style: TextStyle(fontSize: toggleFontSize),
                        ),
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
                        BabelText(
                          widget.payYearly,
                          style: TextStyle(fontSize: toggleFontSize),
                        ),
                      ],
                    ),
                    SizedBox(height: spacing * 1.8),
                    Stack(
                      children: [
                        if (!isMobile)
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
                          physics: isMobile
                              ? NeverScrollableScrollPhysics()
                              : null,
                          mainAxisSpacing: spacing,
                          crossAxisSpacing: spacing * 0.8,
                          crossAxisCount: crossAxisCount,
                          childAspectRatio: aspectRatio,
                          padding: EdgeInsets.only(bottom: isMobile ? 20 : 0),
                          children: widget.pricesList.asMap().entries.map((
                            entry,
                          ) {
                            final index = entry.key;
                            final price = entry.value;
                            final tileDec =
                                price.decoration ??
                                decoration.copyWith(
                                  border: price.emphasisText != null
                                      ? Border.all(
                                          color: Theme.of(
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
                                        decoration: tileDec,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            bottom: isMobile ? 12 : 16,
                                          ),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: isMobile ? 12 : 16,
                                              ),
                                              if (price.emphasisText == null &&
                                                  !isMobile)
                                                SizedBox(height: 5),
                                              BabelText(
                                                price.title,
                                                style: TextStyle(
                                                  fontSize: isMobile ? 20 : 24,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              if (isMobile)
                                                SizedBox(
                                                  width: double.infinity,
                                                  height: 60,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      AnimatedFlipCounter(
                                                        duration: Duration(
                                                          milliseconds: 500,
                                                        ),
                                                        value: isYearly
                                                            ? (price.yearlyPrice /
                                                                      12)
                                                                  .ceil()
                                                            : price
                                                                  .monthlyPrice,
                                                        textStyle: TextStyle(
                                                          fontSize:
                                                              priceFontSize,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          height: 1,
                                                        ),
                                                      ),
                                                      Text(
                                                        isYearly
                                                            ? '${widget.perMonthText} (billed yearly)'
                                                            : widget
                                                                  .perMonthText,
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              if (!isMobile)
                                                SizedBox(
                                                  width: double.infinity,
                                                  height: 60,
                                                  child: Stack(
                                                    children: [
                                                      Align(
                                                            alignment:
                                                                Alignment(
                                                                  -0.6,
                                                                  0,
                                                                ),
                                                            child: Column(
                                                              children: [
                                                                AnimatedFlipCounter(
                                                                  duration:
                                                                      Duration(
                                                                        milliseconds:
                                                                            500,
                                                                      ),
                                                                  value:
                                                                      isYearly
                                                                      ? (price.yearlyPrice /
                                                                                12)
                                                                            .ceil()
                                                                      : price
                                                                            .monthlyPrice,
                                                                  textStyle: TextStyle(
                                                                    fontSize:
                                                                        priceFontSize,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300,
                                                                    height:
                                                                        0.85,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  widget
                                                                      .perMonthText,
                                                                  style: TextStyle(
                                                                    fontSize:
                                                                        fontSize *
                                                                        0.875,
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
                                                          .slideX(begin: 0.22),
                                                      Center(
                                                            child:
                                                                VerticalDivider(
                                                                  indent: 6,
                                                                  endIndent: 6,
                                                                  color: Colors
                                                                      .grey,
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
                                                            alignment:
                                                                Alignment(
                                                                  0.67,
                                                                  0,
                                                                ),
                                                            child: Column(
                                                              children: [
                                                                AnimatedFlipCounter(
                                                                  duration:
                                                                      Duration(
                                                                        milliseconds:
                                                                            500,
                                                                      ),
                                                                  value: price
                                                                      .yearlyPrice,
                                                                  textStyle: TextStyle(
                                                                    fontSize:
                                                                        priceFontSize,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300,
                                                                    height:
                                                                        0.85,
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  widget
                                                                      .perYearText,
                                                                  style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        fontSize *
                                                                        0.875,
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
                                              SizedBox(
                                                height: isMobile ? 8 : 12,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: isMobile ? 8 : 0,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  spacing: isMobile ? 8 : 12,
                                                  children: price.advantagesListage.map((
                                                    advantage,
                                                  ) {
                                                    return Container(
                                                      width: double.infinity,
                                                      padding: EdgeInsets.only(
                                                        left: isMobile ? 6 : 8,
                                                        top: isMobile ? 4 : 6,
                                                        bottom: isMobile
                                                            ? 4
                                                            : 6,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .tertiaryContainer,
                                                      ),
                                                      child: BabelText(
                                                        '@@ $advantage',
                                                        style: TextStyle(
                                                          fontSize: isMobile
                                                              ? 14
                                                              : fontSize,
                                                          height: 1.4,
                                                        ),
                                                        innerWidgetMapping: {
                                                          '@@':
                                                              (
                                                                context,
                                                                text,
                                                              ) => BabelWidget(
                                                                child: Icon(
                                                                  Icons
                                                                      .check_box,
                                                                  size: isMobile
                                                                      ? 18
                                                                      : 22,
                                                                ),
                                                              ),
                                                        },
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                            ],
                                          ),
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
                                                color: Theme.of(
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
                                SizedBox(height: isMobile ? 8 : 12),
                                if (price.emphasisText != null)
                                  ValueListenableBuilder<int?>(
                                    valueListenable: loadingIndex,
                                    builder: (context, currentLoadingIndex, child) {
                                      final isLoading =
                                          currentLoadingIndex == index;
                                      final isDisabled =
                                          currentLoadingIndex != null;
                                      return IgnorePointer(
                                        ignoring: isDisabled,
                                        child: FilledButton(
                                          onPressed: isLoading
                                              ? null
                                              : () async {
                                                  if (isDisabled) return;
                                                  loadingIndex.value = index;
                                                  try {
                                                    await price.onTap.call(
                                                      isYearly,
                                                    );
                                                  } finally {
                                                    loadingIndex.value = null;
                                                  }
                                                },
                                          style: FilledButton.styleFrom(
                                            fixedSize: Size.fromHeight(
                                              isMobile ? 36 : 40,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            backgroundColor: isLoading
                                                ? Colors.grey
                                                : null,
                                          ),
                                          child: isLoading
                                              ? SizedBox(
                                                  width: isMobile ? 16 : 20,
                                                  height: isMobile ? 16 : 20,
                                                  child: CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                          Color
                                                        >(
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .onPrimary,
                                                        ),
                                                  ),
                                                )
                                              : Text(
                                                  widget.buttonName,
                                                  style: TextStyle(
                                                    fontSize: isMobile
                                                        ? 14
                                                        : null,
                                                  ),
                                                ),
                                        ),
                                      );
                                    },
                                  ),
                                if (price.emphasisText == null)
                                  ValueListenableBuilder<int?>(
                                    valueListenable: loadingIndex,
                                    builder: (context, currentLoadingIndex, child) {
                                      final isLoading =
                                          currentLoadingIndex == index;
                                      final isDisabled =
                                          currentLoadingIndex != null;
                                      return OutlinedButton(
                                        onPressed: isDisabled
                                            ? null
                                            : () async {
                                                loadingIndex.value = index;
                                                try {
                                                  await price.onTap.call(
                                                    isYearly,
                                                  );
                                                } finally {
                                                  loadingIndex.value = null;
                                                }
                                              },
                                        style: OutlinedButton.styleFrom(
                                          fixedSize: Size.fromHeight(
                                            isMobile ? 36 : 40,
                                          ),
                                          backgroundColor: isLoading
                                              ? Colors.grey.withValues(
                                                  alpha: 0.3,
                                                )
                                              : tileDec.color,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          side: BorderSide(
                                            color: isLoading
                                                ? Colors.grey
                                                : Theme.of(
                                                    context,
                                                  ).colorScheme.primary,
                                            width: isMobile ? 2 : 3,
                                          ),
                                        ),
                                        child: isLoading
                                            ? SizedBox(
                                                width: isMobile ? 16 : 20,
                                                height: isMobile ? 16 : 20,
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                        Color
                                                      >(
                                                        Theme.of(
                                                          context,
                                                        ).colorScheme.primary,
                                                      ),
                                                ),
                                              )
                                            : Text(
                                                widget.buttonName,
                                                style: TextStyle(
                                                  fontSize: isMobile
                                                      ? 14
                                                      : null,
                                                ),
                                              ),
                                      );
                                    },
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
            ),
          ),
        );
      },
    );
  }
}

const _circle = Icon(
  Icons.circle,
  size: 12,
  color: Color.fromARGB(97, 191, 191, 191),
);

final _row = Row(
  mainAxisAlignment: MainAxisAlignment.center,
  spacing: 4,
  children: List.generate(50, (index) => _circle),
);
