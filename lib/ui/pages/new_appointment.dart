import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:metadent_checkin_app/blocs/blocs.dart';
import 'package:metadent_checkin_app/infra/infra.dart';
import 'package:metadent_checkin_app/ui/ui.dart';
import 'package:responsive_framework/responsive_framework.dart';

class NewAppointmentPage extends StatefulWidget {
  const NewAppointmentPage({Key? key}) : super(key: key);

  @override
  State<NewAppointmentPage> createState() => _NewAppointmentPageState();
}

class _NewAppointmentPageState extends State<NewAppointmentPage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final dateController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();

  Slot defaultChoiceChip = const Slot(startTime: '', endTime: '', id: 0);
  AppointmentType? appointmentType;
  late Slot selectedSlot;

  @override
  void initState() {
    final appointmentsBloc = context.read<AppointmentsBloc>();
    if (appointmentsBloc.state.appointmentTypes == null) {
      context.read<AppointmentsBloc>().add(FetchAppointmentsTypes());
    }
    selectedSlot = defaultChoiceChip;
    context.read<SlotsBloc>().add(ClearSlots());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.newAppointment.tr()),
      ),
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 24, 25, 0),
                child: Text(
                  LocaleKeys.fillDetailsToCreateAppointment.tr().toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              ResponsiveRowColumn(
                layout: ResponsiveWrapper.of(context).isSmallerThan(TABLET)
                    ? ResponsiveRowColumnType.COLUMN
                    : ResponsiveRowColumnType.ROW,
                rowMainAxisAlignment: MainAxisAlignment.center,
                rowCrossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ResponsiveRowColumnItem(
                    rowFlex: 5,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(25, 24, 25, 0),
                      child: CustomTextfield(
                        label: LocaleKeys.firstName.tr(),
                        controller: firstNameController,
                        errorText: LocaleKeys.errorFirstnameMissing.tr(),
                      ),
                    ),
                  ),
                  ResponsiveRowColumnItem(
                    rowFlex: 5,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(25, 24, 25, 0),
                      child: CustomTextfield(
                        label: LocaleKeys.lastName.tr(),
                        controller: lastNameController,
                        errorText: LocaleKeys.errorLastnameMission.tr(),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                child: CustomDatepicker(
                  label: LocaleKeys.dateOfBirth.tr(),
                  controller: dateController,
                  errorText: LocaleKeys.errorDobMissing.tr(),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    LocaleKeys.treatmentType.tr(),
                    style: const TextStyle(color: Color(0xff384152)),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xffE5E7EB),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 6,
                    ),
                    child: BlocBuilder<AppointmentsBloc, AppointmentsState>(
                      builder: (context, state) {
                        return DropdownButton<AppointmentType>(
                          underline: const SizedBox.shrink(),
                          isExpanded: true,
                          hint: Text(LocaleKeys.selectTreatmentType.tr()),
                          value: appointmentType,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Source Sans Pro',
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          icon: Icon(
                            Icons.expand_more,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          items: state.appointmentTypes != null
                              ? state.appointmentTypes!
                                  .map((AppointmentType type) {
                                  return DropdownMenuItem(
                                    value: type,
                                    child: Text(type.title),
                                  );
                                }).toList()
                              : null,
                          onChanged: (AppointmentType? newValue) {
                            setState(() {
                              appointmentType = newValue;
                              selectedSlot = defaultChoiceChip;
                            });
                            context.read<SlotsBloc>().add(ClearSlots());
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
              timeChips(),
              BlocBuilder<SlotsBloc, SlotsState>(
                builder: (context, state) {
                  return state.filteredSlots == null
                      ? BlocConsumer<SlotsBloc, SlotsState>(
                          listener: (context, state) {
                            if (state.error != null) {
                              AppUtils(context).showAlert(state.error);
                            }
                          },
                          builder: (context, state) {
                            return Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(25, 24, 25, 16),
                              child: CustomButton(
                                loading: state.status == AppState.loading,
                                label: LocaleKeys.checkAvailableSlots.tr(),
                                onPressed: () {
                                  _formKey.currentState?.save();
                                  if (_formKey.currentState!.validate()) {
                                    if (appointmentType == null) {
                                      AppUtils(context).showAlert(LocaleKeys
                                          .errorSelectTreatmentMission
                                          .tr());
                                      return;
                                    }
                                    context.read<SlotsBloc>().add(
                                          FetchFreeAppointmentSlots(
                                            appointmentType:
                                                appointmentType!.id,
                                            dateOfBirth: dateController.text,
                                            firstName: firstNameController.text,
                                            lastName: lastNameController.text,
                                          ),
                                        );
                                  }
                                },
                              ),
                            );
                          },
                        )
                      : BlocConsumer<AppointmentsBloc, AppointmentsState>(
                          listener: (context, state) {
                            if (state.error != null) {
                              AppUtils(context).showAlert(state.error);
                            }
                            if (state.message != null) {
                              AppUtils(context).showAlert(state.message);
                            }
                          },
                          builder: (context, state) {
                            return Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(25, 24, 25, 16),
                              child: CustomButton(
                                loading: state.status == AppState.loading,
                                label: LocaleKeys.saveAppointment.tr(),
                                onPressed: () {
                                  _formKey.currentState?.save();
                                  if (_formKey.currentState!.validate()) {
                                    if (appointmentType == null) {
                                      AppUtils(context).showAlert(
                                        LocaleKeys.errorSelectTreatmentMission
                                            .tr(),
                                      );
                                      return;
                                    }
                                    if (selectedSlot.startTime.isEmpty) {
                                      AppUtils(context).showAlert(
                                        LocaleKeys.hintSelectSlot.tr(),
                                      );
                                      return;
                                    }
                                    context.read<AppointmentsBloc>().add(
                                          CreateAppointment(
                                            appointmentType:
                                                appointmentType!.id,
                                            dateOfBirth: dateController.text,
                                            firstName: firstNameController.text,
                                            lastName: lastNameController.text,
                                            interval:
                                                appointmentType!.agendaInterval,
                                            slot: selectedSlot,
                                          ),
                                        );
                                  }
                                },
                              ),
                            );
                          },
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget timeChips() {
    return BlocBuilder<SlotsBloc, SlotsState>(
      builder: (context, state) {
        return Column(
          children: [
            state.data != null
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 24, 25, 10),
                      child: Text(
                        LocaleKeys.selectSlot.tr(),
                        style: const TextStyle(color: Color(0xff384152)),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            Wrap(
              spacing: 8,
              children: state.data != null
                  ? state.filteredSlots!
                      .map(
                        (s) => ChoiceChip(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          side: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                          label: Text(
                            '${s.startTime} - ${s.endTime}',
                            style: TextStyle(
                              color: selectedSlot.startTime == s.startTime
                                  ? Colors.white
                                  : Theme.of(context).primaryColor,
                            ),
                          ),
                          selected: selectedSlot.startTime == s.startTime,
                          selectedColor: Theme.of(context).primaryColor,
                          onSelected: (bool selected) {
                            setState(() {
                              selectedSlot = selected ? s : defaultChoiceChip;
                            });
                          },
                          backgroundColor: Colors.white,
                          // Theme.of(context).primaryColor.withOpacity(0.30),
                          labelStyle: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      )
                      .toList()
                  : state.status == AppState.loading
                      ? [
                          const SizedBox(
                            height: 150,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        ]
                      : [],
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    dateController.dispose();
    super.dispose();
  }
}
