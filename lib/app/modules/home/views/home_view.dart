import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_vazotsika/app/modules/home/controllers/player_controller.dart';
import 'package:flutter_vazotsika/app/modules/home/models/search_result_model.dart';

import 'package:get/get.dart';

import '../../../../app_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      drawer: const Drawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Material(
          elevation: 3,
          borderRadius: BorderRadius.circular(50),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white10, borderRadius: BorderRadius.circular(50)),
            child: TextFormField(
              onFieldSubmitted: (value) {
                controller.searchTrack(value);
              },
              decoration: InputDecoration(
                prefixIconConstraints: const BoxConstraints(minWidth: 60),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(top: 15),
                prefixIcon: IconButton(
                  onPressed: controller.openDrawer,
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.black54,
                  ),
                ),
                hintText: 'Rechercher votre musique',
              ),
            ),
          ),
        ),
      ),
      body: GetX<HomeController>(
        builder: (_) {
          if (!_.isLoading.value) {
            final result = _.searchResult;
            debugPrint('result $result');
            if (result == null) {
              return const Center(
                child: Text('Empty Search'),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.only(top: 120),
              itemCount: result.tracks?.items?.length ?? 0,
              itemBuilder: (context, index) {
                final track = result.tracks?.items?[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: ListTile(
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.download),
                    ),
                    subtitle: Text(track?.artists?[0].name ?? 'unknown'),
                    leading: InkWell(
                      onTap: () {
                        Get.find<PlayerController>().playTrackPreview(track);
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image:
                                NetworkImage(track?.album?.images?[0].url ?? ''),
                          ),
                        ),
                        child: const Icon(Icons.play_arrow, color: Colors.white,),
                      ),
                    ),
                    title: Text(track?.name ?? 'unknown'),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
