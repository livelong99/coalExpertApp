import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfilePic extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.height * 0.1,
        child: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: MediaQuery.of(context).size.height * 0.03,
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.height * 0.03,
                backgroundColor: Color(0xFFBA8C63),
              ),
              backgroundColor: Colors.transparent,
            ),
            Positioned(
              right: MediaQuery.of(context).size.height * 0.025,
              bottom: 8,
              child: SizedBox(
                  height: 40,
                  width: 40,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xFF004953)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: BorderSide(color: Colors.white)))
                    ),
                      onPressed: () {},
                      child: SvgPicture.asset("images/camera-icon.svg"))),
            )
          ],
        ),
      ),
    );
  }
}
