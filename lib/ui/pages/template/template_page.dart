import 'package:flutter_starter/bloc/auth/authorization_bloc.dart';
import 'package:flutter_starter/data/repositories/auth_repository.dart';
import 'package:flutter_starter/data/repositories/user_repository.dart';
import 'package:flutter_starter/ui/pages/template/cubit/template_cubit.dart';
import 'package:flutter_starter/ui/pages/template/widgets/template.dart';
import 'package:flutter_starter/ui/widgets/custom_appbar.dart';
import 'package:flutter_starter/utils/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TemplatePage extends StatelessWidget {
  final String title;

  const TemplatePage(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(
        title: title,
        onActionClick: () => logout(context)),
      body: BlocProvider(
        create: (_) => TemplateCubit(context.repository<AuthRepository>(),
            context.repository<UserRepository>()),
        child: TemplateWidget(title),
      ),
    );
  }
}
