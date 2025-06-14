import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/providers/root_body_provider.dart';

class LoadingRootBodyPage extends StatelessWidget {
  const LoadingRootBodyPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<RootBodyProviderBloc>().add(const RootBodyTurnOrderEvent(/*CardsStack.empty()*/));
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}