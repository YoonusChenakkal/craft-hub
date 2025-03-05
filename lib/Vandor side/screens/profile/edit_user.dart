import 'dart:io';

import 'package:crafti_hub/Vandor%20side/common/button.dart';
import 'package:crafti_hub/Vandor%20side/common/form_field_features.dart';
import 'package:crafti_hub/Vandor%20side/screens/profile/model/user_model.dart';
import 'package:crafti_hub/Vandor%20side/screens/profile/provider/profile_provider.dart';
import 'package:crafti_hub/user%20side/common/custom_app_bar.dart';
import 'package:crafti_hub/user%20side/common/flush_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class VendorEditPage extends StatefulWidget {
  const VendorEditPage({super.key});

  @override
  _VendorEditPageState createState() => _VendorEditPageState();
}

class _VendorEditPageState extends State<VendorEditPage> {
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<VendorProfileProvider>(context).user;
    final space = SizedBox(
      height: 1.5.h,
    );

    final profileProvider = Provider.of<VendorProfileProvider>(context);
    TextEditingController tcName = TextEditingController();
    TextEditingController tcPhone = TextEditingController();

    TextEditingController tcWhatsappNumber = TextEditingController();

    return Scaffold(
        appBar: customAppBar(title: 'Edit Profile'),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 10.h),
                pickImage(user!),
                SizedBox(
                  height: 6.h,
                ),
                TextFormField(
                  controller: tcName,
                  decoration: textFormFieldDecoration(
                      hinttext: user.name, prefixIcon: Icons.person_2_outlined),
                ),
                space,
                TextFormField(
                  controller: tcPhone,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
                  decoration: textFormFieldDecoration(
                      hinttext: user.contactNumber,
                      prefixIcon: Icons.phone_outlined),
                ),
                space,
                TextFormField(
                  controller: tcWhatsappNumber,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
                  decoration: textFormFieldDecoration(
                      hinttext: user.whatsappNumber,
                      prefixIcon: Icons.chat_bubble_outline),
                ),
                space,
                SizedBox(
                  height: 3.5.h,
                ),
                customButton(
                  onPressed: () {
                    final data = {
                      if (tcName.text.isNotEmpty) 'name': tcName.text,
                      if (tcPhone.text.isNotEmpty)
                        'contactNumber': tcPhone.text,
                      if (tcWhatsappNumber.text.isNotEmpty)
                        'whatsappNumber': tcWhatsappNumber.text,
                      if (selectedImage != null) 'displayImage': selectedImage
                    };

                    if (data.isEmpty) {
                      showFlushbar(
                        context: context,
                        color: Colors.red,
                        icon: Icons.error,
                        message: 'Please fill at least one field to update.',
                      );
                    } else {
                      profileProvider.editUser(context, data);
                    }
                  },
                  buttonName: 'Update',
                  color: Colors.brown,
                ),
              ],
            ),
          ),
        ));
  }

  pickImage(
    UserModel user,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.brown[50],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: selectedImage != null
                ? Image.file(
                    selectedImage!,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    user.displayImage,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        ElevatedButton(
          onPressed: () => pickProfileImage(),
          style: ButtonStyle(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: WidgetStatePropertyAll(CircleBorder()),
            padding: WidgetStatePropertyAll(EdgeInsets.zero),
          ),
          child: Icon(
            Icons.change_circle,
            size: 50,
            color: Colors.brown,
          ),
        ),
      ],
    );
  }

  pickProfileImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }
}
