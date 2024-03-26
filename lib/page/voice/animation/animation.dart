import 'package:flutter/material.dart';
import 'package:gemini_api_app/page/voice/controller.dart';
import 'package:get/get.dart';

// Import VoiceController

class CircleMovement extends StatefulWidget {
  const CircleMovement({super.key});

  @override
  _CircleMovementState createState() => _CircleMovementState();
}

class _CircleMovementState extends State<CircleMovement>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late VoiceController voiceController; // Tạo một đối tượng VoiceController

  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    voiceController = Get.find<VoiceController>(); // Khởi tạo VoiceController
  }

  @override
  Widget build(BuildContext context) {
    var sizeBigCircle = MediaQuery.of(context).size.width / 5;
    var sizeSmallCircle = 20.0;
    bool onMic = voiceController.state.waitingForSpeech.value ||
        voiceController.state.isListening.value;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AnimatedCircle(
              controller: _controller,
              isLarge: true,
              size: sizeBigCircle,
            ),
            AnimatedCircle(
              controller: _controller,
              isLarge: false,
              size: sizeBigCircle,
            ),
            AnimatedCircle(
              controller: _controller,
              isLarge: true,
              size: sizeBigCircle,
            ),
            AnimatedCircle(
              controller: _controller,
              isLarge: false,
              size: sizeBigCircle,
            ),
          ],
        ),
        Container(
          height: 150,
          width: MediaQuery.of(context).size.width / 1.1,
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.only(
            top: 16,
            right: 24,
            bottom: 16,
            left: 24,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
             //color: Colors.black,
             color: const Color.fromRGBO(0, 0, 0, 0.45), // Màu đen trong suốt 45%
          ),
          child: Obx(
            () => SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Wrap(
                children: <Widget>[
                  Row(children: [
                    Text(
                    'User: ${voiceController.wordSpoken.value}',
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  // SizedBox(width: 10),
                  if (!voiceController.state.geminiSpeech.value && onMic)
                    AnimatedCircle(
                      controller: _controller,
                      isLarge: true,
                      size: sizeSmallCircle,
                    ),
                  if (!voiceController.state.geminiSpeech.value && onMic)
                    AnimatedCircle(
                      controller: _controller,
                      isLarge: false,
                      size: sizeSmallCircle,
                    ),
                  if (!voiceController.state.geminiSpeech.value && onMic)
                    AnimatedCircle(
                      controller: _controller,
                      isLarge: true,
                      size: sizeSmallCircle,
                    ),
                  if (!voiceController.state.geminiSpeech.value && onMic)
                    AnimatedCircle(
                      controller: _controller,
                      isLarge: false,
                      size: sizeSmallCircle,
                    ),
                  ],),
                  Text(
                    '\nGemini:  ${voiceController.state.geminiText.value}',
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              if (_isAnimating) {
                _controller.stop();
                voiceController.state.waitingForSpeech.value = false;
                voiceController.stopListening();
              } else {
                _controller.repeat(reverse: true);
                voiceController.state.waitingForSpeech.value = true;
                voiceController.startListening();
              }
              _isAnimating = !_isAnimating;
            });
          },
          icon: Icon(
            onMic ? Icons.cancel : Icons.mic,
            color: onMic
                ? const Color.fromARGB(255, 204, 62, 1)
                : const Color.fromARGB(255, 0, 135, 116),   //135, 116
          ),
          iconSize: 90,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class AnimatedCircle extends StatelessWidget {

  final AnimationController controller;
  bool isLarge;
  dynamic size;
  AnimatedCircle(
      {required this.controller, required this.isLarge, required this.size});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Transform.scale(
          scale: isLarge
              ? 1.0 - (1 / 2) * controller.value
              : (1 / 2) + (1 / 2) * controller.value,
          child: Container(
            width: size,
            height: size,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
