import 'package:flutter/material.dart';
import 'package:presentation/base/bloc_screen.dart';
import 'package:presentation/colors_application/colors_application.dart';
import 'package:presentation/library/dimens/dimens.dart';
import 'package:presentation/navigation/base_page.dart';
import 'package:presentation/ui/profile_page/bloc/profile_bloc.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  static const _routeName = '/ProfileWidget';

  static BasePage page() => BasePage(
        key: const ValueKey(_routeName),
        name: _routeName,
        builder: (context) => const ProfileWidget(),
        showSlideAnim: true,
        showBottomBar: false,
      );

  @override
  State createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends BlocScreenState<ProfileWidget, ProfileBloc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApplication.colorTheme,
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(Dimens.size1),
          child: Container(
            color: ColorsApplication.colorBorder,
            height: Dimens.size1,
          ),
        ),
        elevation: Dimens.size0,
      ),
    );
  }
}
