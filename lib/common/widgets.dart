import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// A widget made for the purpose of perfect layout
Widget textRow(
    String title,
    String content,
    ) {
  return ClipRect(
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Text(
                  ':',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: Text(
              content,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ),
  );
}


/// A widget made for Shimmer effect
Widget buildShimmer() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 100,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.4)
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 50,
            width: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.4)
            ),
          ),
          const SizedBox(height: 50),
          Container(
            height: 300,
            width: 500,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.4)
            ),
          ),
        ],
      ),
    ),
  );
}
