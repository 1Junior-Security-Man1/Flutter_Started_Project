import 'package:bounty_hub_client/ui/pages/task_details/task_details_cubit.dart';
import 'package:bounty_hub_client/ui/pages/task_details/task_details_state.dart';
import 'package:bounty_hub_client/ui/widgets/app_progress_bar.dart';
import 'package:bounty_hub_client/ui/widgets/empty_data_place_holder.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:bounty_hub_client/utils/ui/dimens.dart';
import 'package:bounty_hub_client/utils/ui/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskDetailsPage extends StatefulWidget {

  final String taskId;

  final String title;

  TaskDetailsPage({Key key, @required this.taskId, @required this.title})
      : assert(taskId != null), assert(title != null),
        super(key: key);

  @override
  _TaskDetailsPageState createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {

  TaskDetailsCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.bloc<TaskDetailsCubit>();
    _cubit.fetchTask(widget.taskId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskDetailsCubit, TaskDetailsState>(
          listener: (context, state) {

          },
          child: BlocBuilder<TaskDetailsCubit, TaskDetailsState>(
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

  _buildContent(BuildContext context, TaskDetailsState state) {
    if(state.status == TaskDetailsStatus.loading) {
      return Loading();
    } else if(state.status == TaskDetailsStatus.success) {
      return _buildTaskDetails();
    } else {
      return EmptyDataPlaceHolder();
    }
  }

  StatelessWidget _buildTaskDetails() {
    return SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 8.0),
              height: 290,
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: Dimens.content_padding, right: Dimens.content_padding, bottom: Dimens.content_internal_padding, top: Dimens.content_padding),
                    decoration: WidgetsDecoration.appCardStyle(),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 7,
                                blurRadius: 7,
                                offset: Offset(0, 5),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: Image.network(
                              'https://picsum.photos/250?image=9',
                              height: 95,
                              width: 95,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: Dimens.content_padding, right: Dimens.content_padding),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 85,
                      decoration: WidgetsDecoration.appCardStyle(),
                    ),
                  ),
                  SizedBox(
                    width: Dimens.content_internal_padding,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 85,
                      decoration: WidgetsDecoration.appCardStyle(),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 500,
              margin: EdgeInsets.only(left: Dimens.content_padding, right: Dimens.content_padding, top: Dimens.content_internal_padding, bottom: Dimens.content_internal_padding),
              decoration: WidgetsDecoration.appCardStyle(),
            ),
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
                  color: AppColors.navigationWidgetsColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      title: Text(widget.title,
        style: TextStyle(
          color: AppColors.appBarTextColor,
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