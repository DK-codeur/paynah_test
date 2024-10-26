import 'package:flutter/material.dart';


class CradBottomIndicator extends StatelessWidget {
  const CradBottomIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        height: 5,
        width: 80,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(15)
        ),
      ),
    );
  }
}
