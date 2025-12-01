import 'package:flutter/material.dart';

class RoomWidget extends StatelessWidget {
  final String _title;
  final String _subtitle;

  const RoomWidget(this._title, this._subtitle, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(50),
        borderRadius: .circular(12),
      ),
      clipBehavior: .hardEdge,

      child: Row(
        children: [
          Container(
            width: 142,
            height: double.infinity,
            decoration: BoxDecoration(color: Colors.red),
          ),
          SizedBox(width: 12),
          Padding(
            padding: .all(12),
            child: Column(
              crossAxisAlignment: .start,
              children: [Text(_title), SizedBox(height: 8), Text(_subtitle)],
            ),
          ),
        ],
      ),
    );
  }
}
