import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_study_feat_infrun/common/const/CustomColors.dart';
import 'package:flutter_study_feat_infrun/common/const/data.dart';
import 'package:flutter_study_feat_infrun/common/layout/default_layout.dart';
import 'package:flutter_study_feat_infrun/restaurant/component/restaurant_card.dart';

import '../../product/component/product_widget.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final id;

  const RestaurantDetailScreen({Key? key, required this.id}) : super(key: key);

  Future<Map<String, dynamic>> getRestaurant() async {
    try {
      var dio = Dio();
      var accessToken = await SECURE_STORAGE.read(key: ACCESS_TOKEN_LOCAL_KEY);
      var response = await dio.get("http://$ip/restaurant/$id",
          options: Options(headers: {"authorization": "Bearer $accessToken"}));
      print("디테일에서 가지고온 response.data ===>");
      print(response);
      return response.data;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getRestaurant(),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (!snapshot.hasData) return Container();
        return DefaultLayout(
          title: snapshot.data!['name'],
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: RestaurantCard.fromSnapshot(snapshot: snapshot),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 16.0,
                ),
              ),
              SliverToBoxAdapter(
                child: Text(
                  "- 메 뉴 -",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(bottom: 8.0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 10.0),
                        child: ProductWidget.fromsnapshot(
                            snapshot: List<Map<String, dynamic>>.from(
                                    snapshot.data!['products'])
                                .elementAt(index)),
                      );
                    },
                    childCount:
                        List<Map>.from(snapshot.data!['products']).length,
                  ),
                ),
              ),
            ], // Slivers
          ),
        );
      },
    );
  }
}
//"products": [ 리스트
//         { 맵
//             "id": "2c83ed91-c2f8-49c1-8641-6cbeb15e21ed",
//             "restaurant": { 맵
//                 "id": "5ac83bfb-f2b5-55f4-be3c-564be3f01a5b",
//                 "name": "불타는 떡볶이",
//                 "thumbUrl": "/img/떡볶이/떡볶이.jpg",
//                 "tags": [
//                     "떡볶이",
//                     "치즈",
//                     "매운맛"
//                 ],
//                 "priceRange": "medium",
//                 "ratings": 5,
//                 "ratingsCount": 100,
//                 "deliveryTime": 15,
//                 "deliveryFee": 2000
//             },
