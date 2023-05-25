import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:restorun/common/navigation.dart';
import 'package:restorun/common/themes.dart';
import 'package:restorun/provider/preferences_provider.dart';
import 'package:restorun/provider/scheduling_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigation.back(),
          icon: SvgPicture.asset('assets/icon/back_icon.svg'),
        ),
        title: Text('Profile', style: customAppbarStyle),
      ),
      body: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('Scheduling'),
                trailing: Consumer<SchedulingProvider>(
                  builder: (context, scheduled, _) => Switch(
                    activeColor: primaryColor,
                    value: provider.isDailyNotifActive,
                    onChanged: (value) async {
                      scheduled.scheduledNews(value);
                      provider.enableDailyNotif(value);
                    },
                  ),
                ),
              ),
              ListTile(
                onTap: () => Navigation.intent('/favorite'),
                contentPadding: EdgeInsets.zero,
                title: Text('Favorite'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ],
          );
        },
      ),
    );
  }
}
