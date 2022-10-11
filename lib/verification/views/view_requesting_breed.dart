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
  bool _nameBreedValidator = false;
  late final TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController();
    _controller.addListener(listenValidator);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final elBloc = context.read<VerificationBloc>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter',
            ),
            controller: _controller,
          ),
          Container(
            child: _nameBreedValidator
                ? null
                : TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.grey),
                    ),
                    onPressed: null,
                    child: const Text('Buscar Raza'),
                  ),
          ),
          Container(
            child: !_nameBreedValidator
                ? null
                : TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    onPressed: () {
                      elBloc.add(
                        ReciviedBreed(
                          FormatBreed.constructor(_controller.text),
                        ),
                      );
                    },
                    child: const Text('Buscar Raza'),
                  ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void listenValidator() {
    setState(() {
      try {
        FormatBreed.constructor(_controller.text);
        _nameBreedValidator = true;
      } catch (e) {
        _nameBreedValidator = false;
      }
    });
  }
}
