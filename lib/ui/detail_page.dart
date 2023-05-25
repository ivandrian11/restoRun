import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restorun/common/navigation.dart';
import 'package:restorun/data/api/api_response.dart';
import 'package:restorun/data/model/detail_result.dart';
import 'package:restorun/data/model/list_result.dart';
import 'package:restorun/provider/database_provider.dart';
import 'package:restorun/provider/detail_provider.dart';
import 'package:restorun/widget/reusable_button.dart';
import '../data/model/restaurant_category.dart';
import '../widget/menu_card.dart';
import '../widget/review_card.dart';
import '../widget/star_icon.dart';
import '../common/themes.dart';

class DetailPage extends StatefulWidget {
  final Restaurants restaurant;

  const DetailPage(this.restaurant, {super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    Future.microtask(() {
      final provider = Provider.of<DetailProvider>(context, listen: false);
      provider.fetchData(widget.restaurant.id!);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DetailProvider>(builder: (context, state, _) {
        switch (state.response.status) {
          case Status.initial:
            return Center(
              child: Text('Fetching data...'),
            );
          case Status.loading:
            return Center(child: CircularProgressIndicator());
          case Status.error:
            return Center(
              child: Text(state.response.message!, textAlign: TextAlign.center),
            );
          case Status.completed:
            Restaurant restaurant = state.response.data;

            List<Widget> getMenus() {
              List<Widget> menus = [
                ...restaurant.menus.foods
                    .map((e) => MenuCard(name: e.name))
                    .toList(),
                ...restaurant.menus.drinks
                    .map((e) => MenuCard(name: e.name, isFood: false))
                    .toList(),
              ];

              return menus;
            }

            return SafeArea(
              child: Stack(
                children: [
                  //? Gambar
                  Consumer<DatabaseProvider>(
                    builder: (context, provider, child) {
                      return FutureBuilder<bool>(
                        future: provider.isFavorited(restaurant.id),
                        builder: (context, snapshot) {
                          var isFavorited = snapshot.data ?? false;
                          return Stack(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height / 2.2,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ReusableButton(
                                      color: Colors.white.withOpacity(0.6),
                                      height: 50,
                                      onPressed: () => Navigation.back(),
                                      child: Icon(Icons.arrow_back),
                                    ),
                                    ReusableButton(
                                      color: Colors.white.withOpacity(0.6),
                                      height: 50,
                                      onPressed: () {},
                                      child: isFavorited
                                          ? IconButton(
                                              onPressed: () =>
                                                  provider.removeFavorite(
                                                      restaurant.id),
                                              icon: Icon(
                                                Icons.favorite,
                                                color: Colors.redAccent,
                                              ),
                                            )
                                          : IconButton(
                                              onPressed: () =>
                                                  provider.addFavorite(
                                                      widget.restaurant),
                                              icon: Icon(
                                                Icons.favorite_outline,
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),

                  //? Scroll
                  DraggableScrollableSheet(
                    initialChildSize: 0.6,
                    minChildSize: 0.6,
                    maxChildSize: 0.85,
                    builder: (_, controller) => Container(
                      decoration: BoxDecoration(
                        color: Color(0xfffafafa),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: ListView(
                        controller: controller,
                        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                        children: [
                          Text(
                            restaurant.name,
                            style: GoogleFonts.playfairDisplay(
                              color: blackColor,
                              fontSize: 28,
                              fontWeight: bold,
                            ),
                          ),
                          SizedBox(height: 8),

                          //? Address & City
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icon/location_icon.svg',
                                width: 20,
                                color: greyColor,
                              ),
                              SizedBox(width: 6),
                              Text(
                                "${restaurant.address}, ${restaurant.city}",
                                style: TextStyle(
                                  color: greyColor,
                                  fontSize: 14,
                                  fontWeight: medium,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),

                          //? Rating
                          Row(
                            children: [
                              StarIcon(isActive: true),
                              SizedBox(width: 8),
                              Text("${restaurant.rating}",
                                  style: headerStyle.copyWith(fontSize: 12)),
                            ],
                          ),
                          SizedBox(height: 24),

                          //? Menu
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: categories
                                .map(
                                  (e) => Flexible(
                                    child: InkWell(
                                      onTap: () =>
                                          state.changeIndex(categoryClicked(e)),
                                      child: Column(
                                        children: [
                                          Text(
                                            e.title,
                                            style: TextStyle(
                                              color: e.isClicked
                                                  ? Color(0xff4A4A4A)
                                                  : greyColor,
                                              fontSize: 14,
                                              fontWeight: bold,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Divider(
                                            color: e.isClicked
                                                ? primaryColor
                                                : secondaryColor,
                                            thickness: 2,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          state.index == 0
                              ? Text(
                                  restaurant.description,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    color: blackColor,
                                    fontSize: 14,
                                  ),
                                )
                              : state.index == 1
                                  ? SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              1.8,
                                      child: GridView.count(
                                        childAspectRatio: 0.8,
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 12,
                                        mainAxisSpacing: 12,
                                        children: getMenus(),
                                      ),
                                    )
                                  : SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              1.8,
                                      child: ListView(
                                          children: restaurant.customerReviews
                                              .map((e) => ReviewCard(
                                                  date: e.date,
                                                  name: e.name,
                                                  review: e.review))
                                              .toList()),
                                    ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
        }
      }),
    );
  }
}
