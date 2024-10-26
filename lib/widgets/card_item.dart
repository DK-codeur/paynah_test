import 'package:flutter/material.dart';
import 'package:paynah_test/data/model/paynah_user.dart';
import 'package:paynah_test/utils/app_const.dart';
import 'package:paynah_test/widgets/card_bottom_indicator.dart';
import 'package:velocity_x/velocity_x.dart';


class CardItem extends StatelessWidget {
  final PaynahUser? paynahUser;
  const CardItem({
    super.key, this.paynahUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      height: context.screenHeight/1.8,
      width: context.screenWidth * 0.8,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(45),
        image: const DecorationImage(
          image: AssetImage("${AppConst.imgDir}/card_background.png"),
          fit: BoxFit.cover
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Bonjour ${paynahUser?.fName},",
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
          ),
          const Text(
            "Content de vous revoir !",
            style: TextStyle(color: Colors.white60),
          ),
    
          const Spacer(),
    
          const Text(
            "Asernum SARLU",
            style: TextStyle(color: Colors.white60),
          ),
          Text(
            "${paynahUser?.email}",
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
    
          const CradBottomIndicator(),
    
          
        ],
      ),
    );
  }
}


