import 'package:advisor/3_application/pages/advisor/cubit/advisor_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn({super.key});

  @override
  Widget build(BuildContext context) {
    final themData = Theme.of(context);
    return InkResponse(
      onTap: () {
        BlocProvider.of<AdvisorCubit>(
          //AdvisorBloc
          context,
        ).adviceRequested(); //add(AdvisorRequestEvent());

        // to trigger event
      },
      child: Material(
        elevation: 25,
        borderRadius: BorderRadius.circular(20),
        color: themData.colorScheme.onPrimary,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Text("Get Advice", style: themData.textTheme.bodyMedium),
        ),
      ),
    );
  }
}
