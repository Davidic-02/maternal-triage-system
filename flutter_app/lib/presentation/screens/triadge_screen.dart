import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:maternal_triage/bloc/triage/triage_bloc.dart';

class TriadgeScreen extends HookWidget {
  static const routeName = '/triage';
  const TriadgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(body: 
   SafeArea(
        child: BlocBuilder<TriageBloc, TriageState>(
          buildWhen: (previous, current) => _triageBuildWhen(
            context, previous, current
          ),
          builder: (context, state){ return
  const  SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 30),
           







    );
  }
}
