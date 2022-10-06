import 'package:dogs_breed/domain/format_breed.dart';
import 'package:dogs_breed/domain/register_dog.dart';
import 'package:dogs_breed/verification/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewShowingConfirmedBreed extends StatelessWidget {
  final DogRegister dogRegister;
  final FormatBreed breed;
  const ViewShowingConfirmedBreed(this.dogRegister, this.breed, {super.key});

  @override
  Widget build(BuildContext context) {
    final theBloc = context.read<VerificationBloc>();
    return Center(
      child: Column(
        children: [
          Text('Raza: ${breed.valor}'),
          Text('SubRazas: ${dogRegister.subBreed}'),
          TextButton(
              onPressed: () {
                theBloc.add(Created());
              },
              child: const Text('Regresar')),
        ],
      ),
    );
  }
}
