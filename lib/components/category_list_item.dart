import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryListItem extends StatelessWidget {
  const CategoryListItem(
      {Key? key,
      required this.title,
      this.onTap,
      required this.imageUr,
      this.isSelected = false})
      : super(key: key);

  final String title;
  final void Function()? onTap;
  final String imageUr;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          height: 100,
          width: 120,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: isSelected
                      ? Border.all(color: Colors.deepPurple, width: 2)
                      : null,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    image: NetworkImage(imageUr),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                title,
                style: GoogleFonts.lato(
                    fontWeight: FontWeight.w600, fontSize: 16.0),
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.clip,
              ),
            ],
          ),
        ));
  }
}
