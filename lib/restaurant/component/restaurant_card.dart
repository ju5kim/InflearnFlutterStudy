import 'package:flutter/material.dart';
import 'package:flutter_study_feat_infrun/common/const/CustomColors.dart';
import 'package:flutter_study_feat_infrun/product/model/product_model.dart';
import 'package:flutter_study_feat_infrun/restaurant/model/restaurant_model.dart';

import '../../common/const/data.dart';

class RestaurantCard extends StatelessWidget {
  final Widget cardImage;
  final String restaurantName;
  final List<String> tags;
  final int raitingCount;
  final int deliveryTime;
  final int deliveryFree;
  final double rating;
  final bool isdetailcard;
  final String? detail;
  final List<Map>? products;

  const RestaurantCard(
      {Key? key,
      required this.cardImage,
      required this.restaurantName,
      required this.tags,
      required this.raitingCount,
      required this.deliveryTime,
      required this.deliveryFree,
      required this.rating,
      this.isdetailcard = false,
      this.detail,
      this.products})
      : super(key: key);

  factory RestaurantCard.formRestaurantModel({required RestaurantModel model}) {
    return RestaurantCard(
      cardImage: Image.network(
        //서버나 외부에 저장된 url로 이미지부르기
        model.thumbUrl, // String 으로 url을 먼저 입력한다.
        fit: BoxFit.cover,
      ),
      restaurantName: model.name,
      tags: model.tags,
      raitingCount: model.ratingsCount,
      // 아이템을 위에서 가지고 와서 쓰기
      deliveryTime: model.deliveryTime,
      deliveryFree: model.deliveryFee,
      rating: model.ratings,
    );
  }

  factory RestaurantCard.fromSnapshot({required AsyncSnapshot snapshot}) {
    return RestaurantCard(
      isdetailcard: true,
      detail: snapshot.data!['detail'],
      cardImage: Image.network(
        "http://$ip${snapshot.data!['thumbUrl']}",
        fit: BoxFit.cover,
      ),
      restaurantName: snapshot.data!['name'],
      tags: List<String>.from(snapshot.data!['tags']),
      raitingCount: snapshot.data!['ratingsCount'],
      deliveryTime: snapshot.data!['deliveryTime'],
      deliveryFree: snapshot.data!['deliveryFee'],
      rating: snapshot.data!['ratings'],
      products: List<Map<String, dynamic>>.from(snapshot.data!['products']),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!isdetailcard)
          ClipRRect(
            //이게 이미지를 잘라서 포멧하는 것
            borderRadius: BorderRadius.horizontal(
                left: Radius.circular(14.0), right: Radius.circular(14.0)),
            child: cardImage,
          ),
        if (isdetailcard) cardImage,
        const SizedBox(
          height: 18.0,
        ),
        Padding(
          padding: isdetailcard
              ? EdgeInsets.symmetric(horizontal: 18.0)
              : EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                restaurantName,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                tags.join(" · "),
                style: TextStyle(fontSize: 14.0, color: BODY_TEXT_COLOR),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Row(
                children: [
                  _IconText(icon: Icons.star, label: rating.toString()),
                  Text(renderdot()),
                  _IconText(
                      icon: Icons.receipt, label: raitingCount.toString()),
                  Text(renderdot()),
                  _IconText(
                      icon: Icons.timelapse_outlined, label: "$deliveryTime 분"),
                  Text(renderdot()),
                  _IconText(
                      icon: Icons.monetization_on,
                      label:
                          deliveryFree == 0 ? "무료" : deliveryFree.toString()),
                ],
              ),
              if (isdetailcard && detail != null && detail!.isNotEmpty)
                SizedBox(
                  height: 10.0,
                ),
              if (isdetailcard && detail != null && detail!.isNotEmpty)
                Text(detail!),
            ],
          ),
        ),
      ],
    );
  }
}

class _IconText extends StatelessWidget {
  final IconData icon;
  final String label;

  const _IconText({Key? key, required this.icon, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: PRIMARY_COLOR,
          size: 14.0,
        ),
        SizedBox(
          width: 4.0,
        ),
        Text(
          label,
          style: TextStyle(color: BODY_TEXT_COLOR, fontSize: 14.0),
        )
      ],
    );
  }
}

String renderdot() {
  return " · ";
}
