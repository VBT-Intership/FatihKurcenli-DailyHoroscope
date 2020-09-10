import 'package:flutter/material.dart';

import '../constant/constant.dart';
import '../model/error_model.dart';
import '../model/horoscope_model.dart';
import '../viewModel/home_page_view_model.dart';

class HomePageView extends HomePageViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: buildFutureBuilderTaskModel(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: Center(
        child: Text(
          "Horoscopes",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  FutureBuilder<List<HoroscopeModel>> buildFutureBuilderTaskModel() {
    return FutureBuilder<List<HoroscopeModel>>(
      future: horoscopeService.getList(),
      builder:
          (BuildContext context, AsyncSnapshot<List<HoroscopeModel>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: buildGridView(snapshot.data),
              );
            } else {
              final error = snapshot.error as ErrorModel;
              return Center(
                child: Text(error.error),
              );
            }
            break;
          default:
            return Text("Something went wrong");
        }
      },
    );
  }

  LayoutBuilder buildGridView(List<HoroscopeModel> city) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      final itemHeight = (width * 0.5) / 0.6;
      final height = constraints.maxHeight + itemHeight;
      return ClipRect(
        child: OverflowBox(
          maxWidth: width,
          minWidth: width,
          maxHeight: height,
          minHeight: height,
          child: GridView.builder(
              padding: EdgeInsets.only(top: itemHeight / 2, bottom: itemHeight),
              itemCount: city.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: AppConstansts.childAspectRatioValue,
                crossAxisSpacing: AppConstansts.crossAxisSpacingValue,
                mainAxisSpacing: AppConstansts.mainAxisSpacingValue,
              ),
              itemBuilder: (context, index) {
                return Transform.translate(
                  offset: Offset(0.0, index.isOdd ? 100 : 0.0),
                  child: buildHoroscope(city[index]),
                );
              }),
        ),
      );
    });
  }

  Card buildHoroscope(HoroscopeModel city) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      shadowColor: Colors.black,
      elevation: 8,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        child: buildColumnTextImage(city),
      ),
    );
  }

  Column buildColumnTextImage(HoroscopeModel city) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: ClipOval(
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                city.imageUrl,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                city.name,
                maxLines: 2,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                city.property,
                maxLines: 4,
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.arrow_forward,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
