import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:restorun/common/navigation.dart';
import 'package:restorun/provider/list_provider.dart';
import 'package:restorun/widget/grid_card.dart';
import 'package:restorun/common/themes.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ListProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigation.back(),
          icon: SvgPicture.asset('assets/icon/back_icon.svg'),
        ),
        title: Text('Where to eat?', style: customAppbarStyle),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.9,
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        itemCount: provider.response.data.length,
        itemBuilder: (_, index) => GridCard(provider.response.data[index]),
      ),
    );
  }
}
