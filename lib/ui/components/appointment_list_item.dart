import 'package:flutter/material.dart';
import 'package:metadent_checkin_app/infra/infra.dart';

class AppointmentListItem extends StatelessWidget {
  final Appointment appointment;

  const AppointmentListItem({Key? key, required this.appointment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
      margin: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColor,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                color: Theme.of(context).primaryColor,
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(
                'Token Number - ${appointment.code!}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(.2),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    appointment.patient.initials,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Text(
                appointment.patient.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Icon(
                Icons.access_time,
                color: Theme.of(context).primaryColor,
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(
                '${appointment.slots[0].startTime} - ${appointment.slots[0].endTime}',
                style: const TextStyle(color: Colors.black),
              )
            ],
          )
        ],
      ),
    );
  }
}
