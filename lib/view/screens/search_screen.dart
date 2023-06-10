import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tik_shok/view/screens/profile_screen.dart';
import '../../controller/search_controller.dart';
import '../../model/user_model.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  TextEditingController searchQuery = TextEditingController();
  final Searchcontroller searchController = Get.put(Searchcontroller());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          appBar: AppBar(
            title: TextFormField(
              onChanged: (value) {
                searchController.searchUser(value);
              },
              controller: searchQuery,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 11, horizontal: 15),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20)),
                prefixIcon: const Icon(CupertinoIcons.search),
                hintText: "Search",
              ),
            ),
          ),
          body: searchController.searchUsers.isEmpty
              ? const Center(child: Text("Search Users"))
              : ListView.builder(
                  itemCount: searchController.searchUsers.length,
                  itemBuilder: (context, index) {
                    MyUser user = searchController.searchUsers[index];
                    return ListTile(
                      onTap: () {
                        Get.to(ProfileScreen(uid: user.uid));
                      },
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user.prifilePic),
                      ),
                      title: Text(user.name),
                    );
                  },
                ));
    });
  }
}
