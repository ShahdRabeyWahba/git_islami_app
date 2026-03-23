import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:islami_app/utils/app_assets.dart';
import 'package:islami_app/utils/app_styles.dart';

class SebhaTab extends StatefulWidget {
  const SebhaTab({super.key});

  @override
  State<SebhaTab> createState() => _SebhaTabState();
}

class _SebhaTabState extends State<SebhaTab> {
  int counter = 0;
  int index = 0;
  double _currentRotation = 0;

  List<String> zikr = [
    "سبحان الله",
    "الحمدلله",
    "الله أكبر",
    "لا إله إلا الله",
    "استغفر الله"
  ];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.sebhaBg),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Text(
              "سَبِّحِ اسْمَ رَبِّكَ الأعلى",
              style: AppStyles.bold24White.copyWith(fontSize: 28),
            ).animate().fadeIn(duration: 800.ms),

            Expanded(
              child: Center(
                child: GestureDetector(
                  onTap: onSebhaClick,
                  behavior: HitTestBehavior.opaque,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Rotating & Pulsing Tasbih Body
                      Padding(
                        padding: EdgeInsets.only(top: height * 0.08),
                        child: TweenAnimationBuilder<double>(
                          tween: Tween<double>(begin: 0, end: _currentRotation),
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOutBack,
                          builder: (context, rotation, child) {
                            return Transform.rotate(
                              angle: rotation,
                              child: TweenAnimationBuilder<double>(
                                tween: Tween<double>(begin: 1.0, end: 1.0),
                                duration: const Duration(milliseconds: 100),
                                builder: (context, scale, child) {
                                  return Transform.scale(
                                    scale: scale,
                                    child: Image.asset(
                                      AppAssets.sebhaBody,
                                      height: height * 0.42,
                                      fit: BoxFit.contain,
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),

                      // Sebha Head (Group 37)
                      Positioned(
                        top: 0,
                        child: Image.asset(
                          AppAssets.sebhaHead,
                          height: height * 0.09,
                          fit: BoxFit.contain,
                        ),
                      ),

                      // Text and Counter in the middle
                      Padding(
                        padding: EdgeInsets.only(top: height * 0.08),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              zikr[index],
                              key: ValueKey(zikr[index]),
                              style: AppStyles.bold24White.copyWith(
                                  fontSize: 28),
                              textAlign: TextAlign.center,
                            ).animate().fadeIn().scale(
                                begin: const Offset(0.8, 0.8)),

                            const SizedBox(height: 10),

                            Text(
                              "$counter",
                              key: ValueKey(counter),
                              style: AppStyles.bold20White.copyWith(
                                  fontSize: 36, fontWeight: FontWeight.bold),
                            ).animate().scale(duration: 200.ms),
                          ],
                        ),
                      ),
                    ],
                  ).animate(target: counter.toDouble()).scale(
                    begin: const Offset(1.0, 1.0),
                    end: const Offset(0.95, 0.95),
                    duration: 100.ms,
                    curve: Curves.easeInOut,
                  ).then().scale(
                    begin: const Offset(1.0, 1.0),
                    end: const Offset(1.05, 1.05),
                    duration: 100.ms,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  void onSebhaClick() {
    setState(() {
      _currentRotation += (2 * 3.1415926535 / 33);
      counter++;

      if (counter > 33) {
        counter = 0;
        index = (index + 1) % zikr.length;
      }
    });
  }
}


