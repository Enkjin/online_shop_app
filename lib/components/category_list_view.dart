import 'package:flutter/material.dart';
import 'package:online_shop_app/components/category_list_item.dart';

class CategoryListView extends StatelessWidget {
  const CategoryListView(
      {Key? key, required this.categories, required this.onCategorySelected})
      : super(key: key);
  final List<String> categories;
  final Function(String) onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        physics: AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return CategoryListItem(
            title: categories[index],
            imageUr: 'https://picsum.photos/id/${index + 100}/100/100',
            onTap: () {
              onCategorySelected(categories[index]);
            },
          );
        },
      ),
    );
  }
}
