import 'package:flutter/material.dart';
import 'package:new_test/consts/paddings.dart';
import 'package:new_test/consts/text_styles.dart';
import 'package:new_test/models/category_model.dart';

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343,
      height: 84,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: ConstPaddings.constCardContentPadding,
            child: Column(
              children: [
                Text(
                  category.name,
                  style: ConstTextStyles.constCategoryTitle,
                ),
                Text(category.description),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            width: 114,
            height: double.maxFinite,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              child: Image(
                fit: BoxFit.fill,
                image:
                    NetworkImage('https://api.doover.tech${category.picture}'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
