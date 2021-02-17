import 'package:flutter/cupertino.dart';
import 'package:new_test/consts/text_styles.dart';
import 'package:new_test/models/product_model.dart';

class ModalWidget extends StatelessWidget {
  final Product product;

  const ModalWidget({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      height: 275,
      width: double.maxFinite,
      decoration: BoxDecoration(color: CupertinoColors.white),
      child: Stack(
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  product.hintTitle,
                  style: ConstTextStyles.constHintTitleStyle,
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  product.hintDescription,
                  style: ConstTextStyles.constHintSubtitleStyle,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Color(0xffEDEFF6),
                  borderRadius: BorderRadius.only(topRight: Radius.circular(8), bottomLeft: Radius.circular(8))
                ),
                child: Icon(
                  CupertinoIcons.xmark,
                  size: 18,
                  color: CupertinoColors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
