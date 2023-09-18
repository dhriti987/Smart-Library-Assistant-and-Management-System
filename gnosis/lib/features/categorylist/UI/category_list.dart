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
    LinearGradient(colors: [
      Color.fromARGB(255, 0, 40, 73),
      Color.fromARGB(255, 0, 20, 39),
    ]),
  ];

  @override
  void initState() {
    categoryListBloc = CategoryListBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Category List"),
      ),
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
          return Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 100, 182).withOpacity(0.4)),
            child: GridView.builder(
              itemCount: categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 3 / 2,
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: gradiants[index % gradiants.length]),
                    child: Center(child: Text(categories[index])),
                  ),
                );
              },
            ),
          );
        },
      ),
      extendBodyBehindAppBar: true,
    );
  }
}
