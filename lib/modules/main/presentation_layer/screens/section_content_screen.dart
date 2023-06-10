import 'package:BeWell/core/utils/navigation_manager.dart';
import 'package:BeWell/modules/main/presentation_layer/screens/course_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../bloc/main_bloc.dart';
import '../components/components.dart';

class SectionContentScreen extends StatelessWidget {
  final String courseName;
  final int whichSection;
  const SectionContentScreen({Key? key,required this.courseName,required this.whichSection}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    var bloc = MainBloc.get(context);
    int counter = bloc.doneSection!.done[courseName]!;
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
         return Scaffold(
            body: state is! ToContentSectionLoadingState
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.sp),
                    child: Column(
                      children: [
                        Expanded(
                          child: PageView(
                            onPageChanged: (index){
                              bloc.add(OnPageChangedEvent(index:index));
                            },
                            controller: pageController,
                            children: List.generate(bloc.widgets.length,
                                (index) => bloc.widgets[index]),
                          ),
                        ),
                        defaultButton(
                            text: bloc.doneButtonString,
                            onPressed: () {
                              if(bloc.doneButtonString == "انتهاء") {
                                if (whichSection == counter) {
                                  bloc.add(DoneSectionEvent(
                                      courseName: courseName,
                                      done: ++counter,
                                      progress: counter * 100 /
                                          bloc.prefixLesson.last
                                  ));
                                }
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return BlocBuilder<MainBloc, MainState>(
                                          builder: (context, state) {
                                            if (state is! DoneSectionLoadingState) {
                                              return Dialog(
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.symmetric(vertical: 20),
                                                  child: TextButton(
                                                    onPressed: (){
                                                      bloc.add(GetProgressEvent());
                                                      NavigationManager.push(context, const CourseScreen());
                                                    },
                                                    child: const Text("الانتقال الي الصفحة الرئيسية"),
                                                  ),
                                                ),
                                              );
                                            }else {
                                              return Container();
                                            }
                                          },
                                        );
                                      });
                              }else{
                                pageController.nextPage(
                                  duration: const Duration(
                                    milliseconds: 750,
                                  ),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                );
                              }
                            }),
                        SizedBox(
                          height: 4.h,
                        ),
                        SmoothPageIndicator(
                          controller: pageController, // PageController
                          count: bloc.widgets.length,
                        )
                      ],
                    ),
                  ):const Center(child: CircularProgressIndicator())
        );
      },
    );
  }
}
