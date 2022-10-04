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
import 'package:presentation/ui/auth_page/bloc/auth_bloc.dart';
import 'package:presentation/ui/auth_page/bloc/auth_tile.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({super.key});

  static const _routeName = '/AuthWidget';

  static BasePage page() => BasePage(
        key: const ValueKey(_routeName),
        name: _routeName,
        builder: (context) => const AuthWidget(),
        showSlideAnim: true,
        showBottomBar: true,
      );

  @override
  State createState() => _AuthWidgetState();
}

class _AuthWidgetState extends BlocScreenState<AuthWidget, AuthBloc> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TileWrapper<AuthTile>>(
      stream: bloc.dataStream,
      builder: (_, snapshot) {
        final data = snapshot.data;
        final tile = data?.data;
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
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _FormWidget(
                bloc: bloc,
                errorMessage: tile?.errorMessage,
                data: data,
              ),
              const SizedBox(height: Dimens.size50),
              _SocialButtonWidgets(bloc: bloc),
            ],
          ),
        );
      },
    );
  }
}

class _FormWidget extends StatelessWidget {
  final AuthBloc bloc;
  final String? errorMessage;
  final TileWrapper? data;

  const _FormWidget({
    required this.bloc,
    required this.errorMessage,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.size26),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ErrorMessageWidget(
              errorMessage: errorMessage ?? '',
            ),
            Text(
              S.of(context).userName,
              style: TextStyles.sfProMed12(
                color: ColorsApplication.colorProfileTitle,
              ),
            ),
            const SizedBox(height: Dimens.size8),
            TextField(
              controller: bloc.textLoginController,
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
              controller: bloc.textPasswordController,
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
              ),
            ),
            const SizedBox(height: Dimens.size20),
            _LoginButtonWidget(
              bloc: bloc,
              data: data,
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialButtonWidgets extends StatelessWidget {
  final AuthBloc bloc;

  const _SocialButtonWidgets({
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: Dimens.size44,
          height: Dimens.size44,
          child: ElevatedButton(
            onPressed: () => bloc.authFacebook(),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                ColorsApplication.colorFacebook,
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimens.size44),
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
            onPressed: () => bloc.authGoogle(),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                ColorsApplication.colorGoogle,
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
    );
  }
}

class _LoginButtonWidget extends StatelessWidget {
  final AuthBloc bloc;
  final TileWrapper? data;

  const _LoginButtonWidget({
    required this.bloc,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Dimens.sizeInfinity,
      height: Dimens.size48,
      child: ElevatedButton(
        onPressed: () => bloc.auth(),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            ColorsApplication.primaryColor,
          ),
        ),
        child: data?.isLoading == true
            ? const SizedBox(
                width: Dimens.size30,
                height: Dimens.size30,
                child: CircularProgressIndicator(
                  color: ColorsApplication.colorTitle,
                ),
              )
            : Text(
                S.of(context).login,
                style: TextStyles.sfProSemi16(),
              ),
      ),
    );
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  final String? errorMessage;

  const _ErrorMessageWidget({required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    if (errorMessage!.isEmpty || errorMessage == null) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimens.size20),
      child: Text(
        errorMessage!,
        style: TextStyles.sfProMed18(color: ColorsApplication.primaryColor),
      ),
    );
  }
}
