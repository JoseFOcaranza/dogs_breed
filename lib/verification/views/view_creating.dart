import 'package:flutter/material.dart';

class ViewCreating extends StatelessWidget {
  const ViewCreating({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 100,
      height: 100,
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
