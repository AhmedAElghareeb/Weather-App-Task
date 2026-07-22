import 'package:base_structure/src/core/utils/app_theme/app_colors.dart';
import 'package:base_structure/src/core/utils/app_theme/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToggleThemeButton extends StatelessWidget {
  const ToggleThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return SizedBox(
          height: 30,
          width: 45,
          child: FittedBox(
            child: CupertinoSwitch(
              value: themeState.themeMode == ThemeMode.dark,
              onChanged: (bool value) =>
                  context.read<ThemeCubit>().toggleTheme(),
              activeTrackColor: AppColors.primary,
              inactiveTrackColor: AppColors.grey,
            ),
          ),
        );
      },
    );
  }
}
