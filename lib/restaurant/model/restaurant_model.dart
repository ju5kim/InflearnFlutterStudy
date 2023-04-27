import 'package:flutter_study_feat_infrun/common/const/data.dart';

class RestaurantModel {
  final id;
  final name;
  final thumbUrl;
  final List<String> tags;
  final priceRange;
  final ratings;
  final ratingsCount;
  final deliveryTime;
  final deliveryFee;
  RestaurantModel({
    required this.id,
    required this.name,
    required this.thumbUrl,
    required this.tags,
    required this.priceRange,
    required this.ratings,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
  });

  factory RestaurantModel.formJson({required Map<String, dynamic> item}) {
    String checkpriceRange(String pricerange) {
      var result = PRICERANGES.values.contains(pricerange);
      if (result) {
        return pricerange;
      }
      return "가격 비교 값이 업습니다.";
    }

    return RestaurantModel(
        id: item['id'],
        name: item['name'],
        thumbUrl: "http://$ip${item['thumbUrl']}",
        tags: List<String>.from(item['tags']),
        priceRange: checkpriceRange(item['priceRange']),
        ratings: item['ratings'],
        ratingsCount: item['ratingsCount'],
        deliveryTime: item['deliveryTime'],
        deliveryFee: item['deliveryFee']);
  }
}

enum PRICERANGES { expensive, medium, cheap }
// return RestaurantCard(
// cardImage: Image.network(
// //서버나 외부에 저장된 url로 이미지부르기
// "http://$ip${oneResItem['thumbUrl']}", // String 으로 url을 먼저 입력한다.
// fit: BoxFit.cover,
// ),
// restaurantName: snapshot.data![index]['name'],
// tags: List<String>.from(oneResItem['tags']),
// raitingCount:
// oneResItem['ratingsCount'], // 아이템을 위에서 가지고 와서 쓰기
//
// deliveryTime: snapshot.data![index]
// ['deliveryTime'], //여기서 그냥 하나씩 불러서 쓰기
// deliveryFree: oneResItem['deliveryFee'],
// rating: oneResItem['ratings']
// );
