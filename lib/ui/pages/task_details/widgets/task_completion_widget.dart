import 'dart:io';
import 'package:bounty_hub_client/data/enums/task_validation_type.dart';
import 'package:bounty_hub_client/data/enums/user_task_status.dart';
import 'package:bounty_hub_client/data/models/entity/task/task.dart';
import 'package:bounty_hub_client/data/models/entity/user_task/user_task.dart';
import 'package:bounty_hub_client/ui/pages/task_details/cubit/task_details_cubit.dart';
import 'package:bounty_hub_client/ui/pages/task_details/cubit/task_details_state.dart';
import 'package:bounty_hub_client/ui/pages/task_details/widgets/task_ui_utils.dart';
import 'package:bounty_hub_client/ui/widgets/app_button.dart';
import 'package:bounty_hub_client/ui/widgets/app_text_field.dart';
import 'package:bounty_hub_client/utils/localization/localization.res.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:bounty_hub_client/utils/ui/dimens.dart';
import 'package:bounty_hub_client/utils/ui/styles.dart';
import 'package:bounty_hub_client/utils/ui/text_styles.dart';
import 'package:bounty_hub_client/utils/validation/form_validation.dart';
import 'package:bounty_hub_client/utils/validation/string_utils.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import 'add_dialogs.dart';

class TaskCompletionWidget extends StatefulWidget {

  final UserTask userTask;

  final Task task;

  const TaskCompletionWidget({Key key, this.userTask, this.task}) : super(key: key);

  @override
  TaskCompletionWidgetState createState() => TaskCompletionWidgetState();
}

class TaskCompletionWidgetState extends State<TaskCompletionWidget> {

  final _formKey = GlobalKey<FormState>();
  final _commentController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  File _attachment;

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskDetailsCubit, TaskDetailsState>(
      listener: (context, state) {},
      child: BlocBuilder<TaskDetailsCubit, TaskDetailsState>(
        builder: (context, state) {
          switch(state.task.getTaskValidationType()) {
            case TaskValidationType.SOCIAL_PARSER:
              return _buildSocialParserCompletionWidget();
            case TaskValidationType.AUTO_CHECK:
              return _buildAutoCheckCompletionWidget(state.showTimer);
            default:
              return _buildSocialParserCompletionWidget();
          }
        },
      ),
    );
  }

  Widget _buildAutoCheckCompletionWidget(bool showTimer) {
    int currentUserTaskStep = getTaskCompletionStepByStatus(widget.userTask.getTaskStatus(), widget.userTask.approveDate, checkNullInt(widget.task.confirmationDaysCount, defaultValue: 1));
    switch(currentUserTaskStep) {
      case 1: return _buildLeaveCompleteWidget(); // IN_PROGRESS
      case 2: return _buildContinueButton(); // VERIFYING
      case 3: return _buildApproveRejectWidget(widget.userTask.getTaskStatus(), AppColors.accentColor, widget.task.confirmationDaysCount); // APPROVED or REJECTED
      case 4: return showTimer ? _buildVerifyingTimerWidget(widget.userTask, checkNullInt(widget.task.confirmationDaysCount, defaultValue: 1), null) : _buildReconfirmWidget(); // RECONFIRM
      case 5: return _buildEmptySpaceWidget(); // PAID or CANCELED
      default:
        return _buildEmptySpaceWidget();
    }
  }

  Widget _buildSocialParserCompletionWidget() {
    int currentUserTaskStep = getTaskCompletionStepByStatus(widget.userTask.getTaskStatus(), widget.userTask.approveDate, checkNullInt(widget.task.confirmationDaysCount, defaultValue: 1));
    switch(currentUserTaskStep) {
      case 1: return _buildLeaveCompleteWidget(); // IN_PROGRESS
      case 2: return _buildVerifyingTimerWidget(widget.userTask, checkNullInt(widget.task.confirmationDaysCount, defaultValue: 1), null); // VERIFYING
      case 3: return _buildApproveRejectWidget(widget.userTask.getTaskStatus(), AppColors.accentColor, widget.task.confirmationDaysCount); // APPROVED or REJECTED
      case 4: return _buildEmptySpaceWidget(); // RECONFIRM
      case 5: return _buildEmptySpaceWidget(); // PAID or CANCELED
      default:
        return _buildEmptySpaceWidget();
    }
  }

  Widget _buildLeaveCompleteWidget() {
    return Container(
      margin: EdgeInsets.only(left: Dimens.content_padding, right: Dimens.content_padding, bottom: Dimens.content_internal_padding),
      padding: EdgeInsets.all(Dimens.content_internal_padding),
      decoration: WidgetsDecoration.appCardStyle(),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              AppStrings.completeTask,
              style: AppTextStyles.titleTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 12.0,
          ),
          AppButton(
            height: 50,
            type: AppButtonType.BLUE,
            text: AppStrings.complete,
            width: MediaQuery.of(context).size.width / 2,
            onPressed: () {
              showCompleteTaskDialog();
            },
          ),
          SizedBox(
            height: 12.0,
          ),
          AppButton(
            height: 50,
            type: AppButtonType.WHITE,
            text: AppStrings.leave,
            width: MediaQuery.of(context).size.width / 2,
            onPressed: () {
              showConfirmActionDialog(context, AppStrings.youWantLeaveTask,
                      () {
                        leaveTask();
                      },
                      () {
                        Navigator.of(context).pop();
                      });
            },
          ),
        ],
      ),
    );
  }

  void showCompleteTaskDialog() {
    switch(widget.task.getTaskValidationType()) {
      case TaskValidationType.SOCIAL_PARSER:
        return showCompleteSocialParserTaskDialog();
      case TaskValidationType.AUTO_CHECK:
        return showCompleteAutoCheckTaskDialog();
      default:
        return showCompleteSocialParserTaskDialog();
    }
  }

  void showCompleteSocialParserTaskDialog() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (builder){
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter state) {
                return Container(
                  height: MediaQuery.of(context).size.height - 100,
                  color: Colors.transparent,
                  child: Container(
                    padding: EdgeInsets.only(left: 36.0, right: 36.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(Dimens.app_bottom_dialog_border_radius),
                            topRight: const Radius.circular(Dimens.app_bottom_dialog_border_radius))),
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView (
                        child: Column(
                            children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 24.0),
                              child: Text(
                                AppStrings.confirmAsCompleted,
                                style: AppTextStyles.titleTextStyle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Container(
                                child: Text(
                                  AppStrings.uploadScreenshot,
                                  style: AppTextStyles.greyContentTextStyle,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: _attachment == null ? SizedBox(
                                width: 64.0,
                                height: 64.0,
                                child: Material(
                                  color: Colors.transparent,
                                  child: IconButton(
                                      color: AppColors.primaryColor,
                                      icon: Icon(Icons.add_a_photo, size: 64.0),
                                      onPressed: () {
                                        getImageFromGallery(state);
                                      }
                                  ),
                                ),
                              ) : Image.file(
                                _attachment,
                                width: 64.0,
                                height: 64.0,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 36.0),
                              child: Linkify(
                                onOpen: (link) async {
                                  if (await canLaunch(link.url)) {
                                    await launch(link.url);
                                  }
                                },
                                text: getCompletingTaskInformation(widget.task),
                                style: AppTextStyles.greyContentTextStyle,
                                linkStyle: TextStyle(color: Colors.blue),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 24.0),
                              child: AppTextField(
                                textInputAction: TextInputAction.done,
                                controller: _commentController,
                                maxLines: 4,
                                withShadow: false,
                                validator: (value) => FormValidation.isEmpty(value),
                                decoration: WidgetsDecoration.appMultiLineTextFormStyle(AppStrings.comment),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 24.0, bottom: 200),
                              child: AppButton(
                                height: 50,
                                type: AppButtonType.BLUE,
                                text: AppStrings.confirm,
                                width: MediaQuery.of(context).size.width / 2,
                                onPressed: () {
                                  confirmSocialParserTask();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        }
    );
  }

  void showCompleteAutoCheckTaskDialog() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (builder){
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter state) {
                return Container(
                  height: 400,
                  color: Colors.transparent,
                  child: Container(
                    padding: EdgeInsets.only(left: 36.0, right: 36.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(Dimens.app_bottom_dialog_border_radius),
                            topRight: const Radius.circular(Dimens.app_bottom_dialog_border_radius))),
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 24.0),
                              child: Text(
                                AppStrings.confirmAsCompleted,
                                style: AppTextStyles.titleTextStyle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Linkify(
                                onOpen: (link) async {
                                  if (await canLaunch(link.url)) {
                                    await launch(link.url);
                                  }
                                },
                                text: getCompletingTaskInformation(widget.task),
                                style: AppTextStyles.greyContentTextStyle,
                                linkStyle: TextStyle(color: Colors.blue),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 24.0),
                              child: AppTextField(
                                controller: _commentController,
                                maxLines: 4,
                                withShadow: false,
                                validator: (value) => FormValidation.isEmpty(value),
                                decoration: WidgetsDecoration.appMultiLineTextFormStyle(AppStrings.comment),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 24.0, bottom: 200),
                              child: Center(
                                child: AppButton(
                                  height: 50,
                                  type: AppButtonType.BLUE,
                                  text: AppStrings.confirm,
                                  width: MediaQuery.of(context).size.width / 2,
                                  onPressed: () {
                                    confirmAutoCheckTask();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        }
    );
  }

  void leaveTask() {
    Navigator.of(context).pop();
    context.bloc<TaskDetailsCubit>().leaveTask(widget.task.id, widget.userTask.id);
  }

  void confirmSocialParserTask() {
    if (_formKey.currentState.validate()) {
      Navigator.of(context).pop();
      context.bloc<TaskDetailsCubit>().confirmSocialParserTask(_commentController.value.text, widget.userTask.id, _attachment);
    }
  }

  void confirmAutoCheckTask() {
    Navigator.of(context).pop();
    context.bloc<TaskDetailsCubit>().confirmAutoCheckTask(_commentController.value.text, widget.userTask.id);
  }

  void reconfirmAutoCheckTask() {
    context.bloc<TaskDetailsCubit>().reconfirmAutoCheckTask(_commentController.value.text, widget.userTask.id);
  }

  void retryTask() {
    context.bloc<TaskDetailsCubit>().retryTask(widget.task.id, widget.userTask.id);
  }

  Future getImageFromGallery(StateSetter state) async {
    final pickedFile = await _picker.getImage(maxWidth: 640, maxHeight: 480, source: ImageSource.gallery);
    state(() {
      if (pickedFile != null) {
        _attachment = File(pickedFile.path);
      }
    });
  }

  String getCompletingTaskInformation(Task parentTask) {
    switch(parentTask.getTaskValidationType()) {
      case TaskValidationType.AUTO_CHECK:
        return AppStrings.pleaseLoginTo + ' ' + EnumToString.convertToString(parentTask.getSocialNetwork());
      case TaskValidationType.SOCIAL_PARSER:
        if(parentTask.brief != null && parentTask.brief.isNotEmpty) {
          return parentTask.brief;
        } else {
          return AppStrings.followInstruction;
        }
        break;
      default:
        return '';
    }
  }

  Widget _buildContinueButton() {
    return Container(
      margin: EdgeInsets.only(left: Dimens.content_padding, right: Dimens.content_padding, bottom: Dimens.content_internal_padding),
      padding: EdgeInsets.all(Dimens.content_internal_padding),
      decoration: WidgetsDecoration.appCardStyle(),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            AppStrings.continueTask,
            style: AppTextStyles.titleTextStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 12.0,
          ),
          Text(
            getCompletingTaskInformation(widget.task),
            style: AppTextStyles.greyContentTextStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: Dimens.content_internal_padding,
          ),
          AppButton(
            height: 50,
            type: AppButtonType.BLUE,
            text: AppStrings.continueText,
            width: MediaQuery.of(context).size.width / 2,
            onPressed: () {
              showCompleteTaskDialog();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildReconfirmWidget() {
    return Container(
      margin: EdgeInsets.only(left: Dimens.content_padding, right: Dimens.content_padding, bottom: Dimens.content_internal_padding),
      padding: EdgeInsets.all(Dimens.content_internal_padding),
      decoration: WidgetsDecoration.appCardStyle(),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            AppStrings.reconfirmTask,
            style: AppTextStyles.titleTextStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 12.0,
          ),
          Text(
            getCompletingTaskInformation(widget.task),
            style: AppTextStyles.greyContentTextStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: Dimens.content_internal_padding,
          ),
          AppButton(
            height: 50,
            type: AppButtonType.BLUE,
            text: AppStrings.reconfirm,
            width: MediaQuery.of(context).size.width / 2,
            onPressed: () {
              reconfirmAutoCheckTask();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildApproveRejectWidget(UserTaskStatusType statusType, Color backgroundColor, int confirmationDaysCount) {
    return statusType == UserTaskStatusType.APPROVED ? _buildVerifyingTimerWidget(widget.userTask, confirmationDaysCount, AppStrings.reconfirmationTaskTime) : _buildRejectedWidget();
  }

  Widget _buildRejectedWidget() {
    return Container(
      margin: EdgeInsets.only(left: Dimens.content_padding, right: Dimens.content_padding, bottom: Dimens.content_internal_padding),
      padding: EdgeInsets.all(Dimens.content_internal_padding),
      decoration: WidgetsDecoration.appCardStyle(),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            AppStrings.rejected,
            style: AppTextStyles.titleTextStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 12.0,
          ),
          Text(
            AppStrings.taskCompletionChecked,
            style: AppTextStyles.greyContentTextStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: Dimens.content_internal_padding,
          ),
          widget.userTask.rejectComment != null ? Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: Dimens.content_internal_padding),
            padding: EdgeInsets.only(left: Dimens.content_padding, right: Dimens.content_padding),
            child: Text(AppStrings.rejectComment + ' ' + widget.userTask.rejectComment,
              textAlign: TextAlign.center,
              style: AppTextStyles.defaultErrorText,
            ),
          ) : Container(),
          AppButton(
            height: 50,
            type: AppButtonType.BLUE,
            text: AppStrings.retry,
            width: MediaQuery.of(context).size.width / 2,
            onPressed: () {
              retryTask();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildVerifyingTimerWidget(UserTask userTask, int confirmationDaysCount, String message) {
    return Container(
      margin: EdgeInsets.only(left: Dimens.content_padding, right: Dimens.content_padding, bottom: Dimens.content_internal_padding),
      padding: EdgeInsets.all(Dimens.content_internal_padding),
      decoration: WidgetsDecoration.appCardStyle(),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            AppStrings.verifying,
            style: AppTextStyles.titleTextStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 12.0,
          ),
          Text(
            message == null ? AppStrings.waitTaskVerified : message,
            style: AppTextStyles.greyContentTextStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: Dimens.content_internal_padding,
          ),
          Container(
            width: 200,
            margin: EdgeInsets.only(left: 40, right: 40),
            padding: EdgeInsets.all(Dimens.content_padding),
            decoration: BoxDecoration(
              color: AppColors.verificationTimerColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child:  Center(
              child: CountdownTimer(
                emptyWidget: Text(AppStrings.taskIsBeingChecked,
                  style: TextStyle(color: Colors.white),
                ),
                endTime: getTaskVerificationTime(confirmationDaysCount,
                    userTask.approveDate != null ? userTask.approveDate : userTask.lastModifiedDate),
                textStyle: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptySpaceWidget() {
    return SizedBox();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}