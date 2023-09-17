import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnosis/features/categorylist/bloc/category_list_bloc.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({
    super.key,
  });

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  late CategoryListBloc categoryListBloc;
  List<String> categories = [];
  List<LinearGradient> gradiants = const [
    LinearGradient(colors: [Color(0xff9D50BB), Color(0xff6E48AA)]),
  ];


  @override
  void initState() {
    categoryListBloc = CategoryListBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Category List"),),
      body: BlocConsumer<CategoryListBloc, CategoryListState>(
        bloc: categoryListBloc,
        listenWhen: (previous, current) => current is CategoryListActionState,
        buildWhen: (previous, current) => current is! CategoryListActionState,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is CategoryListInitial) {
            categoryListBloc.add(CategoryListFetchEvent());
          }
          if (state is CategoryListLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CategoryListSuccessState) {
            categories = state.categoryList;
          }
          return GridView.builder(
            
            itemCount: categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 3/2,
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), gradient: gradiants[index%gradiants.length]),
                    child: Center(child: Text(categories[index])),
                  ));
            },
          );
        },
      ),
    );
  }
}
