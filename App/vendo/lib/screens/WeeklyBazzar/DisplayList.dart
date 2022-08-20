import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vendo/models/weeklyBazzarModel/weekly_bazzar_model.dart';
import 'package:vendo/providers/weekly_bazzar_provider.dart';
import 'package:vendo/screens/WeeklyBazzar/DisplayCard.dart';

import '../../models/calendar_display_list.dart';

class DisplayList extends ConsumerStatefulWidget {
  const DisplayList({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DisplayListState();
}

class _DisplayListState extends ConsumerState<DisplayList> {
  // List<DisplayListModel> content = [
  //   DisplayListModel("Sect 4, Kharghar\nopposite to NIFT gate 1", "8 00 pm"),
  //   DisplayListModel("kasunvaiurniruevnkl", "8 00 pm"),
  //   DisplayListModel("kasunvaiurniruevnkl", "8 00 pm"),
  //   DisplayListModel("kasunvaiurniruevnkl", "8 00 pm"),
  //   DisplayListModel("kasunvaiurniruevnkl", "8 00 pm"),
  //   DisplayListModel("kasunvaiurniruevnkl", "8 00 pm"),
  //   DisplayListModel("kasunvaiurniruevnkl", "8 00 pm"),
  //   DisplayListModel("Sect 4, Kharghar\nopposite to NIFT gate 1", "8 00 pm"),
  // ];
  @override
  Widget build(BuildContext context) {
    final weeklyBazzarData = ref.watch(weeklyBazzarProvider);
    return weeklyBazzarData.when(
      data: (data) {
        List<WeeklyBazzarModel?> weeklyList = data.map((e) => e).toList();
        return RefreshIndicator(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: weeklyList.length,
              itemBuilder: ((context, index) {
                return DisplayCard(
                  Location: weeklyList[index]!.bazaarAddress,
                  favourableType: weeklyList[index]!.vendorTypeFavourable,
                );
              }),
            ),
            onRefresh: () async {});
      },
      error: (e, t) {
        log(e.toString());
        return Center(
          child: CircularProgressIndicator(),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
