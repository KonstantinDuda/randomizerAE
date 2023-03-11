import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randomizer/database.dart';

import 'bloc_provider.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  //String text = '';
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              border: InputBorder.none,
            ),
            controller: _controller,
            expands: true,
            maxLines: null,
            keyboardType: TextInputType.number,
            autofocus: true,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
        ),
        TextButton(
            onPressed: () {
              MyDatabase db = MyDatabase();
              db.setCount(int.parse(
                  _controller.text)); // = int.parse(_controller.text);
              print('db.getCount  == ${db.count}}');
              context.read<ProviderBloc>().add(RootEvent());
            },
            child: const Text('Save')),
      ],
    );
  }
}
