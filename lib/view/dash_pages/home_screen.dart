import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petwarden/controller/dash_pages/home_page_controller.dart';
import 'package:petwarden/utils/constants/colors.dart';
import 'package:petwarden/view/booking/pet_sitter_profile.dart';
import 'package:petwarden/widgets/custom/custom_network_image.dart';
import 'package:petwarden/widgets/custom/custom_search_field.dart';
import 'package:petwarden/widgets/custom/custom_text_styles.dart';
import 'package:petwarden/widgets/pet_sitter_tile.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:petwarden/widgets/shimmers/sitter_shimmer.dart';

import '../../utils/constants/image_paths.dart';

class HomeScreen extends StatelessWidget {
  final c = Get.find<HomePageController>();
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RxInt selectedIndex = 0.obs;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 20,
          automaticallyImplyLeading: false,
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
            child: CustomScrollView(slivers: [
              SliverToBoxAdapter(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Obx(() => Text(
                        "Hello, ${c.firstName.value} 👋",
                        style: CustomTextStyles.f20W600(color: PetWardenColors.textColor),
                      )),

                  const SizedBox(
                    height: 20,
                  ),
                  const CustomSearchField(
                      border: PetWardenColors.borderColor,
                      prefixIcon: Icon(
                        Icons.search,
                        color: PetWardenColors.textGrey,
                      ),
                      hint: "Search all of Pet Warden",
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.text),
                  const SizedBox(
                    height: 33,
                  ),
                  Text(
                    "Featured Sitters",
                    style: CustomTextStyles.f14W400(color: PetWardenColors.textGrey),
                  ),
                  // const FeaturedPetSitters(),

                  Obx(() {
                    if (c.isLoading.value) {
                      return SitterShimmer.featuredList();
                    } else {
                      return Container(
                          margin: const EdgeInsets.only(top: 25),
                          child: Obx(
                            () => CarouselSlider.builder(
                              // itemCount: c.featuredSitterLists.length,
                              // itemCount: c.featuredSitters.length,
                              itemCount:
                                  c.featuredSitters.length > 3 ? 3 : c.featuredSitters.length,
                              itemBuilder: (context, index, realIndex) {
                                var featuredSitters = c.featuredSitters[index];
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: PetWardenColors.blueCardColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15, top: 10, bottom: 4),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(12),
                                              child: CustomNetworkImage(
                                                imageUrl: featuredSitters.profileImageUrl ?? "",
                                                height: 77,
                                                width: 77,
                                              ),
                                            ),
                                            const Spacer(),
                                            Row(
                                              children: [
                                                const Icon(Icons.star_rounded,
                                                    color: PetWardenColors.secondaryColor),
                                                Text(
                                                  "${featuredSitters.avgRating}/5 (${featuredSitters.reviewCount})",
                                                  style: const TextStyle(
                                                      color: PetWardenColors.cyanColor,
                                                      fontSize: 12),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      overflow: TextOverflow.ellipsis,
                                                      featuredSitters.name ?? "",
                                                      style: CustomTextStyles.f24W500(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  featuredSitters.status == "active"
                                                      ? Text(
                                                          "Available",
                                                          style: CustomTextStyles.f10W400(
                                                              color: PetWardenColors.cyanColor),
                                                        )
                                                      : Text(
                                                          "Unavailable",
                                                          style: CustomTextStyles.f10W400(
                                                              color: PetWardenColors.cyanColor),
                                                        ),
                                                  featuredSitters.status == "active"
                                                      ? Container(
                                                          height: 5,
                                                          width: 5,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius.circular(100),
                                                              color: const Color(0xff22EAB8)),
                                                        )
                                                      : Container(
                                                          height: 5,
                                                          width: 5,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius.circular(100),
                                                              color: PetWardenColors.errorColor),
                                                        )
                                                ],
                                              ),
                                              Expanded(
                                                child: Text(
                                                  softWrap: true,
                                                  featuredSitters.bio ?? "",
                                                  style:
                                                      CustomTextStyles.f12W300(color: Colors.white),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: Get.width / 4,
                                                    child: Text(
                                                      softWrap: false,
                                                      overflow: TextOverflow.ellipsis,
                                                      featuredSitters.address ?? "",
                                                      style: CustomTextStyles.f12W500(
                                                          color: PetWardenColors.cyanColor),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Get.toNamed(PetSitterProfile.routeName,
                                                          arguments: {"id": featuredSitters.id});
                                                    },
                                                    child: Container(
                                                      decoration: const BoxDecoration(
                                                          color: PetWardenColors.secondaryColor,
                                                          borderRadius:
                                                              BorderRadius.all(Radius.circular(4))),
                                                      child: Padding(
                                                        padding: const EdgeInsets.symmetric(
                                                            horizontal: 17, vertical: 7),
                                                        child: Text(
                                                          "Appoint",
                                                          style: CustomTextStyles.f12W500(
                                                              color: Colors.black),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              options: CarouselOptions(
                                height: 136,
                                aspectRatio: 16 / 9,
                                viewportFraction: 0.83,
                                initialPage: 0,
                                enableInfiniteScroll: true,
                                reverse: false,
                                autoPlay: true,
                                autoPlayInterval: const Duration(seconds: 3),
                                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enlargeCenterPage: true,
                                enlargeFactor: 0.3,
                                scrollDirection: Axis.horizontal,
                              ),
                            ),
                          ));
                    }
                  }),
                ]),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 33,
                ),
              ),
              SliverAppBar(
                pinned: true,
                snap: false,
                floating: false,
                automaticallyImplyLeading: false,
                leadingWidth: 0,
                toolbarHeight: 115,
                surfaceTintColor: PetWardenColors.backgroundColor,
                backgroundColor: Colors.white,
                flexibleSpace: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "What are you looking for?",
                      style: CustomTextStyles.f14W400(color: PetWardenColors.textGrey),
                    ),
                    SizedBox(
                      child: DefaultTabController(
                          length: 3,
                          initialIndex: selectedIndex.value,
                          child: Column(
                            children: [
                              TabBar(
                                onTap: (index) {
                                  if (index == 0) {
                                    selectedIndex.value = 0;
                                  } else if (index == 1) {
                                    selectedIndex.value = 1;
                                  } else if (index == 2) {
                                    selectedIndex.value = 2;
                                  }
                                },
                                labelStyle: CustomTextStyles.f14W600(),
                                unselectedLabelStyle: CustomTextStyles.f14W500(),
                                indicatorSize: TabBarIndicatorSize.tab,
                                dividerColor: Colors.transparent,
                                labelColor:
                                    PetWardenColors.textGrey, // Adjust label color as needed
                                unselectedLabelColor:
                                    PetWardenColors.highlightTextColor, // Adjust unselected color
                                indicatorColor: PetWardenColors.primaryColor,
                                tabs: const [
                                  Tab(
                                    text: 'Pet Sitters',
                                  ),
                                  Tab(text: 'Pet Grommer'),
                                  Tab(
                                    text: 'Pet Spots',
                                  ),
                                ],
                              )
                            ],
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Pet Sitters For ${c.petName.value}",
                          style: CustomTextStyles.f14W400(color: PetWardenColors.textGrey),
                        ),
                        const Text(
                          "View All",
                          style: TextStyle(color: PetWardenColors.buttonColor, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 30,
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Obx(
                    () {
                      switch (selectedIndex.value) {
                        case 0:
                          return Column(
                            children: [
                              c.isLoading.value
                                  ? SitterShimmer.sitterList()
                                  : ListView.builder(
                                      physics: const ClampingScrollPhysics(),
                                      itemCount: c.sitters.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        var sitter = c.sitters[index];
                                        return Padding(
                                          padding: const EdgeInsets.only(bottom: 15),
                                          child: PetSitterCard(
                                            imageUrl: sitter.profileImageUrl,
                                            name: sitter.name,
                                            available: sitter.status == "active" ? true : false,
                                            address: sitter.address,
                                            ratings: sitter.avgRating,
                                            stars: sitter.avgRating?.round(),
                                            // stars: double.parse(sitter.avgRating!).round(),
                                            // stars: sitter.avgRating?.round(),
                                            onTap: () {
                                              Get.toNamed(PetSitterProfile.routeName,
                                                  arguments: {"id": sitter.id});
                                            },
                                          ),
                                        );
                                      },
                                    ),
                            ],
                          );
                        case 1:
                          return const Text("Pet Groomer");
                        case 2:
                          return const Text("Pet friendly spots");
                        default:
                          return const Text("Error");
                      }
                    },
                  ),
                ]),
              ),
            ])));
  }
}
