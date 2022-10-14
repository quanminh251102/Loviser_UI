import 'package:flutter/material.dart';

import '../../models/work.dart';

class WorkItem extends StatelessWidget {
  final Work work;
  final Function selectWork;

  const WorkItem({Key? key, required this.work, required this.selectWork})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectWork(),
      child: Container(
        //width: 50,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: work.isSelected
              ? const Color(0xFFEC1C24)
              : const Color(0xFFE4E5E7),
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                width: 8,
              ),
              Text(
                work.type,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: work.isSelected
                        ? Colors.white
                        : const Color(0xFF62636A),
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                width: 8,
              ),
              const SizedBox(
                width: 8,
              ),
            ]),
      ),
    );
  }
}
