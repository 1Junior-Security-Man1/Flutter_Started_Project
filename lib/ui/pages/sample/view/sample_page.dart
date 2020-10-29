import 'package:bounty_hub_client/ui/pages/sample/sample_cubit.dart';
import 'package:bounty_hub_client/ui/pages/sample/sample_state.dart';
import 'package:bounty_hub_client/ui/widgets/app_progress_bar.dart';
import 'package:bounty_hub_client/ui/widgets/empty_data_place_holder.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SamplePage extends StatefulWidget {
  @override
  _SamplePageState createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {

  SampleCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.bloc<SampleCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SampleCubit, SampleState>(
      listener: (context, state) {

      },
      child: BlocBuilder<SampleCubit, SampleState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Scaffold(
              appBar: _buildAppBar(),
              backgroundColor: AppColors.pageBackgroundColor,
              body: _buildContent(context, state),
            ),
          );
        },
      ),
    );
  }

  _buildContent(BuildContext context, SampleState state) {
    if(state.status == SampleStatus.loading) {
      return Loading();
    } else if(state.status == SampleStatus.success) {
      return _buildUI();
    } else {
      return EmptyDataPlaceHolder();
    }
  }

  StatelessWidget _buildUI() {
    return SingleChildScrollView(
      child: Column(
        children: [

        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: AppColors.pageBackgroundColor,
      elevation: 0,
      leading: Center(
        child: Container(
          child: Stack(
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.primaryColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      title: Text('',
        style: TextStyle(
          color: AppColors.navigationWidgetsColor,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Image.asset(
            'assets/images/settings.png',
            width: 26,
          ),
          onPressed: () {
            // do something
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}