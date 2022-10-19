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
  final TileWrapper? data;

  const _FormWidget({
    required this.bloc,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.size26),
        child: Column(
          children: [
            Form(
              key: bloc.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).userName,
                    style: TextStyles.sfProMed12(
                      color: ColorsApplication.colorProfileTitle,
                    ),
                  ),
                  const SizedBox(height: Dimens.size8),
                  _TextFormField(
                    validator: bloc.validatorLogin,
                    textEditingController: bloc.textLoginController,
                    obscureText: false,
                    icon: ImagesUtils.profile,
                  ),
                  const SizedBox(height: Dimens.size20),
                  Text(
                    S.of(context).password,
                    style: TextStyles.sfProMed12(
                      color: ColorsApplication.colorProfileTitle,
                    ),
                  ),
                  const SizedBox(height: Dimens.size8),
                  _TextFormField(
                    validator: bloc.validatorPassword,
                    textEditingController: bloc.textPasswordController,
                    obscureText: true,
                    icon: ImagesUtils.lock,
                  ),
                ],
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

class _TextFormField extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController? textEditingController;
  final bool obscureText;
  final String icon;

  const _TextFormField({
    required this.validator,
    required this.textEditingController,
    required this.obscureText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: textEditingController,
      cursorColor: ColorsApplication.colorTitle,
      obscureText: obscureText,
      style: const TextStyle(color: ColorsApplication.colorTitle),
      decoration: InputDecoration(
        prefixIcon: SvgPicture.asset(
          icon,
          width: Dimens.size18,
          height: Dimens.size18,
          fit: BoxFit.none,
        ),
        filled: true,
        fillColor: ColorsApplication.colorTextField,
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
            onPressed: bloc.authFacebook,
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
            onPressed: bloc.authGoogle,
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
        onPressed: bloc.auth,
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
