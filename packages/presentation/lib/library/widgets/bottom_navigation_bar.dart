import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/app/app_bloc.dart';
import 'package:presentation/colors_application/colors_application.dart';
import 'package:presentation/library/dimens/dimens.dart';
import 'package:presentation/library/images_utils/images_utils.dart';

const _emptyString = '';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({
    required this.appData,
    required this.bloc,
    super.key,
  });

  final dynamic appData;
  final AppBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: ColorsApplication.colorBorder,
            width: Dimens.size1,
          ),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: appData.selectedTab,
        selectedFontSize: Dimens.size12,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(ImagesUtils.movieReel),
            label: _emptyString,
            activeIcon: SvgPicture.asset(
              ImagesUtils.movieReel,
              color: ColorsApplication.colorSelectedItem,
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(ImagesUtils.eventTicket),
            label: _emptyString,
            activeIcon: SvgPicture.asset(
              ImagesUtils.eventTicket,
              color: ColorsApplication.colorSelectedItem,
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(ImagesUtils.alarm),
            label: _emptyString,
            activeIcon: SvgPicture.asset(
              ImagesUtils.alarm,
              color: ColorsApplication.colorSelectedItem,
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(ImagesUtils.single),
            label: _emptyString,
            activeIcon: SvgPicture.asset(
              ImagesUtils.single,
              color: ColorsApplication.colorSelectedItem,
            ),
          ),
        ],
        onTap: bloc.onSelectedTab,
      ),
    );
  }
}
