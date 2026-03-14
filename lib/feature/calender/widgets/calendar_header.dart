import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarHeader extends StatelessWidget {

  final DateTime currentMonth;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const CalendarHeader({
    super.key,
    required this.currentMonth,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xffF47C20),
            Color(0xffFF9A3C),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Text(
            DateFormat("MMMM yyyy").format(currentMonth),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600,
            ),
          ),

          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
              ),
              SizedBox(width: 5),
              Text("Completed", style: TextStyle(color: Colors.white, fontSize: 16)),
              SizedBox(width: 15),
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
              ),
              SizedBox(width: 5),
              Text("In Progress", style: TextStyle(color: Colors.white, fontSize: 16)),
              SizedBox(width: 15),
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
              ),
              SizedBox(width: 5),
              Text("Yet to Start", style: TextStyle(color: Colors.white, fontSize: 16)),

              SizedBox(width: 30),
              InkWell(
                onTap: onPrevious,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    border: Border.all(color: Colors.white54),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 5),
              InkWell(
                onTap: onNext,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    border: Border.all(color: Colors.white54),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          )

        ],
      ),
    );
  }
}