import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:restorun/common/navigation.dart';
import 'package:restorun/data/api/api_response.dart';
import 'package:restorun/data/model/list_result.dart';
import 'package:restorun/provider/search_provider.dart';
import 'package:restorun/widget/list_card.dart';
import 'package:restorun/common/themes.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchC = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    searchC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          padding: EdgeInsets.zero,
          icon: SvgPicture.asset(
            'assets/icon/cancel_icon.svg',
            height: iconSize2,
          ),
          onPressed: () => Navigation.back(),
        ),
      ],
    );

    Widget missingIllustration = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icon/search_illustration.svg',
            height: 100,
          ),
          const SizedBox(height: 24),
          const Text(
            'Sorry we couldn’t find\nany matches',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Consumer<SearchProvider>(builder: (context, state, _) {
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

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Search',
                      style: TextStyle(
                        color: Color(0xff232323),
                        fontSize: 32,
                        fontWeight: bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Find your best restaurantss.',
                      style: TextStyle(
                        color: Color(0xff717489),
                        fontSize: 14,
                        fontWeight: medium,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: searchC,
                      onEditingComplete: () {
                        state.fetchData(searchC.text);
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      style: const TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                          onTap: () {
                            searchC.clear();
                          },
                          child: Icon(
                            Icons.close,
                            color: iconColor,
                            size: iconSize,
                          ),
                        ),
                        hintText: 'Search here',
                        hintStyle: const TextStyle(
                          color: Color(0xffAAAAAA),
                          fontSize: 16,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: iconColor,
                          size: iconSize,
                        ),
                        focusedBorder: chooseColorBorder(primaryColor),
                        enabledBorder: chooseColorBorder(
                          const Color(0xffdedede),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    restaurants.isNotEmpty
                        ? RichText(
                            text: TextSpan(
                              text: 'Found ${restaurants.length} results of ',
                              style: TextStyle(
                                color: iconColor,
                                fontSize: 14,
                                fontWeight: medium,
                              ),
                              children: [
                                TextSpan(
                                  text: searchC.text,
                                  style: TextStyle(
                                    fontWeight: bold,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),
                    SizedBox(height: 8),
                    Expanded(
                      child: restaurants.isNotEmpty
                          ? ListView(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              children:
                                  restaurants.map((e) => ListCard(e)).toList(),
                            )
                          : missingIllustration,
                    ),
                  ],
                );
            }
          }),
        ),
      ),
    );
  }
}
