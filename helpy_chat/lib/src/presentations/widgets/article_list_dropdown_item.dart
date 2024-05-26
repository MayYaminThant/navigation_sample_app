part of 'widgets.dart';


class ArticleListDropdown extends StatefulWidget {
  final String initialValue;
  final ValueChanged<String> onValueChanged;
  final List<String> itemList;

  const ArticleListDropdown({
    Key? key,
    required this.initialValue,
    required this.onValueChanged,
    required this.itemList,
  }) : super(key: key);

  @override
  State<ArticleListDropdown> createState() => _ArticleListDropdownState();
}

class _ArticleListDropdownState extends State<ArticleListDropdown> {
  String selectedValue = '';

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 40,
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
        padding: const EdgeInsets.only(left: 0),
        child: DropdownButton<String>(
          isExpanded: true,
          value: selectedValue,
          onChanged: (String? newValue) {
            setState(() {
              selectedValue = newValue!;
            });
            widget.onValueChanged(newValue!);
          },
          icon: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              SizedBox(width: 25.0),
              Icon(Iconsax.arrow_down5, color: AppColors.primaryColor),
            ],
          ),
          borderRadius: BorderRadius.circular(20.0),
          items: widget.itemList.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  value,
                  style: TextStyle(
                    color: value == widget.initialValue ? AppColors.primaryColor : AppColors.black,
                  ),
                ),
              ),
            );
          }).toList(),
          underline: Container(
            height: 0,
          ),
        ),
      ),
    );
  }
}