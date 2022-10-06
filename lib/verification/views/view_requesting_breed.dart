import 'package:dogs_breed/verification/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/format_breed.dart';

class ViewRequestingBreed extends StatefulWidget {
  const ViewRequestingBreed({Key? key}) : super(key: key);

  @override
  State<ViewRequestingBreed> createState() => _ViewRequestingBreedState();
}

class _ViewRequestingBreedState extends State<ViewRequestingBreed> {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theBloc = context.read<VerificationBloc>();
    return Column(
      children: [
        const Text('Dame el nombre pa'),
        TextField(
          controller: _controller,
        ),
        TextButton(
            onPressed: () {
              theBloc.add(
                  ReciviedBreed(FormatBreed.constructor(_controller.text)));
            },
            child: const Text('Aceptar'))
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
