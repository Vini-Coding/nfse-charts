import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GeneralTextFieldComponent extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final void Function()? onSuffixPressed;

  const GeneralTextFieldComponent({
    super.key,
    required this.textEditingController,
    required this.hintText,
    required this.onSuffixPressed,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return SizedBox(
      height: screenSize.height * 0.08,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: screenSize.height * 0.08,
            width: screenSize.width * 0.26,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            )),
            child: TextFormField(
              controller: textEditingController,
              keyboardType: TextInputType.datetime,
              style: const TextStyle(
                fontFamily: "Nunito",
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF00935F),
              ),
              decoration: InputDecoration(
                focusColor: const Color(0xFF00935F),
                hintText: hintText,
                hintStyle: const TextStyle(
                  fontFamily: "Nunito",
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF505050),
                ),
                filled: true,
                fillColor: const Color(0xFFE0E0E0),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: screenSize.height * 0.005,
            ),
            child: Container(
              height: screenSize.height * 0.0735,
              width: screenSize.width * 0.04,
              decoration: const BoxDecoration(
                color: Color(0xFF00935F),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Center(
                child: IconButton(
                  onPressed: onSuffixPressed,
                  icon: const FaIcon(
                    FontAwesomeIcons.calendarDays,
                    color: Color(0xFFEFFFFF),
                    size: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
