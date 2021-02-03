import 'package:bounty_hub_client/ui/pages/authorization/cubit/authorization_cubit.dart';
import 'package:bounty_hub_client/ui/pages/authorization/cubit/authorization_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bounty_hub_client/ui/pages/authorization/widgets/authorization_header_widget.dart';

class WelcomeWidget extends StatefulWidget {
  @override
  _WelcomeWidgetState createState() => _WelcomeWidgetState();
}

class _WelcomeWidgetState extends State<WelcomeWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthorizationCubit, AuthorizationState>(
      listener: (context, state) {

      },
      child: BlocBuilder<AuthorizationCubit, AuthorizationState>(
        builder: (context, state) {
          return Container(
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/page_bg.png'),
                    ),
                  ),
                ),
                Container(
                  child: SingleChildScrollView(
                    child: Column(children: <Widget>[
                      HeaderWidget(state: state),
                      Container(
                        child: _buildContent(context, state),
                      )
                    ]),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  _buildContent(BuildContext context, AuthorizationState state) {
    return Center(child: Text('Welcome'));
  }
}
