import 'package:dh_employer/src/presentations/values/values.dart';
import 'package:dh_employer/src/presentations/views/setting/components/custom_modal_change_password.dart';
import 'package:flutter/material.dart';

class CustomExpansionTile extends StatefulWidget {
  final String? email;
  final String? phoneNumber;
  final String? changePassword;

  const CustomExpansionTile({
    Key? key,
    this.changePassword,
    this.email,
    this.phoneNumber,
  }) : super(key: key);

  @override
  _CustomExpansionTileState createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          _buildTitleRow(),
          SizedBox(
            height: _isExpanded ? 24 : 10,
          ),
          if (_isExpanded) ..._buildExpandedContent(),
        ],
      ),
    );
  }

  Widget _buildTitleRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _isExpanded ? 'Edit Profile' : 'Register Account',
          style: const TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w100,
            fontSize: 12,
          ),
        ),
        const SizedBox(
          width: 30,
          child: Icon(
            Icons.chevron_right,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildExpandedContent() {
    return [
      _buildExpansionItem('Change Email Address', widget.email ?? '', false),
      _buildExpansionItem(
          'Change Phone Number', widget.phoneNumber ?? '', false),
      GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const CustomModal();
              },
            );
          },
          child: _buildExpansionItem(
              'Change Password', widget.changePassword ?? '', true)),
    ];
  }

  Widget _buildExpansionItem(String title, String? value, bool isPassword) {
    final maskedValue = isPassword ? _maskPassword(value ?? '') : value;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w100,
                  fontSize: 12,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                maskedValue ?? '',
                style: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 30,
            child: Icon(
              Icons.chevron_right,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }

  String _maskPassword(String? password) {
    return password?.replaceAll(RegExp(r'.'), '*') ?? '';
  }
}
