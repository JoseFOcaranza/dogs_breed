import 'package:dogs_breed/domain/format_breed.dart';
import 'package:dogs_breed/verification/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewShowingBreedWithoutSubBreed extends StatelessWidget {
  final FormatBreed breed;
  const ViewShowingBreedWithoutSubBreed(this.breed, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Text('Nombre: ${breed.valor}'),
        const Text('Esta raza no tiene subrazas'),
        TextButton(
            onPressed: () {
              final theBloc = context.read<VerificationBloc>();
              theBloc.add(Created());
            },
            child: const Text('Regresar')),
      ],
    ));
  }
}
