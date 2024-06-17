import 'package:charts_test/app/home/presenter/components/general_text_button_component.dart';
import 'package:charts_test/app/home/presenter/components/general_text_field_component.dart';
import 'package:charts_test/app/home/presenter/store/home_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

Future<void> showCustomDateFilterDialog(
  BuildContext context,
  HomeStore store,
) async {
  return showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      final Size screenSize = MediaQuery.of(dialogContext).size;
      final formKey = GlobalKey<FormState>();

      final MaskedTextController dataInicialTextController =
          MaskedTextController(mask: '00/00/0000');
      final MaskedTextController dataFinalTextController =
          MaskedTextController(mask: '00/00/0000');

      DateTime? convertStringToDate(String dateString) {
        final DateFormat formatter = DateFormat('dd/MM/yyyy');
        return formatter.tryParse(dateString);
      }

      String? validate() {
        if (dataInicialTextController.text.isEmpty ||
            convertStringToDate(dataInicialTextController.text) == null) {
          return "Falha na operação, insira uma data inicial válida!";
        } else if (dataFinalTextController.text.isEmpty ||
            convertStringToDate(dataFinalTextController.text) == null) {
          return "Falha na operação, insira uma data final válida!";
        } else if (convertStringToDate(dataInicialTextController.text)!
            .isAfter(convertStringToDate(dataFinalTextController.text)!)) {
          return "A data inicial não pode ser mais recente que a data final!";
        } else {
          return null;
        }
      }

      Future<void> showDatePickerDialog(
        TextEditingController controller,
      ) async {
        final DateTime? picked = await showDatePicker(
          context: dialogContext,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(DateTime.now().year + 1),
          cancelText: "Cancelar",
          confirmText: "Confirmar",
          locale: const Locale('pt', 'BR'),
          switchToInputEntryModeIcon: const Icon(
            Icons.keyboard,
            color: Color(0xFF151515),
            size: 20,
          ),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: const Color(0xFF00935F),
                colorScheme: const ColorScheme.light(
                  primary: Color(0xFF00935F),
                ),
                buttonTheme: const ButtonThemeData(
                  textTheme: ButtonTextTheme.primary,
                ),
              ),
              child: child!,
            );
          },
        );

        if (picked != null) {
          controller.text = DateFormat('dd/MM/yyyy').format(picked);
        }
      }

      return AlertDialog.adaptive(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                textAlign: TextAlign.start,
                text: const TextSpan(
                  text: "Filtrar por ",
                  style: TextStyle(
                    fontFamily: "Nunito",
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF151515),
                  ),
                  children: [
                    TextSpan(
                      text: "data personalizada",
                      style: TextStyle(
                        fontFamily: "Nunito",
                        fontSize: 20,
                        height: 1,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF00935F),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(dialogContext),
                icon: const FaIcon(
                  FontAwesomeIcons.xmark,
                  color: Color(0xFF151515),
                ),
              ),
            ],
          ),
        ),
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: screenSize.height * 0.02),
                const Text(
                  "Data inicial para filtragem",
                  style: TextStyle(
                    fontFamily: "Nunito",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF151515),
                  ),
                ),
                SizedBox(height: screenSize.height * 0.02),
                GeneralTextFieldComponent(
                  hintText: "Digite a data inicial",
                  textEditingController: dataInicialTextController,
                  onSuffixPressed: () => showDatePickerDialog(
                    dataInicialTextController,
                  ),
                ),
                SizedBox(height: screenSize.height * 0.02),
                const Text(
                  "Data final para filtragem",
                  style: TextStyle(
                    fontFamily: "Nunito",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF151515),
                  ),
                ),
                SizedBox(height: screenSize.height * 0.02),
                GeneralTextFieldComponent(
                  hintText: "Digite a data final",
                  textEditingController: dataFinalTextController,
                  onSuffixPressed: () => showDatePickerDialog(
                    dataFinalTextController,
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          GeneralTextButtonComponent(
            text: "Filtrar",
            onTap: () {
              if (validate() != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: const Duration(seconds: 5),
                    content: Row(
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.circleExclamation,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(width: screenSize.width * 0.02),
                        Text(
                          validate()!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    backgroundColor: const Color(0xFFF44336),
                  ),
                );
                Navigator.pop(context);
              } else {
                store.filtrarPorData(
                  periodo: "Personalizado",
                  dataInicio:
                      convertStringToDate(dataInicialTextController.text),
                  dataFinal: convertStringToDate(dataFinalTextController.text),
                );
                Navigator.pop(context);
              }
            },
          ),
        ],
      );
    },
  );
}
