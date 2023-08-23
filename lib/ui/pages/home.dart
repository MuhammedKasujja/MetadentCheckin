import 'package:flutter/material.dart';
import 'package:metadent_checkin_app/infra/infra.dart';
import 'package:metadent_checkin_app/routes.dart';
import 'package:metadent_checkin_app/ui/components/components.dart';
import 'package:responsive_framework/responsive_framework.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                "assets/ic_launcher_adaptive_fore.png",
                fit: BoxFit.contain,
              ),
            ),
            Center(
              child: Text(
                'METADENT',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: ResponsiveRowColumn(
                layout: ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)
                    ? ResponsiveRowColumnType.COLUMN
                    : ResponsiveRowColumnType.ROW,
                rowMainAxisAlignment: MainAxisAlignment.center,
                rowCrossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ResponsiveRowColumnItem(
                    rowFlex: 5,
                    columnOrder: 2,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(25, 24, 25, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Text(LocaleKeys.welcomeMessage.tr()),
                          ),
                          Center(
                            child: Text(
                              LocaleKeys.doYouHaveAppointment.tr(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: ResponsiveRowColumn(
                layout: ResponsiveWrapper.of(context).isSmallerThan(TABLET)
                    ? ResponsiveRowColumnType.COLUMN
                    : ResponsiveRowColumnType.ROW,
                rowMainAxisAlignment: MainAxisAlignment.center,
                rowCrossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ResponsiveRowColumnItem(
                    rowFlex: 5,
                    columnOrder: 2,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(25, 24, 25, 0),
                      child: SecondaryButton(
                        height: 75,
                        label: LocaleKeys.hintIDontHaveAppointment.tr(),
                        onPressed: () =>
                            Navigator.pushNamed(context, Routes.newAppointment),
                      ),
                    ),
                  ),
                  ResponsiveRowColumnItem(
                    rowFlex: 5,
                    columnOrder: 1,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(25, 24, 25, 0),
                      child: CustomButton(
                        label: LocaleKeys.hintIHaveAppointment.tr(),
                        height: 75,
                        onPressed: () =>
                            Navigator.pushNamed(context, Routes.checkin),
                      ),
                    ),
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
