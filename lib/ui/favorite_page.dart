import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:restorun/common/navigation.dart';
import 'package:restorun/data/api/api_response.dart';
import 'package:restorun/data/model/list_result.dart';
import 'package:restorun/provider/database_provider.dart';
import 'package:restorun/common/themes.dart';
import 'package:restorun/widget/list_card.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigation.back(),
            icon: SvgPicture.asset('assets/icon/back_icon.svg'),
          ),
          title: Text('Favorite', style: customAppbarStyle),
        ),
        body: Consumer<DatabaseProvider>(
          builder: (context, state, child) {
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
                final List<Restaurants> restaurants = state.response.data;
                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  itemBuilder: (context, index) => ListCard(restaurants[index]),
                  itemCount: restaurants.length,
                );
            }
          },
        ));
  }
}
