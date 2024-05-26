// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

import 'package:dh_employer/src/presentations/values/values.dart';

class CardGradient extends StatefulWidget {
  final String? name;
  final String? occupation;
  final String? urlImage;
  final String? dateMatched;
  final String? valuePerMonth;
  final String? jobMessage;
  final String? statusApplication;
  final bool isCanceled;

  const CardGradient({
    Key? key,
    this.name,
    this.occupation,
    this.urlImage,
    this.dateMatched,
    this.valuePerMonth,
    this.jobMessage,
    this.statusApplication,
    required this.isCanceled,
  }) : super(key: key);

  @override
  State<CardGradient> createState() => _CardGradientState();
}

class _CardGradientState extends State<CardGradient> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        margin: const EdgeInsets.only(top: 16),
        padding: const EdgeInsets.only(top: 8, left: 8),
        width: 328,
        height: 130,
        decoration: BoxDecoration(
            border: const GradientBoxBorder(
              gradient: LinearGradient(colors: [
                Color(0xFFFFB6A0),
                Color(0xFFA5E3FD),
                Color(0xFF778AFF),
                Color(0xFFFFCBF2),
              ]),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10)),
        child: _getContentCart(),
      ),
      if (isSelected)
        Container(
          margin: const EdgeInsets.only(top: 16),
          padding: const EdgeInsets.only(top: 8, left: 8),
          width: 328,
          height: 130,
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(10)),
        )
    ]);
  }

  Widget _getContentCart() {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: CircleAvatar(
                    radius: 18,
                    backgroundImage:
                        AssetImage('assets/images/employer_star_list.png'),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.name ?? 'Gieder Loreto',
                      style: const TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.occupation ?? 'Software Engineer',
                      style: const TextStyle(
                        color: AppColors.articleBackgroundColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Matched on ${widget.dateMatched ?? '10/06/2023'}',
                      style: const TextStyle(
                        color: AppColors.articleBackgroundColor,
                        fontWeight: FontWeight.normal,
                        fontSize: 10,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '\$${widget.valuePerMonth ?? '500'}',
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Text(
                          '  per month',
                          style: TextStyle(
                            color: AppColors.articleBackgroundColor,
                            fontWeight: FontWeight.normal,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
            const SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.jobMessage ?? 'To take care of 2 sons and do chores',
                  style: const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.isCanceled
                      ? 'Match has been cancelled by employes'
                      : 'Interview completed on 8/4/2023.',
                  style: TextStyle(
                    color: widget.isCanceled
                        ? const Color(0xFFF50707)
                        : const Color(0xFF06B506),
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        Positioned(
            top: 0,
            right: 0,
            child: widget.isCanceled
                ? _popMenuButtonInterviewScheduledOrCanceled(widget.isCanceled)
                : _popMenuButtonInterviewCompleted()),
      ],
    );
  }

  Widget _popMenuButtonInterviewCompleted() {
    return PopupMenuButton<String>(
      color: Colors.transparent,
      offset: const Offset(30, -7),
      elevation: 0,
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            height: 2,
            value: 'option1',
            child: Container(
              height: 30,
              width: 157,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFF06B506)),
              child: const Center(
                child: Text(
                  'Accept Employer',
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          PopupMenuItem<String>(
            value: 'option2',
            child: Container(
              height: 30,
              width: 157,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFFF50707)),
              child: const Center(
                child: Text(
                  'Reject Employer',
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          PopupMenuItem<String>(
            height: 2,
            value: 'option3',
            child: Container(
              height: 30,
              width: 157,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.greyBg),
              child: const Center(
                child: Text(
                  'Leave Review',
                  style: TextStyle(
                      color: AppColors.greyShade2,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ];
      },
      onSelected: (String value) {
        setState(() {
          isSelected = !isSelected;
        });
      },
      onOpened: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: const Icon(Icons.more_vert, color: Colors.white),
    );
  }

  Widget _popMenuButtonInterviewScheduledOrCanceled(bool isCanceled) {
    return PopupMenuButton<String>(
      color: Colors.transparent,
      offset: const Offset(30, -7),
      elevation: 0,
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            height: 6,
            value: 'option1',
            child: Container(
              height: 47,
              width: 163,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: isCanceled
                      ? const Color(0xFFFF8E03)
                      : const Color(0xFF06B506)),
              child: Center(
                child: Text(
                  isCanceled ? 'Leave Review' : 'Reschedule Interview',
                  style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          PopupMenuItem<String>(
            height: 6,
            value: 'option3',
            child: Container(
              margin: const EdgeInsets.only(top: 4),
              height: 47,
              width: 163,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.greyBg),
              child: Center(
                child: Text(
                  isCanceled ? 'Remove Match' : 'Cancel and Delete Match',
                  style: const TextStyle(
                      color: AppColors.greyShade2,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ];
      },
      onSelected: (String value) {
        setState(() {
          isSelected = !isSelected;
        });
      },
      onOpened: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: const Icon(Icons.more_vert, color: Colors.white),
    );
  }
}
