import 'package:bounty_hub_client/data/models/entity/user/user.dart';
import 'package:bounty_hub_client/ui/pages/profile_page/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:bounty_hub_client/ui/widgets/app_button.dart';
import 'package:bounty_hub_client/ui/widgets/custom_appbar.dart';
import 'package:bounty_hub_client/utils/localization/bloc/locale_bloc.dart';
import 'package:bounty_hub_client/utils/ui/colors.dart';
import 'package:bounty_hub_client/utils/ui/text_styles.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/edit_profile_form.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final nameFocus = FocusNode();
  final genderFocus = FocusNode();
  final nameEditController = TextEditingController();

  // Country _selectedCountry;

  @override
  void initState() {
    nameFocus.addListener(() {
      setState(() {});
    });
    genderFocus.addListener(() {
      setState(() {});
    });

    Future.microtask(() {
      nameEditController.text =
          BlocProvider.of<EditProfileCubit>(context).state.user.name;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = BlocProvider.of<EditProfileCubit>(context).state.user;

    print(user.name);
    return BlocBuilder<EditProfileCubit, EditProfileState>(
        builder: (context, state) {
      return Scaffold(
        appBar: CustomAppBar(
          title: 'Edit Profile',
          leftIcon: 'assets/images/back.png',
          onLeftIconClick: Navigator.of(context).pop,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ..._buildMailField(user),
              SizedBox(
                height: 20,
              ),
              _buildNameAndGanderField(user),
              SizedBox(
                height: 20,
              ),
              _buildCountryAndBirthday(user),
              ..._buildLanguageField(user),
              _buildSaveButton(context)
            ],
          ),
        ),
      );
    });
  }

  Padding _buildSaveButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: AppButton(
          width: MediaQuery.of(context).size.width / 2 - 20,
          text: 'SAVE',
          onPressed: () async {
            if (await BlocProvider.of<EditProfileCubit>(context).updateUser()) {
              Navigator.pop(context);
            }
          },
        ),
      ),
    );
  }

  Row _buildNameAndGanderField(User user) {
    return Row(
      children: [
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _buildLabel('Your Name', true),
            SizedBox(
              height: 4,
            ),
            EditProfileFormWidget(
                child: TextField(
                  controller: nameEditController,
                  focusNode: nameFocus,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
                node: nameFocus),
          ]),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _buildLabel('Gender', true),
            SizedBox(
              height: 4,
            ),
            EditProfileFormWidget(
                child: DropdownButton<String>(
                  isExpanded: true,
                  underline: Container(),
                  focusNode: genderFocus,
                  value: user.gender,
                  onChanged: (String newValue) {
                    setState(() {
                      user.gender = newValue;
                    });
                  },
                  items: <String>[
                    'MALE',
                    'FEMALE',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(value),
                      ),
                    );
                  }).toList(),
                ),
                node: genderFocus),
          ]),
        )
      ],
    );
  }

  List<Widget> _buildMailField(User user) {
    return [
      SizedBox(
        height: 20,
      ),
      _buildLabel('E-Mail', false),
      SizedBox(
        height: 4,
      ),
      EditProfileFormWidget(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            user.email,
            style: AppTextStyles.defaultText.copyWith(color: AppColors.hint),
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildLanguageField(User user) {
    return [
      SizedBox(
        height: 20,
      ),
      _buildLabel('Language', false),
      SizedBox(
        height: 4,
      ),
      EditProfileFormWidget(
        child: DropdownButton<String>(
          isExpanded: true,
          underline: Container(),
          value: LocaleBloc.localeName[Locale.fromSubtags(
              countryCode: user.language.split('_')[1],
              languageCode: user.language.split('_')[0])],
          onChanged: (String newValue) {
            setState(() {
              user.language = LocaleBloc.localeName.entries
                  .firstWhere((element) => element.value == newValue)
                  .key
                  .toString();
              print(user.language);
            });
          },
          hint: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              'Select',
              style: AppTextStyles.defaultThinText.copyWith(fontSize: 14),
            ),
          ),
          items: LocaleBloc.localeName.values
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(value),
              ),
            );
          }).toList(),
        ),
      ),
    ];
  }

  Row _buildCountryAndBirthday(User user) {
    return Row(
      children: [
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _buildLabel('Your country', true),
            SizedBox(
              height: 4,
            ),
            EditProfileFormWidget(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: CountryCodePicker(
                  showFlag: false,
                  initialSelection: user.locationCountryCode,
                  showCountryOnly: true,
                  showOnlyCountryWhenClosed: true,
                  textStyle: AppTextStyles.defaultText,
                ),
              ),
            ),
          ]),
        ),
        SizedBox(
          width: 20,
        ),
        _buildBirthdayWidget(user)
      ],
    );
  }

  Expanded _buildBirthdayWidget(User user) {
    return Expanded(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _buildLabel('Birthday', true),
        SizedBox(
          height: 4,
        ),
        EditProfileFormWidget(
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(user.birthday),
              ),
              Theme(
                data: Theme.of(context).copyWith(
                    colorScheme: Theme.of(context)
                        .colorScheme
                        .copyWith(primary: AppColors.primarySwatch),
                    textSelectionColor: Colors.white),
                child: new Builder(
                  builder: (context) => InkWell(
                    onTap: () async {
                      user.birthday = (await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.parse(
                                      '${user.birthday}T00:00:00' ??
                                          '1970-01-01'),
                                  firstDate:
                                      DateTime.parse('1900-01-01T00:00:00'),
                                  lastDate: DateTime.now()))
                              ?.toIso8601String()
                              ?.split('T')[0] ??
                          user.birthday;
                    },
                    child: Container(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }

  Widget _buildLabel(String text, bool isRequired) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(text: text, style: AppTextStyles.defaultText),
        if (isRequired)
          TextSpan(
              text: ' *',
              style: AppTextStyles.defaultText.copyWith(color: Colors.red))
      ]),
    );
  }
}
