import 'package:dogs_breed/domain/format_breed.dart';
import 'package:dogs_breed/verification/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class ViewShowingNotConfirmedBreed extends StatelessWidget {
  final FormatBreed breed;
  const ViewShowingNotConfirmedBreed(this.breed, {super.key});

  @override
  Widget build(BuildContext context) {
    final theBloc = context.read<VerificationBloc>();
    return Center(
      child: Column(
        children: [
          Text('Esta raza ${breed.valor} no existe'),
          TextButton(
              onPressed: () {
                theBloc.add(Created());
              },
              child: const Text('Volver'))
        ],
      ),
    );
  }
}
