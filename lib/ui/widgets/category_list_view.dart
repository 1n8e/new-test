// import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:new_test/bloc/auth/auth_bloc.dart';
// import 'package:new_test/consts/paddings.dart';
// import 'package:new_test/consts/text_styles.dart';
// import 'package:new_test/ui/screens/auth_screen.dart';
//
// // ignore: must_be_immutable
// class CategoryListView extends StatefulWidget {
//   CategoryListView({Key key}) : super(key: key);
//   TextEditingController searchController = TextEditingController();
//
//   @override
//   _CategoryListViewState createState() => _CategoryListViewState();
// }
//
// class _CategoryListViewState extends State<CategoryListView>
//     with SingleTickerProviderStateMixin {
//   FocusNode _focusNode = FocusNode();
//
//   double _width = double.maxFinite;
//
//   @override
//   void initState() {
//     _focusNode.addListener(() {
//       if (_focusNode.hasFocus) {
//         setState(() {
//           _width = 270.0;
//         });
//       } else {
//         setState(() {
//           _width = double.maxFinite;
//         });
//       }
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: ConstPaddings.constScreenPadding,
//       child: Column(
//         children: [
//           Container(
//             margin: EdgeInsets.only(top: 10),
//             height: 40,
//             child: Stack(
//               children: [
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: GestureDetector(
//                     onTap: () {
//                       FocusScope.of(context).unfocus();
//                     },
//                     child: Text('Отменить',
//                         style: ConstTextStyles.constCancelTextStyle),
//                   ),
//                 ),
//                 AnimatedSize(
//                   vsync: this,
//                   alignment: Alignment.topLeft,
//                   duration: Duration(milliseconds: 300),
//                   child: Container(
//                     width: _width,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     child: TextField(
//                       controller: widget.searchController,
//                       focusNode: _focusNode,
//                       decoration: InputDecoration(
//                         border: InputBorder.none,
//                         prefixIcon: Icon(Icons.search),
//                         hintText: 'Найти вещь',
//                         hintStyle: ConstTextStyles.constTextFieldHint,
//                         suffixIcon: _focusNode.hasFocus
//                             ? CupertinoIconButton(
//                                 icon: Icon(CupertinoIcons.clear),
//                                 onPressed: () {
//                                   widget.searchController.clear();
//                                   _focusNode.unfocus();
//                                 },
//                               )
//                             : Offstage(),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_test/bloc/category/category_bloc.dart';
import 'package:new_test/consts/paddings.dart';
import 'package:new_test/consts/text_styles.dart';
import 'package:new_test/core/injections.dart';
import 'package:new_test/datasources/product_datasource.dart';
import 'file:///C:/Users/natem/dev/new_test/lib/ui/widgets/products_list_view.dart';
import 'package:new_test/ui/widgets/category_card.dart';

class CategoryListView extends StatefulWidget {
  final ProductDatasource productDatasource;

  const CategoryListView({Key key, this.productDatasource}) : super(key: key);

  @override
  _CategoryListViewState createState() => _CategoryListViewState();
}

TextEditingController searchController = TextEditingController();

class _CategoryListViewState extends State<CategoryListView>
    with TickerProviderStateMixin {
  double _width = double.maxFinite;
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          _width = 270.0;
        });
      } else {
        setState(() {
          _width = double.maxFinite;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoryBloc>(
      create: (_) => getIt<CategoryBloc>()..add(GetCategoryEvent()),
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return CupertinoActivityIndicator();
          } else if (state is CategorySuccess) {
            return Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              padding: ConstPaddings.constScreenPadding,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    height: 40,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _focusNode.unfocus();
                                searchController.clear();
                              });
                            },
                            child: Text(
                              'Отменить',
                              style: ConstTextStyles.constCancelTextStyle,
                            ),
                          ),
                        ),
                        AnimatedSize(
                          vsync: this,
                          curve: Curves.ease,
                          duration: Duration(milliseconds: 300),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height,
                              width: _width,
                              child: CupertinoTextField(
                                onSubmitted: (String filter) {
                                  context
                                      .read<CategoryBloc>()
                                      .add(SearchProductEvent(filter));
                                },
                                controller: searchController,
                                focusNode: _focusNode,
                                prefix: Icon(
                                  CupertinoIcons.search,
                                  size: 20,
                                  color: Color(0xffB0B3BC),
                                ),
                                style: TextStyle(color: CupertinoColors.black),
                                placeholder: 'Найти вещь',
                                placeholderStyle:
                                    ConstTextStyles.constFieldHintStyle,
                                suffix: CupertinoButton(
                                  child: Icon(
                                    CupertinoIcons.clear,
                                    size: 20,
                                    color: Color(0xffB0B3BC),
                                  ),
                                  onPressed: () {
                                    _focusNode.unfocus();
                                    searchController.clear();
                                  },
                                  padding: EdgeInsets.all(2),
                                ),
                                suffixMode: OverlayVisibilityMode.editing,
                                decoration: BoxDecoration(
                                  color: CupertinoColors.white,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.only(top: 24, bottom: 24),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                maintainState: false,
                                builder: (context) =>
                                    BlocProvider<CategoryBloc>(
                                  create: (_) => getIt<CategoryBloc>()
                                    ..add(GetProductEvent()),
                                  child: ProductsListView(
                                    category: state.categories[index],
                                  ),
                                ),
                              ),
                            );
                          },
                          child: CategoryCard(
                            category: state.categories[index],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 8,
                        );
                      },
                      itemCount: state.categories.length,
                    ),
                  ),
                ],
              ),
            );
          } else if (state is CategoryFailure) {
            return Center(
              child: Text(
                state.error,
                textAlign: TextAlign.center,
              ),
            );
          } else if (state is FilteredProductState) {
            return ListView.builder(itemBuilder: (context, index) {
              return Text(state.products[index].name);
            });
          } else {
            return Offstage();
          }
        },
      ),
    );
  }
}
