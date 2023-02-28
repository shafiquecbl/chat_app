import 'package:chat_app/common/icons.dart';
import 'package:chat_app/common/network_image.dart';
import 'package:chat_app/common/primary_button.dart';
import 'package:chat_app/common/textfield.dart';
import 'package:chat_app/utils/icons.dart';
import 'package:chat_app/utils/style.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // explore
            const Text(
              'Explore',
              style: TextStyle(
                fontSize: 22,
                fontWeight: fontWeightBold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Create your circle'.toUpperCase(),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: fontWeightNormal,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(radius),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      // name rich text
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Name: '.toUpperCase(),
                                style: TextStyle(
                                  color: Theme.of(context).hintColor,
                                  fontSize: 14,
                                  fontWeight: fontWeightBold,
                                ),
                              ),
                              TextSpan(
                                text: ' Muhammad Shafique',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 14,
                                  fontWeight: fontWeightBold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // edit button
                      const CustomIcon(
                        icon: FFIcons.edit,
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      CustomIcon(
                        icon: Icons.add,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        iconColor: Theme.of(context).primaryColor,
                        iconSize: 30,
                        padding: 10,
                      ),
                      const SizedBox(width: 15),
                      // list of circle avatar and every avatar is on a stack
                      Expanded(
                          child: SizedBox(
                        height: 50,
                        child: Stack(children: [
                          for (var i = 0; i < 4; i++)
                            Positioned(
                              left: 40 * i.toDouble(),
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: CustomNetworkImage(
                                      url: demoImages[i],
                                      loadingRadius: 100,
                                      fit: BoxFit.cover,
                                    )),
                              ),
                            ),
                        ]),
                      ))
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(children: [
              const Icon(Icons.group_add_rounded),
              const SizedBox(width: 10),
              const Text('Connect',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: fontWeightBold,
                  )),
              const Spacer(),
              TextButton(onPressed: () {}, child: const Text('Filter'))
            ]),
            CustomTextField(
              controller: search,
              hintText: 'Search',
              padding: EdgeInsets.zero,
              prefixIcon: Icon(Icons.search_rounded,
                  color: Theme.of(context).hintColor),
            ),
            const SizedBox(height: 10),
            GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 6,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.3),
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(10).copyWith(bottom: 0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(radius),
                      border: Border.all(color: Theme.of(context).dividerColor),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 50,
                              height: 50,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: CustomNetworkImage(
                                    url: demoImages[0],
                                    loadingRadius: 100,
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            const SizedBox(width: 5),
                            const Spacer(),
                            CustomButton(
                                width: 90,
                                height: 30,
                                radius: 3,
                                text: 'Message',
                                onPressed: () {}),
                          ],
                        ),
                        // name
                        const SizedBox(height: 10),
                        const Flexible(
                          child: Text(
                            'Muhammad Shafique',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: fontWeightBold,
                            ),
                          ),
                        ),
                        // interests
                        const SizedBox(height: 5),
                        const Flexible(
                          child: Text(
                            'Flutter, Dart, Firebase, Nodejs, Reactjs, React Native, MongoDB, Expressjs, Mysql, Postgresql, Python, Django, Flutter, Dart, Firebase, Nodejs, Reactjs, React Native, MongoDB, Expressjs, Mysql, Postgresql, Python, Django',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: fontWeightNormal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                })
          ],
        ),
      ),
    ));
  }
}

List<String> demoImages = [
  'https://media.licdn.com/dms/image/D4D03AQEn19TZB9AK1w/profile-displayphoto-shrink_800_800/0/1664789524738?e=1683158400&v=beta&t=hCrR49my2elN5ScGVn560F74zlFwObOjVaN0DeE0wHA',
  'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8dXNlcnxlbnwwfHwwfHw%3D&w=1000&q=80',
  'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8dXNlcnxlbnwwfHwwfHw%3D&w=1000&q=80',
  'https://st3.depositphotos.com/1017228/18683/i/450/depositphotos_186838812-stock-photo-photo-of-unshaved-cheerful-man.jpg'
];
