import 'package:bounty_hub_client/ui/pages/profile_page/profile/bloc/profile_bloc.dart';
import 'package:bounty_hub_client/ui/pages/profile_page/profile/bloc/profile_event.dart';
import 'package:bounty_hub_client/ui/pages/profile_page/profile/bloc/profile_state.dart';
import 'package:bounty_hub_client/ui/widgets/app_button.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:bounty_hub_client/utils/ui/styles.dart';
import 'package:bounty_hub_client/utils/ui/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletCardWidget extends StatefulWidget {
  @override
  _WalletCardWidgetState createState() => _WalletCardWidgetState();
}

class _WalletCardWidgetState extends State<WalletCardWidget> {
  FocusNode focusText = FocusNode();
  TextEditingController _editingController;
  var controllerWaInit = false;

  @override
  void initState() {
    _editingController = TextEditingController()
      ..addListener(() {
        try {
          setState(() {});
        }catch(e){
          //
        }
      });
    focusText.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      cubit: context.bloc<ProfileBloc>(),
      builder: (context, state) {
        if (!controllerWaInit) {
          _editingController.text = state.user.tronWallet ?? '';
          controllerWaInit = true;
        }
        return state.user == null
            ? Container()
            : Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  decoration: WidgetsDecoration.appCardStyle().copyWith(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Tron wallet',
                        style: AppTextStyles.titleTextStyle,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 16,
                        ),
                        child: Container(
                          constraints: BoxConstraints(
                            maxHeight: 100.0,
                          ),
                          decoration: BoxDecoration(
                              color: AppColors.socialDescription,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              border: Border.all(
                                  color: focusText.hasPrimaryFocus
                                      ? AppColors.socialDescriptionBorder
                                      : AppColors.socialDescription,
                                  width: 2)),
                          child: TextField(
                            controller: _editingController,
                            maxLines: null,
                            style: AppTextStyles.defaultText,
                            focusNode: focusText,
                            decoration: InputDecoration(
                                enabled: state.user.tronWallet == null,
                                hintText: 'Enter wallet',
                                hintStyle: AppTextStyles.defaultThinText,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                      if (state.user.tronWallet == null)
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: AppButton(
                            text: 'save'.toUpperCase(),
                            width: 100,
                            enable: _editingController.text.length > 10,
                            onPressed: () {
                              focusText.unfocus();
                              context.bloc<ProfileBloc>().add(
                                  UpdateTronWalletEvent(
                                      _editingController.text));
                            },
                          ),
                        )
                    ],
                  ),
                ),
              );
      },
    );
  }
}
