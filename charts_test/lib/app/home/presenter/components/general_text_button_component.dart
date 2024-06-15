import 'package:flutter/material.dart';

class GeneralTextButtonComponent extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const GeneralTextButtonComponent({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return InkWell(
      onTap: onTap,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        height: screenSize.height * 0.08,
        width: screenSize.width * 0.3,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFF00935F),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: "Nunito",
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFFEFFFFF),
            ),
          ),
        ),
      ),
    );
  }
}
