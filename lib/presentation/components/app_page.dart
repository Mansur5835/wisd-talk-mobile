import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/bloc_logic.dart';
import 'app_cubit.dart';

abstract class AppPage<C extends StateStreamableSource<S>, S>
    extends StatefulWidget {
  final cubit = BlocLogic<C>()();

  AppPage({super.key});

  Widget build(BuildContext context, S state);

  @override
  State<StatefulWidget> createState() => _AppPageState<C, S>();
}

class _AppPageState<C extends StateStreamableSource<S>, S>
    extends State<AppPage> {
  final cubit = BlocLogic<C>()();

  @override
  void initState() {
    super.initState();
    if (mounted) {
      (cubit as AppCubit).init();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<C, S>(
      builder: (context, state) {
        return widget.build(context, state);
      },
    );
  }

  @override
  void dispose() {
    if (mounted) {
      (cubit as AppCubit).dispose();
    }
    super.dispose();
  }
}
