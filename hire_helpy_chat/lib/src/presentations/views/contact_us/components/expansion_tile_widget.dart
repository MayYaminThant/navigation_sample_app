import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../../values/values.dart';
import '../../../widgets/widgets.dart';

class ExpansionTileWidget extends StatefulWidget {
  final String question;
  final String answer;
  final Color color;

  const ExpansionTileWidget({
    super.key,
    required this.question,
    required this.answer,
    required this.color,
  });

  @override
  State<ExpansionTileWidget> createState() => _ExpansionTileWidgetState();
}

class _ExpansionTileWidgetState extends State<ExpansionTileWidget> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedIconColor: AppColors.primaryGrey,
      tilePadding: EdgeInsets.zero,
      childrenPadding: const EdgeInsets.all(0.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      iconColor: AppColors.primaryGrey,
      initiallyExpanded: true,
      title: Text(
        widget.question,
        style: GoogleFonts.poppins(
            fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
      ),
      trailing: const Icon(Iconsax.arrow_circle_right),
      onExpansionChanged: (bool expanded) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  content: Builder(
                    builder: (context) {
                      return Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                widget.question,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 13.0,
                              ),
                              _buildAnswerBox,
                              const SizedBox(
                                height: 13.0,
                              ),
                              CustomPrimaryButton(
                                text: 'Close',
                                widthButton: 800,
                                onPressed: () => Navigator.pop(context),
                              ),
                            ]),
                      );
                    },
                  ),
                ));
      },
    );
  }

  Widget get _buildAnswerBox {
    if (widget.answer.length > 145) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.45,
        child: Scrollbar(
          thumbVisibility: true,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                widget.answer,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ),
      );
    } else {
      return Text(
        widget.answer,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 13, color: Colors.black54, fontWeight: FontWeight.w400),
      );
    }
  }
}
