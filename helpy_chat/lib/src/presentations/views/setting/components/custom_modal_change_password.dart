import 'package:dh_mobile/src/presentations/values/values.dart';
import 'package:flutter/material.dart';

class CustomModal extends StatefulWidget {
  const CustomModal({super.key});

  @override
  State<CustomModal> createState() => _CustomModalState();
}

class _CustomModalState extends State<CustomModal> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        width: 327,
        height: 405,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: AppColors.greyBg,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 16.0),
                child: const Text(
                  'Change Password',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              _buildTextFormField('Enter Your Current Password'),
              const SizedBox(height: 16.0),
              _buildTextFormField('Enter Your New Password'),
              const SizedBox(height: 16.0),
              _buildTextFormField('Enter Your New Password'),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  children: [
                    Container(
                      height: 21,
                      width: 21,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                        border: _isChecked
                            ? null
                            : Border.all(color: Colors.white, width: 2.0),
                      ),
                      child: Theme(
                        data: ThemeData(
                          unselectedWidgetColor: Colors.transparent,
                        ),
                        child: Checkbox(
                          value: _isChecked,
                          onChanged: (value) {
                            setState(() {
                              _isChecked = value ?? false;
                            });
                          },
                          activeColor: Colors.white,
                          checkColor: Colors.blue,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    const Text(
                      'Email me for my account update',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    minimumSize: const Size(246, 47),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text('Update Password'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(String labelText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: 45,
        width: 246,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: AppColors.white,
        ),
        child: TextFormField(
          decoration: InputDecoration(
              labelText: labelText,
              labelStyle:
                  const TextStyle(fontSize: 12, color: AppColors.primaryGrey),
              border: InputBorder.none,
              filled: false,
              fillColor: AppColors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 8.0)),
        ),
      ),
    );
  }
}
