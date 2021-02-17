import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_test/bloc/category/category_bloc.dart';
import 'package:new_test/consts/colors.dart';
import 'package:new_test/consts/paddings.dart';
import 'package:new_test/consts/text_styles.dart';
import 'package:new_test/core/injections.dart';
import 'package:new_test/models/category_model.dart';
import 'package:new_test/ui/widgets/product_card.dart';

class ProductsListView extends StatelessWidget {
  final Category category;

  const ProductsListView({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        } else if (state is ProductSuccess) {
          return Container(
            color: ConstColors.constBackgroundColor,
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  color: CupertinoColors.white,
                  width: double.maxFinite,
                  height: 50,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            CupertinoIcons.chevron_back,
                            color: CupertinoColors.black,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 100,
                          child: Center(
                            child: Text(category.name,
                                style: ConstTextStyles.constTitleAppBar),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                      padding: EdgeInsets.only(top: 24, bottom: 24),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: ConstPaddings.constScreenPadding,
                          child: ProductCard(
                            product: state.products[index],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 10,
                        );
                      },
                      itemCount: state.products.length),
                ),
              ],
            ),
          );
        } else if (state is CategoryFailure) {
          return Text(state.error);
        } else {
          return Offstage();
        }
      },
    );
  }
}
