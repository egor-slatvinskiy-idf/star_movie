import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/base/bloc.dart';
import 'package:presentation/navigation/base_arguments.dart';

abstract class BlocScreenState<SW extends StatefulWidget, B extends Bloc>
    extends State<SW> {
  @protected
  final B bloc = GetIt.instance.get<B>();

  @override
  void initState() {
    super.initState();
    bloc.initState();
    _getArgs();
  }

  void _getArgs() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final settings = ModalRoute.of(context)?.settings;
      if (settings != null) {
        final arguments = settings.arguments;
        if (arguments is BaseArguments) {
          bloc.initArgs(arguments);
        }
      }
    });
  }
}
