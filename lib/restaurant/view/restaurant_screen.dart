import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_feat_infrun/common/const/data.dart';
import 'package:flutter_study_feat_infrun/restaurant/component/restaurant_card.dart';
import 'package:flutter_study_feat_infrun/restaurant/model/restaurant_model.dart';
import 'package:flutter_study_feat_infrun/restaurant/view/restaurant_detail_screen.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  Future<List> getRestaurantList() async {
    print(ip);
    String? accesstoken =
        await SECURE_STORAGE.read(key: ACCESS_TOKEN_LOCAL_KEY);
    final responsed = await dio.get("http://$ip/restaurant",
        options: Options(headers: {"authorization": "Bearer $accesstoken"}));
    List restaurantList = responsed.data['data'];
    return restaurantList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder(
            future: getRestaurantList(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (!snapshot.hasData) {
                return Container();
              } else {
                return ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      var oneResItem = snapshot.data![index];
                      print(oneResItem); // Map<String,dynamic> 타입
                      RestaurantModel item =
                          RestaurantModel.formJson(item: oneResItem);

                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) =>
                                  RestaurantDetailScreen(id: item.id)));
                        },
                        child: RestaurantCard.formRestaurantModel(
                          model: item,
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 16.0,
                      );
                    },
                    itemCount: snapshot.data!.length);
              }
            },
          ),
        ),
      ),
    );
  }
}
