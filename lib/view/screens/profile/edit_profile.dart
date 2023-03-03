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
  TextEditingController name = TextEditingController();
  List<bool> choice = List.generate(10, (index) => false);
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // name textfield
              CustomTextField(
                labelText: 'Name',
                hintText: 'Enter Name',
                prefixIcon: IconButton(
                    onPressed: () {
                      debugPrint('pressed');
                    },
                    icon:
                        Icon(FFIcons.user, color: Theme.of(context).hintColor)),
                controller: name,
              ),

              // dob textfield
              CustomTextField(
                labelText: 'Date of Birth',
                hintText: 'Enter Date of Birth',
                prefixIcon: IconButton(
                    onPressed: () {
                      debugPrint('pressed');
                    },
                    icon: Icon(FFIcons.calendar,
                        color: Theme.of(context).hintColor)),
                controller: name,
              ),

              // gender
              CustomDropDown(
                  labelText: 'Gender',
                  hintText: 'Select your gender',
                  items: ['Male', 'Female', 'Other']
                      .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontWeight: fontWeightNormal))))
                      .toList(),
                  onChanged: (value) {}),

              CustomDropDown(
                  labelText: 'Personal Info',
                  hintText: 'Visibility',
                  items: ['Private', 'Public']
                      .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontWeight: fontWeightNormal))))
                      .toList(),
                  onChanged: (value) {}),

              CustomTextField(
                labelText: 'Address',
                hintText: 'Enter your address',
                prefixIcon: Icon(Icons.location_on_rounded,
                    color: Theme.of(context).hintColor),
                controller: name,
              ),

              const SizedBox(height: 20),

              // interests
              Wrap(spacing: 10, runSpacing: 10, children: [
                for (int i = 0; i < choice.length; i++)
                  ChoiceChip(
                    label: Text('Choice ${i + 1}',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.black)),
                    selected: choice[i],
                    selectedColor:
                        Theme.of(context).primaryColor.withOpacity(0.4),
                    side: BorderSide(color: Theme.of(context).primaryColor),
                    onSelected: (value) {
                      setState(() {
                        choice[i] = value;
                      });
                    },
                  ),
              ]),

              SizedBox(height: getPixels(context, 50)),
              // save button
              PrimaryButton(
                text: 'Save',
                onPressed: () {},
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
    );
  }
}
