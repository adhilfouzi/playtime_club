import 'package:flutter/material.dart';

class EmptyBookingList extends StatelessWidget {
  final VoidCallback refresh;

  const EmptyBookingList({super.key, required this.refresh});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future<void>.delayed(Duration.zero);
        refresh();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height - 200,
          alignment: Alignment.center,
          child: const Text("No bookings available"),
        ),
      ),
    );
  }
}
