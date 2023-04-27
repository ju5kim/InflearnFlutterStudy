import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_feat_infrun/common/const/CustomColors.dart';
import 'package:flutter_study_feat_infrun/common/const/data.dart';

import '../model/product_model.dart';

class ProductWidget extends StatelessWidget implements Product {
  final id;
  final name;
  final imgUrl;
  final detail;
  final price;

  const ProductWidget(
      {Key? key,
      required this.id,
      required this.name,
      required this.imgUrl,
      required this.detail,
      required this.price})
      : super(key: key);

  factory ProductWidget.fromsnapshot({required Map<String, dynamic> snapshot}) {
    return ProductWidget(
      id: snapshot['id'],
      name: snapshot['name'],
      imgUrl: snapshot['imgUrl'],
      detail: snapshot['detail'],
      price: snapshot['price'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            child: Image.network(
              "http://$ip$imgUrl",
              fit: BoxFit.cover,
              width: 110,
              height: 110,
            ),
          ),
          SizedBox(
            width: 8.0,
          ),
          Expanded(
              child: Container(
            height: 110,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
                ),
                Text(
                  detail,
                  maxLines: 2,
                  style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: BODY_TEXT_COLOR,
                      fontSize: 14.0),
                ),
                Text(
                  price.toString(),
                  style: TextStyle(color: PRIMARY_COLOR),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
//"products": [
//     {
//       "id": "1952a209-7c26-4f50-bc65-086f6e64dbbd",
//       "name": "마라맛 코팩 떡볶이",
//       "imgUrl": "/img/img.png",
//       "detail": "서울에서 두번째로 맛있는 떡볶이집! 리뷰 이벤트 진행중~",
//       "price": 8000
//     }
//   ]
