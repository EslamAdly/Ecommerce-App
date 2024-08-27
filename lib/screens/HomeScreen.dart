import 'package:ecommerce/cubit/get_products_cubit.dart';
import 'package:ecommerce/screens/detailScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Homescreen extends StatefulWidget {
  Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetProductsCubit, GetProductsState>(
      builder: (context, state) {
        if (state is GetProductsLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xff008bff),
            ),
          );
        } else if (state is GetProductsSuccess) {
          return ListView.builder(
            itemCount: state.categories.length,
            itemBuilder: (context, outerIndex) {
              final currentCategory = state.categories[outerIndex];
              final productsInCategory = state.productList
                  .where((product) => product.category == currentCategory)
                  .toList();

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentCategory,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 400,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: productsInCategory.length,
                          itemBuilder: (context, innerIndex) {
                            return Column(
                              children: [
                                const SizedBox(
                                  height: 25,
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      borderRadius: BorderRadius.circular(20),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  detailScreen(
                                                      id: productsInCategory[
                                                              innerIndex]
                                                          .id),
                                            ));
                                      },
                                      child: Container(
                                        height: 350,
                                        width: 200,
                                        padding: const EdgeInsets.all(16.0),
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Column(
                                          children: [
                                            Stack(
                                                clipBehavior: Clip.none,
                                                children: [
                                                  Image.network(
                                                    productsInCategory[
                                                            innerIndex]
                                                        .images[0],
                                                    fit: BoxFit.fitHeight,
                                                    height: 200,
                                                    width: double.infinity,
                                                  ),
                                                  Positioned(
                                                    top: -25,
                                                    right: -25,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: const Color(
                                                              0xff008bff),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      child: Text(
                                                        "${productsInCategory[innerIndex].price.toString()} \$",
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ]),
                                            const SizedBox(
                                              height: 9,
                                            ),
                                            Text(
                                              productsInCategory[innerIndex]
                                                  .title,
                                              maxLines: 2,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              productsInCategory[innerIndex]
                                                  .description,
                                              maxLines: 2,
                                              style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 25,
                                    )
                                  ],
                                ),
                              ],
                            );
                          }),
                    ),
                  ],
                ),
              );
            },
          );
        } else if (state is GetProductsFailure) {
          return Center(
            child: Text(
              "Failed to load products: ${state.error}",
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else {
          return const Center(child: Text("No data available"));
        }
      },
    );
  }
}
