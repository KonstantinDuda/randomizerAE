import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randomizer_new/bloc/event_state/hero_es.dart';

import '../../bloc/crud_stack_bloc.dart';
import '../../bloc/event_state/crud_stack_es.dart';
import '../../bloc/hero_bloc.dart';
import '../../database/cards_stack.dart';

class ChangeStackDialog extends StatefulWidget {
  final HeroStack hero;
  const ChangeStackDialog(this.hero, {super.key});

  @override
  State<ChangeStackDialog> createState() => _ChangeStackDialogState();
}

class _ChangeStackDialogState extends State<ChangeStackDialog> {
  List<CardsStack> stacks = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CRUDStackBloc, CRUDStackState>(
      builder: (context, state) {
        if (state is CRUDStackSuccessActionState) {
          stacks = state.stacks;
        }

        return AlertDialog(
          title: const Text("Choose Stack"),
          content: SizedBox(
            width: 300,
            height: 350,
            child: //Text("This feature is not implemented yet.")),
                ListView.builder(
              itemCount: stacks.isNotEmpty ? stacks.length : 0,
              itemBuilder: (_, index) {
                return Card(
                  child: ListTile(
                    title: Center(child: Text(stacks[index].name)),
                    onTap: () {
                      print("Selected stack: ${stacks[index].name}");
                      context.read<HeroBloc>().add(HeroChangeStackEvent(widget.hero, stacks[index]));
                      Navigator.of(context).pop();
                    },
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
