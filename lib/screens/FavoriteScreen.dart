import 'package:ecommerce/cubit/get_favorites_cubit.dart';
import 'package:ecommerce/screens/detailScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;

    return BlocProvider(
      create: (context) => GetFavoritesCubit()..GetFavorites(),
      child: Padding(
        padding:
            EdgeInsets.only(left: screenWidth * 0.1, right: screenWidth * 0.1),
        child: BlocBuilder<GetFavoritesCubit, GetFavoritesState>(
          builder: (context, state) {
            if (state is GetFavoritesLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xff008bff),
                ),
              );
            } else if (state is GetFavoritesSuccess) {
              List<dynamic> favorites = [];

              state.favoriteList.forEach((productId, productDetails) {
                favorites.add({
                  "id": int.parse(productId),
                  "title": productDetails["name"],
                  "category": productDetails["category"],
                  "description": productDetails["description"],
                  "price": productDetails["price"],
                  "images": productDetails["images"]
                });
              });

              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      detailScreen(id: favorites[index]?["id"]),
                                ));
                          },
                          child: Container(
                            clipBehavior: Clip.none,
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                Stack(clipBehavior: Clip.none, children: [
                                  Image.network(
                                    favorites[index]?["images"][0],
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.fitHeight,
                                  ),
                                  Positioned(
                                    top: -25,
                                    right: -25,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xff008bff),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      padding: const EdgeInsets.all(8),
                                      child: Text(
                                        "${favorites[index]?["price"].toString()} \$",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ]),
                                const SizedBox(
                                  height: 9,
                                ),
                                Text(
                                  favorites[index]?["title"],
                                  maxLines: 2,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  favorites[index]?["description"],
                                  maxLines: 2,
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        )
                      ],
                    ),
                  );
                },
              );
            } else if (state is GetFavoritesFailure) {
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
