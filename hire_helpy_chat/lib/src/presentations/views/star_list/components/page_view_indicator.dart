import 'package:dh_employer/src/presentations/values/values.dart';
import 'package:flutter/material.dart';

class PageViewIndicator extends StatelessWidget {
  final int currentPage;
  final int pageCount;
  

  const PageViewIndicator({super.key, 
    required this.currentPage,
    required this.pageCount,
    
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: Container(
        child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List<Widget>.generate(
                      pageCount,
                      (index) {
                        return currentPage == index
                            ? Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                width: 50.0,
                                height: 5.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: currentPage == index
                                      ? AppColors.primaryColor
                                      : AppColors.white,
                                ),
                              )
                            : Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                width: 8.0,
                                height: 8.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: currentPage == index
                                      ? null
                                      : AppColors.white,
                                ),
                              );
                      },
                    ),
                  ),
      ),
    );
  }
}
