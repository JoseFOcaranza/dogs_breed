import 'package:flutter/material.dart';

class ViewShowingRequestUpdate extends StatelessWidget {
  const ViewShowingRequestUpdate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        Text(
          'Actualizate pa',
          style: Theme.of(context).textTheme.headline1,
        ),
      ]),
    );
  }
}
