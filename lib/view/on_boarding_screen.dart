import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:petwarden/utils/constants/colors.dart';
import 'package:petwarden/utils/constants/icon_paths.dart';
import 'package:petwarden/utils/constants/image_paths.dart';
import 'package:petwarden/view/auth/log_in_screen.dart';
import 'package:petwarden/widgets/custom/custom_tab_indicator.dart';
import 'package:petwarden/widgets/custom/custom_text_styles.dart';

class OnboardingPage extends StatefulWidget {
  static const String routeName = "/onBoardingPage/";
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

List<String> backgroundImages = [
  ImagePath.onboarding1,
  ImagePath.onboarding2,
  ImagePath.onboarding3,
];

class _OnboardingPageState extends State<OnboardingPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int swipetab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
    );

    _tabController.animation?.addListener(() {
      int newState = swipetab;
      if (_tabController.offset > 0.5) {
        newState = _tabController.index + 1;
      } else if (_tabController.offset < -0.5) {
        newState = _tabController.index - 1;
      } else {
        newState = _tabController.index;
      }

      // "Debounce" stateswitch, so that we don't get 100's of events
      if (newState != swipetab) {
        setState(() {
          swipetab = newState;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Container(
              width: Get.width,
              color: PetWardenColors.primaryColor,
            ),
          ),
          Positioned(
            top: 30,
            width: Get.width,
            child: Image.asset(
              backgroundImages[swipetab],
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 35),
                  child: Column(children: [
                    const SizedBox(height: 20),
                    SizedBox(
                      height: Get.height / 5,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Unlock Pawsibilities!",
                                style: CustomTextStyles.f28W700(),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Welcome to Pet Warden, where \nfinding the right sitter is a walk in the \npark! Get ready to open the door to a \nworld of furry friendship and trusted\n care.",
                                style: CustomTextStyles.f16W600(),
                              )
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Who Let the Dogs Out?",
                                style: CustomTextStyles.f28W700(),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "No more ruff times! Our app fetches \ntrustworthy pet sitters in your neighborhood. It's time to give your\n pets a vacation too! ",
                                style: CustomTextStyles.f16W600(),
                              )
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Pet Sitting, Simplified! ",
                                style: CustomTextStyles.f28W700(),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Sit back, relax, and let Pet Warden be\n your furry friend's guardian angel. \nFinding the perfect pet sitter has never been this pawsome! ",
                                style: CustomTextStyles.f16W600(),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TabIndicator(
                          selectedColor: PetWardenColors.primaryColor,
                          unselectedColor: PetWardenColors.borderColor,
                          num: 3,
                          pos: swipetab,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (swipetab < 2) {
                              _tabController.animateTo(++swipetab);
                            } else {
                              Get.toNamed(LogInScreen.routeName);
                            }
                          },
                          child: Container(
                            height: 52,
                            width: 52,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: PetWardenColors.primaryColor),
                            padding: const EdgeInsets.all(12),
                            child: SvgPicture.asset(IconPath.rightArrowAlt),
                          ),
                        )
                      ],
                    ),

                    // SizedBox(
                    //   height: 48,
                    //   width: double.infinity,
                    //   child: TextButton(
                    //       style: TextButton.styleFrom(
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(10),
                    //         ),
                    //         backgroundColor: PetWardenColors.primaryColor,
                    //       ),
                    //       child: Text(
                    //         swipetab == 0 ? "Get Started" : "Next",
                    //         style: const TextStyle(
                    //           color: Colors.white,
                    //           fontWeight: FontWeight.w600,
                    //           fontSize: 16,
                    //         ),
                    //       ),
                    //       onPressed: () async {
                    //         if (swipetab < 4) {
                    //           _tabController.animateTo(++swipetab);
                    //         } else {
                    //           Get.toNamed(LogInScreen.routeName);
                    //         }
                    //       }),
                    // ),
                    const SizedBox(height: 24),
                  ]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
