import 'package:app/const/colors.const.dart';
import 'package:app/const/route.const.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessScreen extends StatelessWidget {
  final ConfettiController _confettiController =
      ConfettiController(duration: const Duration(seconds: 5));

  SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _confettiController.play();
    return Scaffold(
      backgroundColor: kPrimary,
      body: WillPopScope(
        onWillPop: () async => false,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ConfettiWidget(
                confettiController: _confettiController,
                blastDirection: -1.0,
                particleDrag: 0.01,
                emissionFrequency: 0.01,
                numberOfParticles: 20,
                gravity: 0.5,
                shouldLoop: false,
                blastDirectionality: BlastDirectionality.explosive,
                colors: const [
                  Colors.yellow,
                  Colors.pink,
                  Colors.deepPurpleAccent,
                ],
              ),
              const Spacer(),
              const Text(
                'SUCCESSFUL!',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const Text(
                'The room is now assigned to the customer.',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 50,
                width: double.infinity, // Make the button full-width
                child: TextButton(
                  onPressed: () {
                    Get.toNamed(MobileRoute.customerBookings);
                  },
                  child: Text(
                    "Go Back".toUpperCase(),
                    style: TextStyle(
                      color: kLight.withOpacity(0.5),
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
