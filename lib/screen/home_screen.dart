import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/cubit/cubit.dart';
import 'package:flutter_application_1/cubit/stetse.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Homescreens extends StatefulWidget {
  const Homescreens({super.key});

  @override
  State<Homescreens> createState() => _HomescreensState();
}

class _HomescreensState extends State<Homescreens> {
  @override
  Widget build(BuildContext context) {
    var cubit = todoscubit.git(context);
    return BlocConsumer<todoscubit, todostate>(
        listener: (context, state) {},
        builder: (context, State) {
          var cubit = todoscubit.git(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text("wel come"),
            ),
            bottomNavigationBar:
                // ignore: prefer_const_literals_to_create_immutables
                BottomNavigationBar(
                    currentIndex: cubit.curuntindex,
                    onTap: (value) {
                      cubit.setbottomindex(value);
                    },
                    // ignore: prefer_const_literals_to_create_immutables
                    items: [
                  const BottomNavigationBarItem(
                      icon: Icon(Icons.star), label: "home"),
                  const BottomNavigationBarItem(
                      icon: Icon(Icons.check), label: "done"),
                  const BottomNavigationBarItem(
                      icon: Icon(Icons.book), label: "check"),
                ]),
          );
        });
  }
}
