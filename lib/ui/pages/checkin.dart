import 'package:flutter/material.dart';
import 'package:metadent_checkin_app/blocs/blocs.dart';
import 'package:metadent_checkin_app/infra/infra.dart';
import 'package:metadent_checkin_app/ui/components/components.dart';
import 'package:responsive_framework/responsive_framework.dart';

// 10/10/2002
// dob / lastname
//
class CheckinPage extends StatefulWidget {
  const CheckinPage({Key? key}) : super(key: key);

  @override
  State<CheckinPage> createState() => _CheckinPageState();
}

class _CheckinPageState extends State<CheckinPage> {
  String equation = "DD/MM/YYYY";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;
  final String _dateSeparator = '/';

  String textMonth = "MM";
  String textDay = "DD";
  String textYear = "YYYY";

  @override
  Widget build(BuildContext context) {
    double? backBtnWidth = ResponsiveValue(
      context,
      defaultValue: 80.0,
      valueWhen: [
        const Condition.smallerThan(
          name: MOBILE,
          value: 55.0,
        ),
      ],
    ).value;

    double? backBtnHeight = ResponsiveValue(
      context,
      defaultValue: 65.0,
      valueWhen: [
        const Condition.smallerThan(
          name: MOBILE,
          value: 55.0,
        ),
      ],
    ).value;
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.checkIn.tr())),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 25,
          ),
          Center(
            child: Text(
              LocaleKeys.titleInputDateOfBirth.tr(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          // Stack(
          //   children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
            margin: const EdgeInsets.only(bottom: 20),
            width: MediaQuery.of(context).size.width - 100,
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).primaryColor,
              ),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: ResponsiveValue(
                  context,
                  defaultValue: MainAxisAlignment.center,
                  valueWhen: [
                    const Condition.smallerThan(
                      name: MOBILE,
                      value: MainAxisAlignment.spaceAround,
                    ),
                  ],
                ).value!,
                children: [
                  Text.rich(
                    TextSpan(
                      text: textDay,
                      children: [
                        TextSpan(text: _dateSeparator),
                        TextSpan(text: textMonth),
                        TextSpan(text: _dateSeparator),
                        TextSpan(text: textYear)
                      ],
                    ),
                    style: TextStyle(
                      fontSize: equationFontSize,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: backBtnWidth,
                    height: backBtnHeight,
                    child: resetButton(),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width - 100,
                  padding: const EdgeInsets.all(25.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  child: Table(
                    children: [
                      TableRow(children: [
                        buildButton("7"),
                        buildButton("8"),
                        buildButton("9"),
                      ]),
                      TableRow(children: [
                        buildButton("4"),
                        buildButton("5"),
                        buildButton("6"),
                      ]),
                      TableRow(children: [
                        buildButton("1"),
                        buildButton("2"),
                        buildButton("3"),
                      ]),
                      TableRow(children: [
                        // buildButton("/", 1),
                        Container(),
                        buildButton("0"),
                        Container(),
                        // buildButton("⌫", 1),
                      ]),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          BlocConsumer<AppointmentsBloc, AppointmentsState>(
            listener: (context, state) {
              if (state.error != null) {
                AppUtils(context).showAlert(state.error);
                _resetDate(delay: 5);
              }
              if (state.message != null) {
                AppUtils(context).showAlert(state.message);
                _resetDate(delay: 5);
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(50, 24, 50, 16),
                child: CustomButton(
                    loading: state.status == AppState.loading,
                    label: LocaleKeys.continueText.tr(),
                    onPressed: () {
                      if (_isValidDateOfBirth) {
                        context.read<AppointmentsBloc>().add(
                              Checkin(
                                  dateOfBirth: '$textDay-$textMonth-$textYear'),
                            );
                      } else {
                        AppUtils(context).showAlert(
                          LocaleKeys.alertFillDateOfBirth.tr(),
                        );
                      }
                    }),
              );
            },
          ),
        ],
      ),
    );
  }

  _resetDate({int delay = 0}) => Future.delayed(Duration(seconds: delay), () {
        if (mounted) {
          setState(() {
            textMonth = "MM";
            textDay = "DD";
            textYear = "YYYY";
          });
        }
      });

  bool get _isValidDateOfBirth => (!textDay.contains('D') &&
      !textMonth.contains('M') &&
      !textYear.contains('Y'));

  buttonPressed(String buttonText) {
    if (buttonText == "⌫") {
      _resetDate();
      return;
    }
    if (buttonText == '/') return;
    if (textDay.contains('D')) {
      final chars = textDay.characters.toList();
      if (chars[0] == 'D') {
        if (buttonText == '0' ||
            buttonText == '1' ||
            buttonText == '2' ||
            buttonText == '3') {
          textDay =
              AppUtils.replaceCharAt(text: textDay, char: buttonText, index: 0);
        }
        setState(() {});
        return;
      }
      if (chars[1] == 'D') {
        if (chars[0] == '0' && buttonText == '0') return;
        if (chars[0] == '3' && int.parse(buttonText) > 1) return;
        textDay =
            AppUtils.replaceCharAt(text: textDay, char: buttonText, index: 1);
        setState(() {});
        return;
      }
      return;
    }
    if (textMonth.contains('M')) {
      final chars = textMonth.characters.toList();
      if (chars[0] == 'M') {
        if (buttonText == '0' || buttonText == '1') {
          textMonth = AppUtils.replaceCharAt(
              text: textMonth, char: buttonText, index: 0);
        }
        setState(() {});
        return;
      }
      if (chars[1] == 'M') {
        if (chars[0] == '0' && buttonText == '0') return;
        if (chars[0] == '1' && int.parse(buttonText) > 2) return;
        textMonth =
            AppUtils.replaceCharAt(text: textMonth, char: buttonText, index: 1);
        setState(() {});
        return;
      }
      return;
    }
    if (textYear.contains('Y')) {
      final chars = textYear.characters.toList();
      if (chars[0] == 'Y') {
        if (buttonText == '1' || buttonText == '2') {
          textYear = AppUtils.replaceCharAt(
              text: textYear, char: buttonText, index: 0);
        }
        setState(() {});
        return;
      }
      if (chars[1] == 'Y') {
        if (chars[0] == '1' && buttonText != '9') return;
        if (chars[0] == '2' && buttonText != '0') return;
        if (buttonText == '0' || buttonText == '9') {
          textYear = AppUtils.replaceCharAt(
              text: textYear, char: buttonText, index: 1);
        }
        setState(() {});
        return;
      }
      if (chars[2] == 'Y') {
        textYear =
            AppUtils.replaceCharAt(text: textYear, char: buttonText, index: 2);
        setState(() {});
        return;
      }
      if (chars[3] == 'Y') {
        textYear =
            AppUtils.replaceCharAt(text: textYear, char: buttonText, index: 3);
        setState(() {});
        return;
      }
      return;
    }
  }

  Widget buildButton(
    String buttonText,
  ) {
    const newHeight = .8;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(6.0),
        elevation: 0,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.1 * newHeight,
          constraints: const BoxConstraints(maxWidth: 30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(1.0),
            border: Border.all(
              color: Theme.of(context).primaryColor,
            ),
          ),
          child: TextButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  side: const BorderSide(
                    color: Colors.white,
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
              padding: MaterialStateProperty.all(
                const EdgeInsets.all(10.0),
              ),
            ),
            onPressed: () => buttonPressed(buttonText),
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget resetButton() {
    const newHeight = .8;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => buttonPressed("⌫"),
        child: Material(
          borderRadius: BorderRadius.circular(6.0),
          elevation: 0,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.1 * newHeight,
            constraints: const BoxConstraints(maxWidth: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(1.0),
              border: Border.all(
                color: Theme.of(context).primaryColor,
              ),
            ),
            child: Center(
              child: Text(
                "⌫",
                style: TextStyle(
                  fontSize: ResponsiveValue(
                    context,
                    defaultValue: 32.0,
                    valueWhen: const [
                      Condition.smallerThan(
                        name: MOBILE,
                        value: 18.0,
                      ),
                    ],
                  ).value,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
