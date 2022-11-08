import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/app/app_bloc.dart';
import 'package:presentation/colors_application/colors_application.dart';
import 'package:presentation/library/const/constants.dart';
import 'package:presentation/library/dimens/dimens.dart';
import 'package:presentation/library/images_utils/images_utils.dart';

class NavigationRailWidget extends StatelessWidget {
  final dynamic appData;
  final AppBloc bloc;

  const NavigationRailWidget({
    required this.appData,
    required this.bloc,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      minWidth: Dimens.size30W,
      backgroundColor: ColorsApplication.colorDrawer,
      selectedIndex: appData.selectedTab,
      onDestinationSelected: bloc.onSelectedTab,
      destinations: [
        NavigationRailDestination(
          icon: SvgPicture.asset(ImagesUtils.movieReel),
          label: const Text(Constants.emptyString),
          selectedIcon: SvgPicture.asset(
            ImagesUtils.movieReel,
            color: ColorsApplication.colorSelectedItem,
          ),
        ),
        NavigationRailDestination(
          icon: SvgPicture.asset(ImagesUtils.eventTicket),
          label: const Text(Constants.emptyString),
          selectedIcon: SvgPicture.asset(
            ImagesUtils.eventTicket,
            color: ColorsApplication.colorSelectedItem,
          ),
        ),
        NavigationRailDestination(
          icon: SvgPicture.asset(ImagesUtils.alarm),
          label: const Text(Constants.emptyString),
          selectedIcon: SvgPicture.asset(
            ImagesUtils.alarm,
            color: ColorsApplication.colorSelectedItem,
          ),
        ),
        NavigationRailDestination(
          icon: SvgPicture.asset(ImagesUtils.single),
          label: const Text(Constants.emptyString),
          selectedIcon: SvgPicture.asset(
            ImagesUtils.single,
            color: ColorsApplication.colorSelectedItem,
          ),
        ),
      ],
    );
  }
}
