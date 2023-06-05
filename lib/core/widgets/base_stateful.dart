import 'package:alpha/core/applications/loading/loading_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

abstract class BaseStateful extends StatefulWidget {
  const BaseStateful({super.key});
}

abstract class BaseStatefulState extends State<BaseStateful> {
  late LoadingBloc loadingBloc;
  @override
  void initState() {
    super.initState();
    loadingBloc = GetIt.I.get();
  }

  void _show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => loadingBloc,
      child: BlocListener<LoadingBloc, LoadingState>(
        listener: (context, state) {
          if (state is LoadingShowState) {
            _show(context);
            return;
          }
          if (state is LoadingDismissState) {
            Navigator.pop(context);
            return;
          }
        },
        child: buildChild(),
      ),
    );
  }

  @mustCallSuper
  Widget buildChild();
}
