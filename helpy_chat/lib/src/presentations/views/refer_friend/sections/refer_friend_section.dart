part of '../../views.dart';

class ReferFriendSection extends StatefulWidget {
  const ReferFriendSection({super.key});

  @override
  State<ReferFriendSection> createState() => _ReferFriendSectionState();
}

class _ReferFriendSectionState extends State<ReferFriendSection> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController searchController = TextEditingController();
  List<k_flutter_contacts.Contact> contactList = [];
  Map? candidateData;
  List<k_flutter_contacts.Contact> selectedContacts = [];
  bool _permissionDenied = false;

  @override
  void initState() {
    _customDialog();
    _getCandidateData();
    super.initState();
  }

  _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    candidateData = box.get(DBUtils.candidateTableName);
  }

  Future _fetchContacts() async {
    if (!await k_flutter_contacts.FlutterContacts.requestPermission(
        readonly: true)) {
      setState(() => _permissionDenied = true);
    } else {
      final contacts = await k_flutter_contacts.FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);
      setState(() => contactList = contacts);
    }
  }

  void onContactSelected(k_flutter_contacts.Contact contact) {
    if (contact.phones.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Selected contact does not have a phone number')));
      return;
    }

    final alreadySelected =
    selectedContacts.firstWhereOrNull((e) => e.id == contact.id);
    if (alreadySelected == null) {
      selectedContacts.add(contact);
    } else {
      selectedContacts.remove(contact);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _getReferFriendScaffold;
  }

  Widget get _getReferFriendScaffold {
    return BackgroundScaffold(
        scaffold: Scaffold(
      key: _scaffoldKey,
      appBar: _getAppBar,
      drawer: const SideMenu(
        menuName: StringConst.referToFriendsText,
      ),
      drawerScrimColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      body: _getReferFriendContainer,
      bottomNavigationBar: _getReferFriendShareButtom,
    ));
  }

  AppBar get _getAppBar {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: InkWell(
            onTap: () => _scaffoldKey.currentState!.openDrawer(),
            child: Image.asset("assets/icons/menu.png")),
      ),
      leadingWidth: 52,
      title: Text(
        StringConst.referToFriendsText.tr,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
      elevation: 0.0,
      titleSpacing: 0.0,
      centerTitle: true,
    );
  }

  Widget get _getReferFriendContainer {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.padding20,
          vertical: Sizes.padding20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CampaignItem(),
            const SizedBox(
              height: 10,
            ),
            _getReferFriendTextForm,
            const SizedBox(
              height: 10,
            ),
            _getReferFriendContactList,
          ],
        ),
      ),
    );
  }

  Widget get _getReferFriendTextForm {
    return CustomTextField(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.cardColor.withOpacity(0.1)),
      maxLine: 1,
      backgroundColor: AppColors.cardColor.withOpacity(0.1),
      controller: searchController,
      textInputType: TextInputType.text,
      contentPadding:
          const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
      prefixIcon: const Icon(
        Icons.search,
        color: AppColors.cardColor,
      ),
      hasPrefixIcon: true,
      hasTitle: true,
      isRequired: true,
      titleStyle: const TextStyle(
        color: AppColors.white,
        fontSize: Sizes.textSize14,
      ),
      onChanged: (value) => _filterSearch(value),
      hasTitleIcon: false,
      enabledBorder: Borders.noBorder,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(1),
        borderSide: const BorderSide(color: AppColors.white),
      ),
      hintTextStyle:
          const TextStyle(color: AppColors.primaryGrey, fontSize: 15),
      textStyle: const TextStyle(color: AppColors.primaryGrey),
      hintText: "Search",
    );
  }

  Widget get _getReferFriendShareButtom {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      width: MediaQuery.of(context).size.width,
      height: 47,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        ),
        onPressed: () => onSendInvitesPressed(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Iconsax.direct_send),
            const SizedBox(width: 8.0),
            Text(
              StringConst.sendInviteLinkText.tr,
              style: const TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget get _getReferFriendContactList {
  //   return contactList.isEmpty && _permissionDenied
  //       ? _buildNoContactsText()
  //       : Container(
  //           decoration: BoxDecoration(
  //             color: AppColors.cardColor.withOpacity(0.1),
  //             borderRadius: BorderRadius.circular(10),
  //           ),
  //           child: Scrollbar(
  //             child: ListView.builder(
  //               shrinkWrap: true,
  //               itemCount: contactList.length,
  //               physics: const NeverScrollableScrollPhysics(),
  //               itemBuilder: (context, index) {
  //                 // Get contact with specific ID (fully fetched)
  //                 k_flutter_contacts.Contact contact = contactList[index];
  //
  //                 return ReferFriendContactItem(
  //                   contact: contact,
  //                   onTap: () async {
  //                     _sendSMS(
  //                         "Discover Phluid $kMaterialAppTitle, a domestic job helper application. Download it now at ${(await _getInviteLink()).toString()}",
  //                         [
  //                           contact.phones.isNotEmpty
  //                               ? contact.phones[0].number
  //                               : ''
  //                         ]);
  //                   },
  //                 );
  //               },
  //             ),
  //           ));
  // }

  Widget get _getReferFriendContactList {
    return contactList.isEmpty && _permissionDenied
        ? _buildNoContactsText()
        : Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// number of selected contacts
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              const Spacer(),
              Text(
                ' ${selectedContacts.length} Selected Contacts',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),

        /// contacts list
        Container(
          decoration: BoxDecoration(
            color: AppColors.cardColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Scrollbar(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: contactList.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                // Get contact with specific ID (fully fetched)
                k_flutter_contacts.Contact contact = contactList[index];

                return ReferFriendContactItem(
                  contact: contact,
                  isSelected: isSelectedContact(contact),
                  onTap: () => onContactSelected(contact),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNoContactsText() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child:  Center(
        child: Text(
          StringConst.noContactText.tr,
          style: const TextStyle(color: AppColors.white, fontSize: 15),
        ),
      ),
    );
  }

  _filterSearch(String query) {
    if (query == '') {
      _fetchContacts();
    } else {
      setState(() {
        contactList = contactList.where((contact) {
          return contact.displayName
              .toLowerCase()
              .contains(query.toLowerCase());
        }).toList();
      });
    }
  }

  void _sendSMS(String message, List<String> recipents) async {
    await sendSMS(message: message, recipients: recipents);
  }

  _getInviteLink() async {
    return await ShortLink.createShortLink(
        candidateData!['login_name'], kShortLinkInvite);
  }

  bool isSelectedContact(k_flutter_contacts.Contact contact) {
    final index = selectedContacts.indexOf(contact);
    return index >= 0;
  }

  void onSendInvitesPressed() {
    if (selectedContacts.isEmpty) shareInviteLink();
    sendBulkSMSInvite();
  }

  Future<void> sendBulkSMSInvite() async {
    try {
      final phones = selectedContacts
          .map((contact) => contact.phones.first.number)
          .toList();
      if (phones.isEmpty) return;
      _sendSMS(
        "Discover $kMaterialAppTitle, a domestic job helper application. Download it now at ${(await _getInviteLink()).toString()}",
        phones,
      );
    } catch (e) {
      superPrint('sendBulkSMSInvite error: $e');
    }
  }


  Future<void> shareInviteLink() async {
    String link = (await _getInviteLink()).toString();
    await FlutterShare.share(
        title: kMaterialAppTitle,
        text: StringConst.letsConnectOnDHText,
        linkUrl: link,
        chooserTitle: kMaterialAppTitle);
  }

  void _customDialog() async {
    var contactPermission = await Permission.contacts.status;
    if (contactPermission.isGranted) {
      setState(() {
        _fetchContacts();
      });
      return;
    }
    if (contactPermission.isPermanentlyDenied) {
      return;
    }
    Future.delayed(const Duration(milliseconds: 200), () {
      Get.dialog(
          CustomDialogSimple(
            message:
            'Allow access to your contacts for easier sharing. Otherwise, you can just share your invite link.'
                .tr,
            positiveText: 'Allow'.tr,
            onButtonClick: () {
              Get.back();
              setState(() {
                _fetchContacts();
              });
            },
            negativeText: 'Deny'.tr,
            onNegativeButtonClick: () {
              Get.back();
            },
          ),
          barrierDismissible: true);
    });
  }
}
