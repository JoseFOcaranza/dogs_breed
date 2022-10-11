import 'package:dogs_breed/verification/bloc.dart';
import 'package:dogs_breed/verification/verification_repo.dart';
import 'package:dogs_breed/verification/views/view_creating.dart';
import 'package:dogs_breed/verification/views/view_requesting_breed.dart';
import 'package:dogs_breed/verification/views/view_showing_breed_without_subbreed.dart';
import 'package:dogs_breed/verification/views/view_showing_confirmed_breed.dart';
import 'package:dogs_breed/verification/views/view_showing_not_confirmed_breed.dart';
import 'package:dogs_breed/verification/views/view_showing_request_update.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const InyectedApp());
}

class InyectedApp extends StatelessWidget {
  const InyectedApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        VerificationBloc verificationBloc =
            VerificationBloc(RepoTestVerification());
        Future.delayed(const Duration(seconds: 2), () {
          verificationBloc.add(Created());
        });
        return verificationBloc;
      },
      child: const Myapp(),
    );
  }
}

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Builder(builder: (context) {
            var state = context.watch<VerificationBloc>().state;
            if (state is Creating) {
              return const ViewCreating();
            }
            if (state is RequestingBreed) {
              return const ViewRequestingBreed();
            }
            if (state is ShowingRequestUpdate) {
              return const ViewShowingRequestUpdate();
            }
            if (state is ShowingConfirmedBreed) {
              return ViewShowingConfirmedBreed(state.dogRegister, state.breed);
            }
            if (state is ShowingBreedWithoutSubBreed) {
              return ViewShowingBreedWithoutSubBreed(state.breed);
            }
            if (state is ShowingNotConfirmedBreed) {
              return ViewShowingNotConfirmedBreed(state.breed);
            }
            return const Center(
              child: Text("Si estas viendo esto, RUN"),
            );
          }),
        ));
  }
}
