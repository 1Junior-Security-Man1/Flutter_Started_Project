import 'package:flutter_starter/ui/pages/authorization/cubit/authorization_cubit.dart';
import 'package:flutter_starter/ui/pages/authorization/cubit/authorization_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TemplateWidget extends StatefulWidget {

  final String title;

  TemplateWidget(this.title);

  @override
  _TemplateWidgetState createState() => _TemplateWidgetState();
}

class _TemplateWidgetState extends State<TemplateWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthorizationCubit, AuthorizationState>(
      listener: (context, state) {

      },
      child: BlocBuilder<AuthorizationCubit, AuthorizationState>(
        builder: (context, state) {
          return Container(
            child: _buildContent(context, state),
          );
        },
      ),
    );
  }

  _buildContent(BuildContext context, AuthorizationState state) {
    return Center(child: Text(widget.title));
  }
}