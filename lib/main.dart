import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:snapd/snapd.dart';
import 'package:software/l10n/l10n.dart';
import 'package:software/pages/explore/explore_page.dart';
import 'package:software/pages/my_apps/my_apps_page.dart';
import 'package:software/pages/settings/settings_page.dart';
import 'package:software/pages/updates/updates_page.dart';
import 'package:ubuntu_service/ubuntu_service.dart';
import 'package:yaru/yaru.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

void main() async {
  registerService<SnapdClient>(SnapdClient.new, dispose: (s) => s.close());
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: TouchMouseStylusScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: 'Ubuntu Software App',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateTitle: (context) => context.l10n.appTitle,
      routes: {
        Navigator.defaultRouteName: (context) => const YaruTheme(
              child: Scaffold(
                body: YaruCompactLayout(
                  pageItems: [
                    YaruPageItem(
                      titleBuilder: ExplorePage.createTitle,
                      builder: ExplorePage.create,
                      iconData: YaruIcons.compass,
                    ),
                    YaruPageItem(
                      titleBuilder: MyAppsPage.createTitle,
                      builder: MyAppsPage.create,
                      iconData: YaruIcons.ok,
                    ),
                    YaruPageItem(
                      titleBuilder: UpdatesPage.createTitle,
                      builder: UpdatesPage.create,
                      iconData: YaruIcons.synchronizing,
                    ),
                    YaruPageItem(
                      titleBuilder: SettingsPage.createTitle,
                      builder: SettingsPage.create,
                      iconData: YaruIcons.settings,
                    )
                  ],
                ),
              ),
            ),
      },
    );
  }
}

class TouchMouseStylusScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus
      };
}
