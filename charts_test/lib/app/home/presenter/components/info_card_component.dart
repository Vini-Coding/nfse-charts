import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InfoCardComponent extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData? icon;
  final double width;
  const InfoCardComponent({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.width =  0.15,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      height: screenSize.height * 0.1,
      width: screenSize.width * width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.015,
          vertical: screenSize.height * 0.01,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FaIcon(
              icon,
              color: const Color(0xFF151515),
              size: 30,
            ),
            SizedBox(width: screenSize.width * 0.015),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Nunito',
                      height: 1,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF00935F),
                      overflow: TextOverflow.ellipsis
                    ),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
