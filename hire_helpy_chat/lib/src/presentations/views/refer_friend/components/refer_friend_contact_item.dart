import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

import '../../../values/values.dart';

class ReferFriendContactItem extends StatelessWidget {
  final Contact contact;
  final bool isSelected;
  final VoidCallback? onTap;

  const ReferFriendContactItem({
    super.key,
    required this.contact,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 66,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(bottom: 4.0),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: const BoxDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            isSelected
                ? const CircleAvatar(child: Center(child: Icon(Icons.check)))
                : contact.photo != null
                    ? CircleAvatar(
                        backgroundImage: MemoryImage(contact.photo!),
                      )
                    : const CircleAvatar(
                        backgroundColor: AppColors.cardColor,
                        child: Icon(Icons.person),
                      ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contact.displayName,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 12,
                  ),
                ),
                Text(
                  contact.phones.isNotEmpty ? contact.phones[0].number : '',
                  style: const TextStyle(
                    color: AppColors.secondaryGrey,
                    fontSize: 10,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  height: 0.5,
                  width: MediaQuery.of(context).size.width * 0.7,
                  color: AppColors.primaryGrey,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
