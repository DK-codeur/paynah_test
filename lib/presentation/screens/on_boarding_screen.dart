import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paynah_test/presentation/screens/auth/auth_screen.dart';
import 'package:paynah_test/utils/app_const.dart';
import 'package:paynah_test/widgets/app_button.dart';
import 'package:velocity_x/velocity_x.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: context.screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            50.heightBox,
            Image.asset(
              "${AppConst.imgDir}/on_bord_img.png",
              width: 230,
            ),

            const Text(
              "Un compte pour \ngérer sereinement \nvotre argent",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600, height: 1.2),
            ),

            Column(
              children: [
                AppButton(
                  title: "Ouvrir un compte",
                  isElevated: false,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AuthScreen(initialPage: 1,),)),
                ),

                AppButton(
                  title: "Se connecter",
                  textColor: Colors.black,
                  bgColor: Colors.white,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AuthScreen(),)),
                ),


                AppButton(
                  title: "Decouvrir l'application",
                  icon: SvgPicture.asset("${AppConst.imgDir}/compass.svg", width: 18,),
                  textColor: Colors.black,
                  bgColor: Colors.white,
                  isElevated: false,
                  useBorder: false,
                  onTap: () {},
                )
              ],
            ),

            
          ],
        ),
      ),
    );
  }
}
