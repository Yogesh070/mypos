import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerItemList extends StatelessWidget {
  const ShimmerItemList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 18,
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: CircleAvatar(backgroundColor: Colors.grey[100])),
          title: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(height: 20.0, color: Colors.grey[300]),
          ),
        );
      },
    );
  }
}
