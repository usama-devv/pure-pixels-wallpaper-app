import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pure_pixels_wallpaper_app/repo/repository.dart';

import '../model/model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Repository repo = Repository();
  ScrollController scrollController = ScrollController();
  late Future<List<Images>> imagesList;
  int pageNumber = 1;

  @override
  void initState() {
    imagesList = repo.getImagesList(pageNumber: pageNumber);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Pure",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.blue,
                fontSize: 22,
              ),
            ),
            Text(
              "Pixels",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.orange,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            FutureBuilder(
              future: imagesList,
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Something went wrong!"),
                    );
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: MasonryGridView.count(
                          itemCount: snapshot.data?.length,
                            shrinkWrap: true,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5,
                            crossAxisCount: 2,
                            itemBuilder: (context, index) {
                              double height = (index % 10 + 1) * 100;
                              return GestureDetector(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    height: height > 300 ? 300 : height,
                                    imageUrl:
                                        snapshot.data![index].imagePortraitPath,
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
