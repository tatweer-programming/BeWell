import 'package:BeWell/core/utils/navigation_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/services/dep_injection.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../bloc/main_bloc.dart';
import '../components/components.dart';

class SectionContentScreen extends StatelessWidget {
  final String courseName;
  final int whichSection;
  const SectionContentScreen(
      {Key? key, required this.courseName, required this.whichSection})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    MainBloc bloc = sl()..add(ScheduleNewNotificationEvent());
    int counter = 0;
    if (bloc.doneSection != null &&
        bloc.doneSection!.done[courseName] != null) {
      counter = bloc.doneSection!.done[courseName]!;
    }
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    bloc.showAnswer = false;
                    bloc.doneButtonString = "التالي";
                    bloc.pageView = -1;
                    bloc.pageIndex = 0;
                    NavigationManager.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back)),
            ),
            body: state is! ToContentSectionLoadingState
                ? WillPopScope(
                    onWillPop: () async => false,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.sp),
                      child: Column(
                        children: [
                          Expanded(
                            child: PageView(
                              //physics: const NeverScrollableScrollPhysics(),
                              // physics: (bloc.pageView != bloc.pageIndex) || bloc.showAnswer ? const BouncingScrollPhysics():const NeverScrollableScrollPhysics(),
                              onPageChanged: (index) {
                                bloc.add(OnPageChangedEvent(index: index));
                              },
                              controller: pageController,
                              children: List.generate(
                                bloc.widgets.length,
                                (index) => bloc.widgets[index],
                              ),
                            ),
                          ),
                          bloc.pageView != bloc.pageIndex || bloc.showAnswer || bloc.showResult
                              ? defaultButton(
                                  text: bloc.doneButtonString,
                                  onPressed: () {
                                    if (bloc.doneButtonString == "انتهاء") {
                                      if (whichSection == counter) {
                                        bloc.add(DoneSectionEvent(
                                            courseName: courseName,
                                            done: ++counter,
                                            progress: (counter *
                                                100 /
                                                bloc.prefixLesson.last).round()));
                                      }
                                      showDialog(
                                          //barrierDismissible: false,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return BlocBuilder<MainBloc,
                                                MainState>(
                                              builder: (context, state) {
                                                if (state
                                                    is! DoneSectionLoadingState) {
                                                  return Dialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25.sp),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 20.sp),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                            "تم الإنتهاء بنجاح",
                                                            style: TextStyle(
                                                                color:
                                                                    ColorManager
                                                                        .secondary,
                                                                fontSize:
                                                                    FontSizeManager
                                                                        .s18.sp,
                                                                fontWeight:
                                                                    FontWeightManager
                                                                        .bold),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              bloc.add(
                                                                  GetProgressEvent());
                                                              NavigationManager
                                                                  .pop(context);
                                                              NavigationManager
                                                                  .pop(context);
                                                              bloc.widgets = [
                                                                Container()
                                                              ];
                                                              bloc.showAnswer =
                                                                  false;
                                                              bloc.doneButtonString =
                                                                  "التالي";
                                                              bloc.pageView =
                                                                  -1;
                                                              bloc.pageIndex =
                                                                  0;
                                                            },
                                                            child: Text(
                                                              "موافق",
                                                              style: TextStyle(
                                                                  color:
                                                                      ColorManager
                                                                          .black,
                                                                  fontSize:
                                                                      FontSizeManager
                                                                          .s14
                                                                          .sp,
                                                                  fontWeight:
                                                                      FontWeightManager
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  return Container();
                                                }
                                              },
                                            );
                                          });
                                    } else {
                                      pageController.nextPage(
                                        duration: const Duration(
                                          milliseconds: 750,
                                        ),
                                        curve: Curves.fastLinearToSlowEaseIn,
                                      );
                                    }
                                  })
                              : Container(),
                          SizedBox(
                            height: 4.h,
                          ),
                          SmoothPageIndicator(
                            controller: pageController, // PageController
                            count: bloc.widgets.length,
                          )
                        ],
                      ),
                    ),
                  )
                : const Center(child: CircularProgressIndicator()));
      },
    );
  }
}