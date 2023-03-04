import 'package:chat_app/common/snackbar.dart';
import 'package:chat_app/controller/auth_controller.dart';
import 'package:chat_app/data/model/response/user.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/buttons.dart';
import 'package:chat_app/common/primary_button.dart';
import 'package:chat_app/common/textfield.dart';
import 'package:chat_app/utils/icons.dart';
import 'package:chat_app/utils/style.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController dob = TextEditingController();
  String gender = 'Male';
  String infoVisibility = 'Public';

  List<String> choices = [
    'Choice 1',
    'Choice 2',
    'Choice 3',
    'Choice 4',
    'Choice 5',
    'Choice 6',
    'Choice 7',
    'Choice 8',
    'Choice 9',
    'Choice 10',
  ];
  List<bool> selectedChoices = [];

  @override
  void initState() {
    AppUser user = AuthController.to.appUser!;
    name.text = user.name!;
    city.text = user.city!;
    country.text = user.country!;
    dob.text = user.dob!;
    gender = user.gender!;
    infoVisibility = user.infoVisibility! ? 'Public' : 'Private';
    selectedChoices = List.generate(choices.length, (index) => false);
    for (var item in user.interests!) {
      selectedChoices[choices.indexOf(item)] = true;
    }
    setState(() {});

    super.initState();
  }

  @override
  void dispose() {
    name.dispose();
    city.dispose();
    country.dispose();
    dob.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const Text('Edit Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20).copyWith(top: 30),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // name textfield
                CustomTextField(
                  labelText: 'Name',
                  hintText: 'Enter your Name',
                  prefixIcon: IconButton(
                      onPressed: () {
                        debugPrint('pressed');
                      },
                      icon: Icon(FFIcons.user,
                          color: Theme.of(context).hintColor)),
                  controller: name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),

                // dob textfield
                CustomTextField(
                  labelText: 'Date of Birth',
                  hintText: 'Enter Date of Birth',
                  readOnly: true,
                  prefixIcon: Icon(FFIcons.calendar,
                      color: Theme.of(context).hintColor),
                  suffixIcon: Icon(FFIcons.downArrow,
                      color: Theme.of(context).hintColor),
                  controller: dob,
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    ).then((value) {
                      if (value != null) {
                        setState(() {
                          dob.text = value.toString().split(' ').first;
                        });
                      }
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your date of birth';
                    }
                    return null;
                  },
                ),

                // gender
                CustomDropDown(
                    labelText: 'Gender',
                    hintText: gender,
                    items: ['Male', 'Female', 'Other']
                        .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontWeight: fontWeightNormal))))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        gender = value.toString();
                      });
                    }),

                CustomDropDown(
                    labelText: 'Personal Info',
                    hintText: infoVisibility,
                    items: ['Private', 'Public']
                        .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontWeight: fontWeightNormal))))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        infoVisibility = value.toString();
                      });
                    }),

                CustomTextField(
                  labelText: 'Country',
                  hintText: 'Enter your country',
                  prefixIcon: Icon(Icons.location_on_rounded,
                      color: Theme.of(context).hintColor),
                  controller: country,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your country';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  labelText: 'City',
                  hintText: 'Enter your city',
                  prefixIcon: Icon(Icons.location_on_rounded,
                      color: Theme.of(context).hintColor),
                  controller: city,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your city/state';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // interests
                Wrap(spacing: 10, runSpacing: 10, children: [
                  for (int i = 0; i < selectedChoices.length; i++)
                    ChoiceChip(
                      label: Text(choices[i],
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black)),
                      selected: selectedChoices[i],
                      selectedColor:
                          Theme.of(context).primaryColor.withOpacity(0.4),
                      side: BorderSide(color: Theme.of(context).primaryColor),
                      onSelected: (value) {
                        setState(() {
                          selectedChoices[i] = value;
                        });
                      },
                    ),
                ]),

                SizedBox(height: getPixels(context, 50)),
                // save button
                PrimaryButton(
                  text: 'Save',
                  onPressed: _updateProfile,
                  options: ButtonOptions(
                      color: Theme.of(context).primaryColor,
                      textStyle: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _updateProfile() {
    if (_formKey.currentState!.validate()) {
      List<String> finalChoice = [];
      for (int i = 0; i < selectedChoices.length; i++) {
        if (selectedChoices[i] == true) {
          finalChoice.add(choices[i]);
        }
      }

      if (finalChoice.isEmpty) {
        getSnackBar('Please select at least one interest', success: false);
      } else {
        AppUser user = AppUser(
            name: name.text,
            dob: dob.text,
            gender: gender,
            country: country.text,
            city: city.text,
            interests: finalChoice,
            infoVisibility: infoVisibility == 'Public' ? true : false);

        AuthController.to.updateUser(user);
      }
    }
  }
}
