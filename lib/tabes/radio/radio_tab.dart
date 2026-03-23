import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:islami_app/api/api_manager.dart';
import 'package:islami_app/model/radio_response.dart';
import 'package:islami_app/model/reciter_response.dart';
import 'package:islami_app/utils/app_assets.dart';
import 'package:islami_app/utils/app_colors.dart';

class RadioTab extends StatefulWidget {
  const RadioTab({super.key});

  @override
  State<RadioTab> createState() => _RadioTabState();
}

class _RadioTabState extends State<RadioTab> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  bool isRecitersSelected = false;
  int selectedIndex = -1;
  bool isMuted = false;

  void _togglePlay(int index, String url) async {
    if (selectedIndex == index) {
      await _audioPlayer.stop();
      setState(() {
        selectedIndex = -1;
      });
    } else {
      await _audioPlayer.stop();
      await _audioPlayer.play(UrlSource(url));
      setState(() {
        selectedIndex = index;
        isMuted = false;
      });
    }
  }

  void _toggleMute() async {
    setState(() {
      isMuted = !isMuted;
    });
    await _audioPlayer.setVolume(isMuted ? 0.0 : 1.0);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.radioBg),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 70),
            _buildToggleSection(),
            const SizedBox(height: 15),
            Expanded(
              child: isRecitersSelected
                  ? _buildRecitersView()
                  : _buildRadiosView(),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 45,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          _buildTabItem("Radio", !isRecitersSelected),
          _buildTabItem("Reciters", isRecitersSelected),
        ],
      ),
    );
  }

  Widget _buildTabItem(String title, bool isSelected) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isRecitersSelected = (title == "Reciters");
            selectedIndex = -1;
          });
        },
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRadiosView() {
    return FutureBuilder<RadioResponse>(
      future: ApiManager.getRadios(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor));
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}",
              style: const TextStyle(color: Colors.white)));
        } else {
          var radios = snapshot.data?.radios ?? [];
          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 20),
            itemCount: radios.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return _buildCard(
                  radios[index].name ?? "", radios[index].url ?? "", index);
            },
          );
        }
      },
    );
  }

  Widget _buildRecitersView() {
    return FutureBuilder<ReciterResponse>(
      future: ApiManager.getReciters(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor));
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}",
              style: const TextStyle(color: Colors.white)));
        } else {
          var reciters = snapshot.data?.reciters ?? [];
          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 20),
            itemCount: reciters.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              var mosshaf = reciters[index].mosshaf?[0];
              return _buildCard(
                  reciters[index].name ?? "", mosshaf?.server ?? "", index);
            },
          );
        }
      },
    );
  }

  Widget _buildCard(String name, String url, int index) {
    bool isCurrentPlaying = selectedIndex == index;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      height: 140,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: isCurrentPlaying
                  ? const SoundWaveWidget()
                  : Opacity(
                opacity: 0.3,
                child: Image.asset(
                  AppAssets.mosque2Bg,
                  width: double.infinity,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      iconSize: 50,
                      onPressed: () => _togglePlay(index, url),
                      icon: Icon(
                        isCurrentPlaying ? Icons.pause : Icons.play_arrow,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      iconSize: 30,
                      onPressed: isCurrentPlaying ? _toggleMute : null,
                      icon: Icon(
                        (isCurrentPlaying && isMuted) ? Icons.volume_off : Icons
                            .volume_up,
                        color: Colors.black.withOpacity(
                            isCurrentPlaying ? 1.0 : 0.4),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SoundWaveWidget extends StatelessWidget {
  const SoundWaveWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(35, (index) {
          return AnimatedBar(index: index);
        }),
      ),
    );
  }
}

class AnimatedBar extends StatefulWidget {
  final int index;

  const AnimatedBar({super.key, required this.index});

  @override
  State<AnimatedBar> createState() => _AnimatedBarState();
}

class _AnimatedBarState extends State<AnimatedBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300 + ((widget.index % 5) * 100)))
      ..repeat(reverse: true);

    // Make bars have alternating height ranges for a realistic wave look
    double endHeight = (widget.index % 3 == 0) ? 70.0 : ((widget.index % 2 == 0)
        ? 40.0
        : 85.0);
    _animation = Tween<double>(begin: 10.0, end: endHeight).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: 3.5,
          height: _animation.value,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
          ),
        );
      },
    );
  }
}