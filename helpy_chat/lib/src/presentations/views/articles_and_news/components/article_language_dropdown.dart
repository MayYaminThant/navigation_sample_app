import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../domain/entities/entities.dart';
import '../../../values/values.dart';

class ArticleLanguageDropDown extends StatefulWidget {
  final ConfigLanguage initialValue;
  final List<ConfigLanguage> languageList;
  final ValueChanged<ConfigLanguage>? onValueChanged;

  const ArticleLanguageDropDown({
    Key? key,
    required this.initialValue,
    required this.languageList,
    required this.onValueChanged,
  }) : super(key: key);

  @override
  State<ArticleLanguageDropDown> createState() =>
      _ArticleLanguageDropDownState();
}

class _ArticleLanguageDropDownState extends State<ArticleLanguageDropDown> {
  ConfigLanguage selectedValue = const ConfigLanguage();
  @override
  Widget build(BuildContext context) {
    setState(() {
      selectedValue = widget.initialValue;
    });
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PopupMenuButton<ConfigLanguage>(
          color: AppColors.backgroundGrey,
          constraints: BoxConstraints.tightFor(
              width: (MediaQuery.of(context).size.width / 2) - 10, height: 400),
          offset: const Offset(0, 48),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          itemBuilder: (BuildContext context) {
            return widget.languageList.map((ConfigLanguage choice) {
              return PopupMenuItem<ConfigLanguage>(
                  onTap: widget.onValueChanged == null
                      ? null
                      : () {
                          setState(() {
                            widget.onValueChanged!(choice);
                            selectedValue = choice;
                          });
                        },
                  value: selectedValue,
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: 10,
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(choice.language ?? '',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColors.black,
                                  )),
                              const SizedBox(
                                width: 5,
                              ),
                              if (selectedValue == choice)
                                SizedBox(
                                  width: 30,
                                  height: 30,
                                  child:
                                      Image.asset('assets/icons/tick_blue.png'),
                                )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            choice.languageName ?? '',
                            style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.primaryGrey,
                                fontWeight: FontWeight.w200),
                          )
                        ],
                      ),
                    ],
                  ));
            }).toList();
          },
          child: Container(
            height: 40,
            width: MediaQuery.of(context).size.width / 2.5,
            decoration: BoxDecoration(
              color: AppColors.cardColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: const GradientBoxBorder(
                gradient: LinearGradient(colors: [
                  Color(0xFFFFB6A0),
                  Color(0xFFA5E3FD),
                  Color(0xFF778AFF),
                  Color(0xFFFFCBF2),
                ]),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "${selectedValue.language}",
                    style: TextStyle(
                        fontSize:
                            "${selectedValue.language}".length > 11 ? 10 : 14,
                        color: AppColors.primaryColor),
                  ),
                ),
                const Icon(Iconsax.arrow_down5, color: AppColors.primaryColor),
              ],
            ),
          )),
    );
  }
}
