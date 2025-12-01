import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:roomy/app/modules/home/widgets/room_widget.dart';
import 'package:roomy/app/router/app_routes.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: "appTitle",
          child: Material(
            type: .transparency,
            child: Text("Roomy", style: Theme.of(context).textTheme.titleLarge),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => context.push(AppRoutes.profile),
          icon: Icon(Icons.person_rounded),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.people_rounded)),
          IconButton(onPressed: () {}, icon: Icon(Icons.settings_rounded)),
        ],
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: .all(12),
          itemCount: 12,
          itemBuilder: (context, index) =>
              RoomWidget("Movie name here", "username here"),
          separatorBuilder: (context, index) => SizedBox(height: 12),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: CircleBorder(),
        child: Icon(Icons.add),
      ),
    );
  }
}
