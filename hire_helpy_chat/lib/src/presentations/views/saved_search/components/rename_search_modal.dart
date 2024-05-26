import 'package:dh_employer/src/presentations/values/values.dart';
import 'package:dh_employer/src/presentations/widgets/widgets.dart';
import 'package:flutter/material.dart';

class RenameSearchModal extends StatefulWidget {
  final Function(String)? onSave;
  
   const RenameSearchModal({super.key, this.onSave});

  @override
  State<RenameSearchModal> createState() => _RenameSearchModalState();
}

class _RenameSearchModalState extends State<RenameSearchModal> {
  TextEditingController savedSearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: 327,
        height: 233,
        decoration: BoxDecoration(
          color: AppColors.greyBg,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 18,
                ),
                const Text(
                  'Name Your Search',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: AppColors.greyShade2),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: savedSearchController,
                    decoration: const InputDecoration(
                        labelText: 'Write here...',
                        labelStyle: TextStyle(
                            fontSize: 12,
                            color: AppColors.articleBackgroundColor)),
                  ),
                ),
                const SizedBox(height: 20),
                 CustomPrimaryButton(
                  text: 'Save Search',
                  fontSize: 16,
                  widthButton: 246,
                  onPressed: () {
                    final String enteredText = savedSearchController.text;
                    if (widget.onSave != null) {
                      widget.onSave!(enteredText);
                    }
                  
                  },
                )
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryGrey,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Transform.scale(
                      scale:
                          0.6, 
                      child: Icon(
                        Icons.close,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
