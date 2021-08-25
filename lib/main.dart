import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfo_showcase_app/constants.dart';
import 'package:mfo_showcase_app/cubit/confirm_cubit.dart';
import 'package:mfo_showcase_app/cubit/navigation_cubit.dart';
import 'package:mfo_showcase_app/cubit/offer_list_cubit.dart';
import 'package:mfo_showcase_app/screens/calculator_page.dart';
import 'package:mfo_showcase_app/screens/offers_list_page.dart';
import 'package:mfo_showcase_app/support/support_innitor.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(Cubit cubit, Change change) {
    print("onChange cubit: $cubit, change: $change");
    super.onChange(cubit, change);
  }
}

void main() {
  Bloc.observer = SimpleBlocObserver();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SupportLibraryInnitor.initAppsFlyer();
    SupportLibraryInnitor.initOneSignal();

    return MaterialApp(
      title: ApplicationConstants.APP_NAME,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: const Color(0xFF02CD88),
        primaryColor: const Color(0xFF039AF0),
      ),
      home: Scaffold(
        body: BlocProvider<NavigationCubit>(
          create: (context) => NavigationCubit(),
          child: BlocProvider<OfferListCubit>(
            create: (context) => OfferListCubit(),
            child: BlocProvider<ConfirmCubit>(
              create: (context) => ConfirmCubit(
                BlocProvider.of<OfferListCubit>(context)
              )..checkAuthorization(),
              child: BlocBuilder<NavigationCubit, NavigationState>(
                builder: (context, state) {
                  if (state is NavigationOfferList) {
                    return OffersListPage();
                  }

                  return CalculatorPage();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
