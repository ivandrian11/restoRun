import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restorun/common/navigation.dart';
import 'package:restorun/data/api/api_response.dart';
import 'package:restorun/data/model/list_result.dart';
import 'package:restorun/provider/list_provider.dart';
import 'package:restorun/utils/notification_helper.dart';
import 'package:restorun/widget/search_container.dart';
import 'package:restorun/widget/recommended_card.dart';
import 'package:restorun/common/themes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void initState() {
    super.initState();
    _notificationHelper.configureSelectNotificationSubject('/detail');
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Consumer<ListProvider>(
          builder: (context, state, _) {
            switch (state.response.status) {
              case Status.initial:
                return Center(
                  child: Text('Fetching data...'),
                );
              case Status.loading:
                return Center(child: CircularProgressIndicator());
              case Status.error:
                return Center(
                  child: Text(
                    state.response.message!,
                    textAlign: TextAlign.center,
                  ),
                );
              case Status.completed:
                List<Restaurants> restaurants = state.response.data;
                return SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 28),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Hi, Ayy!', style: headerStyle),
                                Text(
                                  'Let\'s explore new restaurant',
                                  style: subhead2Style.copyWith(fontSize: 13),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () => Navigation.intent('/profile'),
                              child: Image.asset(
                                'assets/img/ava.png',
                                height: 48,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        SearchContainer(),
                        SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Recommendation', style: headerStyle),
                            InkWell(
                              onTap: () => Navigation.intent('/list'),
                              child: Text(
                                'See all',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 14,
                                  fontWeight: semiBold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        ListView.builder(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 2,
                          itemBuilder: (context, index) =>
                              RecommendedCard(restaurants[index]),
                        ),
                      ],
                    ),
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
