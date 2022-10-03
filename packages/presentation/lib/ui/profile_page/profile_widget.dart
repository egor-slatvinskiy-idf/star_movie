import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/base/bloc_screen.dart';
import 'package:presentation/base/tile_wrapper.dart';
import 'package:presentation/colors_application/colors_application.dart';
import 'package:presentation/generated/l10n.dart';
import 'package:presentation/library/dimens/dimens.dart';
import 'package:presentation/library/images_utils/images_utils.dart';
import 'package:presentation/library/style/text_style.dart';
import 'package:presentation/navigation/base_page.dart';
import 'package:presentation/ui/profile_page/bloc/profile_bloc.dart';
import 'package:presentation/ui/profile_page/bloc/profile_tile.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  static const _routeName = '/ProfileWidget';

  static BasePage page() => BasePage(
        key: const ValueKey(_routeName),
        name: _routeName,
        builder: (context) => const ProfileWidget(),
        showSlideAnim: true,
        showBottomBar: true,
      );

  @override
  State createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends BlocScreenState<ProfileWidget, ProfileBloc> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TileWrapper<ProfileTile>>(
      stream: bloc.dataStream,
      builder: (_, snapshot) {
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
            title: Padding(
              padding: const EdgeInsets.only(
                left: Dimens.size12,
              ),
              child: Text(
                S.of(context).profile,
                style: TextStyles.sfProSemi24(
                  color: ColorsApplication.colorTitle,
                ),
              ),
            ),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.size26),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).userName,
                    style: TextStyles.sfProMed12(
                      color: ColorsApplication.colorProfileTitle,
                    ),
                  ),
                  const SizedBox(height: Dimens.size8),
                  TextField(
                    cursorColor: Colors.white,
                    style: const TextStyle(color: ColorsApplication.colorTitle),
                    decoration: InputDecoration(
                      prefixIcon: SvgPicture.asset(
                        ImagesUtils.profile,
                        width: Dimens.size18,
                        height: Dimens.size18,
                        fit: BoxFit.none,
                      ),
                      filled: true,
                      fillColor: ColorsApplication.colorTextField,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: Dimens.size10,
                      ),
                    ),
                  ),
                  const SizedBox(height: Dimens.size20),
                  Text(
                    S.of(context).password,
                    style: TextStyles.sfProMed12(
                      color: ColorsApplication.colorProfileTitle,
                    ),
                  ),
                  const SizedBox(height: Dimens.size8),
                  TextField(
                    obscureText: true,
                    autocorrect: false,
                    enableSuggestions: false,
                    cursorColor: Colors.white,
                    style: const TextStyle(
                      color: ColorsApplication.colorTitle,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: SvgPicture.asset(
                        ImagesUtils.lock,
                        width: Dimens.size18,
                        height: Dimens.size18,
                        fit: BoxFit.none,
                      ),
                      filled: true,
                      fillColor: ColorsApplication.colorTextField,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: Dimens.size10,
                      ),
                    ),
                  ),
                  const SizedBox(height: Dimens.size20),
                  SizedBox(
                    width: Dimens.sizeInfinity,
                    height: Dimens.size48,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          ColorsApplication.primaryColor,
                        ),
                      ),
                      child: Text(
                        S.of(context).login,
                        style: TextStyles.sfProSemi16(),
                      ),
                    ),
                  ),
                  const SizedBox(height: Dimens.size50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: Dimens.size44,
                        height: Dimens.size44,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              ColorsApplication.colorFaceBook,
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(44),
                              ),
                            ),
                          ),
                          child: SvgPicture.asset(
                            ImagesUtils.facebook,
                            width: Dimens.size18,
                            height: Dimens.size18,
                            fit: BoxFit.none,
                          ),
                        ),
                      ),
                      const SizedBox(width: Dimens.size24),
                      SizedBox(
                        width: Dimens.size44,
                        height: Dimens.size44,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              ColorsApplication.colorGoogle,
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  Dimens.size44,
                                ),
                              ),
                            ),
                          ),
                          child: SvgPicture.asset(
                            ImagesUtils.google,
                            width: Dimens.size44,
                            height: Dimens.size44,
                            fit: BoxFit.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
