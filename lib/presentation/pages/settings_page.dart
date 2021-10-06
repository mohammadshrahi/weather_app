import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/blocs/settings/bloc/settings_bloc.dart';
import 'package:weather_app/presentation/widgets/horizontal_space.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('home.setting'.tr()),
        ),
        body: BlocListener<SettingsBloc, SettingsState>(
            listener: (context, state) {},
            child: BlocBuilder<SettingsBloc, SettingsState>(
                builder: (context, state) {
              return _buildSettingsPage(
                  (state as SettingsSuccessState).setting.isKalvin, context);
            })));
  }

  Container _buildSettingsPage(bool isKalvin, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          _buildCheckBox('settings.kalvin'.tr(), isKalvin, context,
              onChanged: (value) {
            BlocProvider.of<SettingsBloc>(context).setSettingState(value);
          }),
          _buildCheckBox('settings.celsius'.tr(), !isKalvin, context,
              onChanged: (value) {
            BlocProvider.of<SettingsBloc>(context).setSettingState(!value);
          })
        ],
      ),
    );
  }

  Widget _buildCheckBox(String text, bool value, BuildContext context,
      {Function? onChanged}) {
    return Row(
      children: [
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(color: Colors.black),
        ),
        const HorizontalSpace(5),
        Checkbox(
            value: value,
            onChanged: (value) {
              onChanged?.call(value);
            })
      ],
    );
  }
}
