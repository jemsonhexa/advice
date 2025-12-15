import 'package:advisor/3_application/pages/advisor/bloc/advisor_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:test/scaffolding.dart';

void main() {
  group("AdviseBloc", () {
    group("Should Emit", () {
      blocTest<AdvisorBloc, AdvisorState>(
        "Nothing while no event is added",
        build: () => AdvisorBloc(),
        expect: () => const <AdvisorState>[],
      );

      //error test specific
      blocTest(
        '[AdvisorStateLoading, AdvisorStateError] when AdviceRequestEvent is Added',
        build: () => AdvisorBloc(),
        act: (bloc) => bloc.add(AdvisorRequestEvent()),
        wait: Duration(seconds: 3),
        expect: () => <AdvisorState>[
          AdvisorLoadingState(),
          AdvisorErrorState(errorMsg: "Got Error"),
        ],
      );
    });
  });
}
