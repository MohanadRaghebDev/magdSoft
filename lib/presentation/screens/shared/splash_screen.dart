import 'package:flutter/material.dart';
import 'package:magdsoft_flutter_structure/presentation/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../data/local/cache_helper.dart';
import '../../../data/models/splash_screen_model.dart';
import '../auth_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List<SplashScreenModel> boardingList = [
    SplashScreenModel(
        title: 'Text Title 1',
        body: 'Text body 1',
        image:
            'https://msapps.mobi/wp-content/uploads/2019/07/flutter_banner.jpg'),
    SplashScreenModel(
        title: 'Text Title 2',
        body: 'Text body 2',
        image:
            'https://www.ismailoguzhanay.com/wp-content/uploads/2019/12/flutter.jpg'),
    SplashScreenModel(
        title: 'Text Title 3',
        body: 'Text body 3',
        image:
            'https://bs-uploads.toptal.io/blackfish-uploads/components/seo/content/og_image_file/og_image/777695/0408-FlutterMessangerDemo-Luke_Social-e8a0e8ddab86b503a125ebcad823c583.png'),
  ];

  var controller = PageController();

  bool isLast = false;

  void submit() {
    CacheHelper.saveDataSharedPreference(key: 'splashScreen', value: true)
        .then((value) {
      if (value == true) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: PageView.builder(
                controller: controller,
                physics: const BouncingScrollPhysics(),
                itemCount: boardingList.length,
                itemBuilder: (context, index) =>
                    OnBoardingWidget(boardingList[index]),
                onPageChanged: (index) {
                  if (index == boardingList.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    isLast = false;
                  }
                },
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  count: boardingList.length,
                  controller: controller,
                  effect: const ExpandingDotsEffect(
                      activeDotColor: AppColor.mainColor),
                ),
                const Spacer(),
                FloatingActionButton(
                  backgroundColor: AppColor.mainColor,
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      controller.nextPage(
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeInOutCubic);
                    }
                  },
                  child: const Icon(
                    Icons.arrow_forward,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget OnBoardingWidget(SplashScreenModel boardingList) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Image(image: NetworkImage(boardingList.image))),
        const SizedBox(
          height: 10,
        ),
        Text(
          boardingList.title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          boardingList.body,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
