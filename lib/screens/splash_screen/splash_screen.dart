import 'package:flutter/material.dart';
import 'package:mapping_in_flutter/screens/map_sceen/map_screen.dart';
import 'package:mapping_in_flutter/view_model/splash_view_model.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SplashViewModel(),
      builder: (context, child) {
        return Scaffold(
          backgroundColor:  Colors.white,
          body: Consumer<SplashViewModel>(
            builder: (context, viewModel, child) {
              WidgetsBinding.instance.addPostFrameCallback(
                    (timeStamp) {
                  if (viewModel.latLong != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MapScreen(
                          latLong: viewModel.latLong!,
                        ),
                      ),
                    );
                  }
                },
              );
              return  Center(
                child: Lottie.asset('assets/lotti.htm',
                  repeat: true,
                  reverse: true,
                  animate: true,)
              );
            },
          ),
        );
      },
    );
  }
}