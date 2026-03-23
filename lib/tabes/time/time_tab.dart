import 'package:flutter/material.dart';
import 'package:islami_app/api/api_manager.dart';
import 'package:islami_app/model/pray_time_response.dart';
import 'package:islami_app/utils/app_assets.dart';
import 'package:islami_app/utils/app_colors.dart';
import 'package:islami_app/utils/app_styles.dart';

class TimeTab extends StatelessWidget {
  const TimeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          AppAssets.timeBg,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        FutureBuilder<PrayTimeResponse>(
          future: ApiManager.getPrayTime(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(
                  color: AppColors.primaryColor));
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}",
                  style: const TextStyle(color: Colors.white)));
            } else {
              var data = snapshot.data?.data;
              var timings = data?.timings;
              var date = data?.date;

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    // Gold Card
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.85),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Column(
                        children: [
                          _buildHeaderSection(date),
                          const SizedBox(height: 20),
                          _buildPrayerRow(timings),
                          const SizedBox(height: 20),
                          _buildNextPraySection(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Azkar", style: AppStyles.bold20White),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(child: _buildAzkarCard(
                              "Evening Azkar", AppAssets.commentBubbleIcon)),
                          const SizedBox(width: 15),
                          Expanded(child: _buildAzkarCard(
                              "Morning Azkar", AppAssets.bellIcon)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildHeaderSection(Date? date) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildDateText(
              "${date?.gregorian?.day ?? ""} ${date?.gregorian?.month?.en
                  ?.substring(0, 3) ?? ""},", date?.gregorian?.year ?? ""),
          Column(
            children: [
              const Text("Pray Time", style: TextStyle(color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
              Text(date?.gregorian?.weekday?.en ?? "",
                  style: AppStyles.bold24Dark.copyWith(fontSize: 20)),
            ],
          ),
          _buildDateText(
              "${date?.hijri?.day ?? ""} ${date?.hijri?.month?.en?.substring(
                  0, 3) ?? ""},", date?.hijri?.year ?? ""),
        ],
      ),
    );
  }

  Widget _buildPrayerRow(Timings? timings) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          _buildPrayerItem("Fajr", timings?.fajr ?? "", "AM", false),
          _buildPrayerItem("Sunrise", timings?.sunrise ?? "", "AM", false),
          _buildPrayerItem("Dhuhr", timings?.dhuhr ?? "", "PM", false),
          _buildPrayerItem("ASR", timings?.asr ?? "", "PM", true),
          _buildPrayerItem("Maghrib", timings?.maghrib ?? "", "PM", false),
          _buildPrayerItem("Isha", timings?.isha ?? "", "PM", false),
        ],
      ),
    );
  }

  Widget _buildNextPraySection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 40),
        Text(
          "Next Pray - 02:32",
          style: AppStyles.bold16dark.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 20),
        const Icon(Icons.volume_off, color: Colors.black87),
      ],
    );
  }

  Widget _buildDateText(String p1, String p2) {
    return Column(
      children: [
        Text(p1, style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
        Text(p2, style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
      ],
    );
  }

  Widget _buildPrayerItem(String name, String time, String period,
      bool isSelected) {
    return Container(
      width: 85,
      height: 125,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: isSelected ? Colors.black.withOpacity(0.7) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        gradient: isSelected ? null : LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white10.withOpacity(0.05),
            Colors.white24.withOpacity(0.1),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(name, style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontSize: 13,
              fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text(time, style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontSize: 20,
              fontWeight: FontWeight.bold)),
          Text(period, style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontSize: 13,
              fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildAzkarCard(String title, String imagePath) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: AppColors.primaryColor, width: 1.5),
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(imagePath, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 10),
          Text(title, style: AppStyles.bold20White.copyWith(fontSize: 18),
              textAlign: TextAlign.center),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
