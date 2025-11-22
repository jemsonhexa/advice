import 'package:advisor/3_application/core/services/theme_services.dart';
//import 'package:advisor/3_application/pages/advisor/bloc/advisor_bloc.dart';
import 'package:advisor/3_application/pages/advisor/cubit/advisor_cubit.dart';
import 'package:advisor/3_application/pages/advisor/widgets/advice_field.dart';
import 'package:advisor/3_application/pages/advisor/widgets/custom_btn.dart';
import 'package:advisor/3_application/pages/advisor/widgets/error_msg.dart';
import 'package:advisor/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class AdvisorPageWrapperProvider extends StatelessWidget {
  const AdvisorPageWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AdvisorCubit>(),
      //AdvisorBloc(),
      child: AdvisorPage(),
    );
  }
}

class AdvisorPage extends StatelessWidget {
  const AdvisorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Advice", style: themData.textTheme.headlineLarge),
        actions: [
          Switch(
            value: Provider.of<ThemeService>(context).isActive,
            onChanged: (value) {
              Provider.of<ThemeService>(context, listen: false).toggleTheme();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: BlocBuilder<AdvisorCubit, AdvisorCubitState>(
                  builder: (context, state) {
                    if (state is AdvisorInitial) {
                      return Text("Press below button for advice :)");
                    } else if (state is AdvisorLoadingState) {
                      return CircularProgressIndicator(
                        color: themData.colorScheme.secondary,
                      );
                    } else if (state is AdvisorLoadedState) {
                      return AdviceField(advice: state.advice);
                    } else if (state is AdvisorErrorState) {
                      return ErrorMsg(errMsg: state.errorMsg);
                    }
                    return const SizedBox(); //if no state happend
                  },
                ),
              ),
            ),
            SizedBox(height: 5),
            SizedBox(child: CustomBtn()),
          ],
        ),
      ),
    );
  }
}
