import 'package:dh_employer/src/presentations/views/home/components/articles_list.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:iconsax/iconsax.dart';

import '../../../values/values.dart';

class ArticleSortByDropDown extends StatefulWidget {
  final List<SortByClass> sortByList;
  final ValueChanged<SortByClass> onValueChanged;
  final bool? disabled;

  const ArticleSortByDropDown({
    Key? key,
    required this.sortByList,
    required this.onValueChanged,
    this.disabled,
  }) : super(key: key);

  @override
  State<ArticleSortByDropDown> createState() => _ArticleSortByDropDownState();
}

class _ArticleSortByDropDownState extends State<ArticleSortByDropDown> {
  SortByClass selectedValue =
      SortByClass(id: 1, title: "Latest", data: "latest");
  @override
  void initState() {
    selectedValue = widget.sortByList.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
        ignoring: widget.disabled ?? false,
        child: Opacity(
            opacity: widget.disabled ?? false ? 0.3 : 1.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: PopupMenuButton<SortByClass>(
                  //onSelected: _handleClick,
                  color: AppColors.backgroundGrey,
                  constraints: BoxConstraints.tightFor(
                      width: (MediaQuery.of(context).size.width / 2) - 20),
                  offset: const Offset(0, 48),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  itemBuilder: (BuildContext context) {
                    return widget.sortByList.map((choice) {
                      return PopupMenuItem<SortByClass>(
                        onTap: () => setState(() {
                          widget.onValueChanged(choice);
                          selectedValue = choice;
                        }),
                        value: choice,
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          bottom: 2,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(choice.title,
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
                      );
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
                            selectedValue.title,
                            style:
                                const TextStyle(color: AppColors.primaryColor),
                          ),
                        ),
                        const Icon(Iconsax.arrow_down5,
                            color: AppColors.primaryColor),
                      ],
                    ),
                  )),
            )));
  }
}
