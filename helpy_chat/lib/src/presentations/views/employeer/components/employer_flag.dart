import 'package:flutter/material.dart';

import '../../../../core/utils/db_utils.dart';
import '../../../../domain/entities/entities.dart';

class EmployerFlag extends StatefulWidget {
  const EmployerFlag(
      {super.key, required this.country, this.marginValue, this.configKey, this.size=30});
  final String country;
  final double? marginValue;
  final String? configKey;
  final double size;

  @override
  State<EmployerFlag> createState() => _EmployerFlagState();
}

class _EmployerFlagState extends State<EmployerFlag> {
  String flagUri = '';

  @override
  void initState() {
    _getCountryData();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant EmployerFlag oldWidget) {
    if (widget.country != '' && oldWidget.country != widget.country) {
      _getCountryData();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: widget.marginValue ?? 10.0),
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
          image:
              DecorationImage(image: AssetImage(flagUri), fit: BoxFit.cover)),
    );
  }

  //Country Data List with top Countries
  Future<void> _getCountryData() async {
    List<Country> countryDataList = List<Country>.from(
        (await DBUtils.getKeyDataList(widget.configKey))
            .map((e) => Country.fromJson(e)));
    setState(() {
      flagUri = countryDataList.indexWhere(
              (f) => f.name!.toLowerCase() == (widget.country).toLowerCase()) != -1 ? countryDataList[countryDataList.indexWhere(
              (f) => f.name!.toLowerCase() == (widget.country).toLowerCase())].flagUri : '';
    });
  }
}
