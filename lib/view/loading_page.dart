import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/providers/provider_bloc.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  createState() => _LoadingPage();
}

class _LoadingPage extends State<LoadingPage> with SingleTickerProviderStateMixin{
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: const Duration(seconds: 2) ,vsync: this);
    animation = Tween<double>(begin: 0, end: 10).animate(controller)
      ..addListener(() {
        // setState(() {
          
        // });
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {

    print("Loading Page");
    context.read<ProviderBloc>().add(RootEvent());
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Created by \n Duda Kostiantyn",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Loading ",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.grey,
                        ),
                      ),
                    Transform.rotate(
                      angle: animation.value,
                      child:
                    const Icon(
                      Icons.rotate_right_outlined,
                      size: 50.0,
                      color: Colors.blue,
                    ),),
                  ],
              ),
            ],
          ),
        ),
    );
  }

  @override 
  void dispose() {
    controller.dispose();
    super.dispose();
  }
} 