import 'package:ecommerce/cubit/get_products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/FireBaseHelper.dart';

class detailScreen extends StatelessWidget {
  detailScreen({super.key, required this.id});

  int id;

  @override
  Widget build(BuildContext context) {
    int index = id - 1;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: BlocBuilder<GetProductsCubit, GetProductsState>(
          builder: (context, state) {
            if (state is GetProductsLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xff008bff),
                ),
              );
            } else if (state is GetProductsSuccess) {
              return Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Image.network(
                          state.productList[index].images[0],
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.fitHeight,
                        ),
                        const SizedBox(
                          height: 9,
                        ),
                        Text(
                          textAlign: TextAlign.left,
                          state.productList[index].title,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                    onPressed: () async {
                                      final fireBaseHelper = FireBaseHelper();
                                      await fireBaseHelper
                                          .deleteFavoriteProduct(state
                                              .productList[index].id
                                              .toString());
                                      print("id " +
                                          state.productList[index].id
                                              .toString());
                                    },
                                    style: ButtonStyle(
                                      padding:
                                          WidgetStateProperty.all<EdgeInsets>(
                                        const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 15),
                                      ),
                                      backgroundColor: WidgetStateProperty.all(
                                          const Color(0xff008bff)),
                                      shape: WidgetStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(17),
                                        ),
                                      ),
                                    ),
                                    child: const Text(
                                      "Remove from cart",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                              IconButton(
                                  onPressed: () async {
                                    final fireBaseHelper = FireBaseHelper();
                                    await fireBaseHelper.addFavoriteProduct(
                                      state.productList[index].id.toString(),
                                      {
                                        'name': state.productList[index].title,
                                        'images':
                                            state.productList[index].images,
                                        'description': state
                                            .productList[index].description,
                                        'category':
                                            state.productList[index].category,
                                        'price': state.productList[index].price
                                      },
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Center(
                                        child: Container(
                                          padding: EdgeInsets.all(17),
                                          height: 60,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            color: Colors.blueAccent,
                                            borderRadius: BorderRadius.all(Radius.circular(20))
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Text("Added",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,),
                                              Icon(Icons.favorite_outline_sharp,color: Colors.redAccent,)
                                            ],
                                          ),
                                        ),
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.transparent,
                                      elevation: 0,
                                    ));
                                  },
                                  icon: Icon(Icons.favorite))
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                state.productList[index].category,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 24),
                              ),
                              Text(
                                '\$ ${state.productList[index].price.toString()}',
                                style: const TextStyle(
                                    color: Color(0xff008bff), fontSize: 24),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            state.productList[index].description,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
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
        ),
      ),
    );
  }
}
