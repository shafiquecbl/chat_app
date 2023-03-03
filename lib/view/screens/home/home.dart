import 'package:chat_app/common/network_image.dart';
import 'package:chat_app/common/primary_button.dart';
import 'package:chat_app/common/textfield.dart';
import 'package:chat_app/controller/auth_controller.dart';
import 'package:chat_app/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authCon) {
      return SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            authCon.appUser != null
                ? Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: CustomNetworkImage(url: demoImages.first)),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Hello,', style: TextStyle(fontSize: 18)),
                          Text(authCon.appUser!.name!,
                              style: const TextStyle(
                                  fontWeight: fontWeightNormal)),
                        ],
                      ),
                    ],
                  )
                : Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50)),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 100,
                              height: 20,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              width: 150,
                              height: 20,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
            const SizedBox(height: 10),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(children: [
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
                      itemCount: 10,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
                            border: Border.all(
                                color: Theme.of(context).dividerColor),
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
                                        borderRadius:
                                            BorderRadius.circular(100),
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
            ))
          ],
        ),
      ));
    });
  }
}

List<String> demoImages = [
  'https://media.licdn.com/dms/image/D4D03AQEn19TZB9AK1w/profile-displayphoto-shrink_800_800/0/1664789524738?e=1683158400&v=beta&t=hCrR49my2elN5ScGVn560F74zlFwObOjVaN0DeE0wHA',
  'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8dXNlcnxlbnwwfHwwfHw%3D&w=1000&q=80',
  'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8dXNlcnxlbnwwfHwwfHw%3D&w=1000&q=80',
  'https://st3.depositphotos.com/1017228/18683/i/450/depositphotos_186838812-stock-photo-photo-of-unshaved-cheerful-man.jpg'
];
