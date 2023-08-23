import 'package:animations/animations.dart';
import 'package:flutter/widgets.dart';
import 'package:metadent_checkin_app/ui/pages/pages.dart';

class Routes {
  static const String home = "/";
  static const String users = "users";
  static const String checkin = "checkin";
  static const String newAppointment = "newAppointment";

  static Route<T> fadeThrough<T>(RouteSettings settings, WidgetBuilder page,
      {int duration = 300}) {
    return PageRouteBuilder<T>(
      settings: settings,
      transitionDuration: Duration(milliseconds: duration),
      pageBuilder: (context, animation, secondaryAnimation) => page(context),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeScaleTransition(animation: animation, child: child);
      },
    );
  }

  static Route all(RouteSettings settings) =>
      Routes.fadeThrough(settings, (context) {
        switch (settings.name) {
          case Routes.home:
            return const HomePage();
          case Routes.checkin:
            return const CheckinPage();
          case Routes.users:
            return const UsersPage();
          case Routes.newAppointment:
            return const NewAppointmentPage();
          default:
            return const SizedBox.shrink();
        }
      });
}
