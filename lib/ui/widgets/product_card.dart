import 'package:flutter/cupertino.dart';
import 'package:new_test/consts/paddings.dart';
import 'package:new_test/consts/text_styles.dart';
import 'package:new_test/models/product_model.dart';
import 'package:new_test/ui/widgets/modal_widget.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final bool isHided = true;

  const ProductCard({Key key, this.product}) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343,
      height: 102,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: CupertinoColors.white),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(8),
            ),
            child: Image(
              image: NetworkImage(
                  'https://api.doover.tech${widget.product.picture.toString()}'),
            ),
          ),
          Container(
            padding: ConstPaddings.constCardContentPadding,
            width: 190,
            height: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  widget.product.name,
                  style: ConstTextStyles.constItemTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: 'Срок стирки/ ',
                        style: TextStyle(
                            color: CupertinoColors.systemGrey, fontSize: 12)),
                    TextSpan(
                        text:
                            '${Duration(seconds: widget.product.duration.toInt()).inDays} день',
                        style:
                            TextStyle(color: Color(0xff172853), fontSize: 12))
                  ]),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      child: Icon(
                        CupertinoIcons.plus_circled,
                        color: Color(0xff172853),
                      ),
                      onTap: () {
                        setState(() {
                          counter++;
                        });
                      },
                    ),
                    SizedBox(width: 12),
                    Text(
                      counter.toString(),
                      style: TextStyle(color: Color(0xff172853), fontSize: 14),
                    ),
                    SizedBox(width: 12),
                    Offstage(
                      offstage: counter > 0
                          ? (widget.isHided == false)
                          : (widget.isHided == true),
                      child: GestureDetector(
                        child: Icon(
                          CupertinoIcons.minus_circled,
                          color: Color(0xff172853),
                        ),
                        onTap: () {
                          setState(() {
                            counter--;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 99.9272,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    showCupertinoModalPopup(context: context, builder: (context) => ModalWidget(product: widget.product));
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(8), bottomLeft: Radius.circular(8)),
                        color: Color(0xffEDEFF6),
                      ),
                      child: Center(
                        child: Text(
                          '?',
                          style:
                              TextStyle(color: CupertinoColors.black, fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text("${widget.product.price.toInt()}", style: ConstTextStyles.constTitleAppBar),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
