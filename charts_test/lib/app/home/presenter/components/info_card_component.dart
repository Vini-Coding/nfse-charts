import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InfoCardComponent extends StatefulWidget {
  final String title;
  final String subtitle;
  final IconData? icon;
  final double width;
  final bool isSelectCard;
  final List<String> selectOptions;
  final void Function(String value) onSelect;
  const InfoCardComponent({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.width = 0.15,
    this.isSelectCard = false,
    this.selectOptions = const [],
    this.onSelect = defaultOnSelect,
  });

  static void defaultOnSelect(String value) {}

  @override
  State<InfoCardComponent> createState() => _InfoCardComponentState();
}

class _InfoCardComponentState extends State<InfoCardComponent> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      height: screenSize.height * 0.1,
      width: screenSize.width * widget.width,
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
              widget.icon,
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
                    widget.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF151515),
                    ),
                  ),
                  Text(
                    widget.subtitle,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Nunito',
                      height: 1,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF00935F),
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            Visibility(
              visible: widget.isSelectCard,
              child: PopupMenuButton(
                offset: Offset(
                  -(screenSize.width * 0.16),
                  screenSize.height * 0.08,
                ),
                icon: const FaIcon(
                  FontAwesomeIcons.chevronDown,
                  color: Color(0xFF151515),
                  size: 20,
                ),
                itemBuilder: (context) => widget.selectOptions.map((item) {
                  return PopupMenuItem(
                    value: item,
                    child: SizedBox(
                      width: screenSize.width * widget.width,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Nunito',
                          height: 1,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF00935F),
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  );
                }).toList(),
                onSelected: widget.onSelect,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
