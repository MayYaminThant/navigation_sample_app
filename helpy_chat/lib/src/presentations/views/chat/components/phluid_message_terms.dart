import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../values/values.dart';

class PhluidMessageTerms extends StatefulWidget {
  const PhluidMessageTerms({super.key});

  @override
  State<PhluidMessageTerms> createState() => _PhluidMessageTermsState();
}

class _PhluidMessageTermsState extends State<PhluidMessageTerms> {
  final String message =
      """(This is an auto-generated message from Phluid Worldwide Team.) Dearest Mary, As our Esteemed user, 
      1) You are free to DIRECTLY discuss with the Employer the terms of your Employment.
            After a successful negotiation, you can use Phluid Worldwide Match, the most Reliable and Affordable service in the Industry, to help you process the paperwork.
            The Employer will have to initiate the Offer by clicking on option in the Chat screen as shown in picture below.""";

  final String message2 =
      "You will then receive the notification as in the diagram here.";

  final String message3 =
      """You need to click on it to accept the Offer, before expiry date.
      After which, Phluid representative will call you on your verified phone number to start the processing.
      2) Please be aware that Domestic Helper has to pay for passport application, air-tickets, Helper's training... etc. Phluid Worldwide will help you look for a loan, if you cannot afford the cost.
      3) Video chat calls will be limited to a maximum of three, 45 minutes sessions with each individual Employer. There is no limit for text chat messages.
      4) Please keep all conversations civillised. 
      You can give each other review after chatting and even file a complaint if required. The offending account will be investigated.
      Thank you! We wish you a Bright Future and Salute you for your bravery in changing your life through meaningful work in helping others.""";

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return _getInfoMessages;
  }

  //Messages Info
  Widget get _getInfoMessages => Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: AppColors.cardColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 56,
              height: 30,
              child: Image.asset('assets/images/logo.png'),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              message,
              style: const TextStyle(
                  color: AppColors.white, fontSize: 14, height: 2),
              textAlign: TextAlign.start,
            ),
            if(isExpanded)
            Container(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: 60,
                child: Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  columnWidths: const {
                    0: FixedColumnWidth(65),
                    2: FixedColumnWidth(125),
                  },
                  children: [
                    TableRow(children: [
                      SizedBox(
                          width: 65,
                          height: 55,
                          child: Image.asset('assets/images/chatInfo3.png')),
                      SizedBox(
                          height: 20,
                          child: Image.asset('assets/images/chatInfo1.png',
                              fit: BoxFit.cover)),
                      Image.asset('assets/images/chatInfo2.png'),
                    ])
                  ],
                ),
              ),
            ),
            if(isExpanded)
            Text(
              message2,
              style: const TextStyle(
                  color: AppColors.white, fontSize: 14, height: 2),
              textAlign: TextAlign.justify,
            ),
            if(isExpanded)
            const SizedBox(
              height: 20,
            ),
            if(isExpanded)
            SizedBox(
                width: 167,
                height: 55,
                child: Image.asset('assets/images/chatInfo4.png')),
            if(isExpanded)
            Container(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: 130,
                child: Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  columnWidths: const {
                    0: FixedColumnWidth(111),
                    2: FixedColumnWidth(108),
                  },
                  children: [
                    TableRow(children: [
                      Image.asset('assets/images/chatInfo5.png'),
                      SizedBox(
                          height: 20,
                          child: Image.asset('assets/images/chatInfo1.png',
                              fit: BoxFit.cover)),
                      Image.asset('assets/images/chatInfo6.png'),
                    ])
                  ],
                ),
              ),
            ),
            if(isExpanded)
            Text(
              message3,
              style: const TextStyle(
                  color: AppColors.white, fontSize: 14, height: 2),
              textAlign: TextAlign.justify,
            ),
            _getSeeMoreDivider
          ],
        ),
      );

  Widget get _getSeeMoreDivider {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Text(
            !isExpanded ? 'See More'.tr : 'See Less'.tr,
            style: const TextStyle(
              color: AppColors.secondaryColor,
              fontSize: 14,
            ),
          ),
        )
      ],
    );
  }
}
