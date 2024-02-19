import 'package:flutter/material.dart';

class CommunitySearch extends StatefulWidget {
  const CommunitySearch({super.key});

  @override
  State<CommunitySearch> createState() => _CommunitySearchState();
}

class _CommunitySearchState extends State<CommunitySearch> {
  @override
  Widget build(BuildContext context) {
    return Column(
      //불투명한 배경색 필요함
      children: [
        const SizedBox(
          height: 150,
        ),
        Container(
          width: 412,
          height: 690,
          padding: const EdgeInsets.only(bottom: 598),
          clipBehavior: Clip.antiAlias,
          decoration: const ShapeDecoration(
            color: Color(0xFFFDF2EA),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(28),
                topRight: Radius.circular(28),
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 36,
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Opacity(
                      opacity: 0.40,
                      child: Container(
                        width: 32,
                        height: 4,
                        decoration: ShapeDecoration(
                          color: Color(0xFF837468),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 314,
                height: 56,
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4),
                    ),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(width: 3, color: Color(0xFF8B5000)),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                decoration: const ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      topRight: Radius.circular(4),
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    // Expanded(
                                    //   child: Container(
                                    //     height: 48,
                                    //     padding: const EdgeInsets.symmetric(vertical: 4),
                                    //     child: Column(
                                    //       mainAxisSize: MainAxisSize.min,
                                    //       mainAxisAlignment: MainAxisAlignment.center,
                                    //       crossAxisAlignment: CrossAxisAlignment.start,
                                    //       children: [
                                    //         Container(
                                    //           child: const Row(
                                    //             mainAxisSize: MainAxisSize.min,
                                    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //             crossAxisAlignment: CrossAxisAlignment.center,
                                    //             children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                          Icons.search
                                                      ),
                                                      Text(
                                                        'Input',
                                                        style: TextStyle(
                                                          color: Color(0xFF201B16),
                                                          fontSize: 16,
                                                          fontFamily: 'Roboto',
                                                          fontWeight: FontWeight.w400,
                                                          height: 0.09,
                                                          letterSpacing: 0.50,
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                  Icon(
                                                    Icons.highlight_off,
                                                  ),
                                                ],
                                    //           ),
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),

                          //         ],
                          //       ),
                          //     ),
                          //   ),
                           ],
                        ),
                      ),
                    ),
                    Container(
                      width: 314,
                      padding: const EdgeInsets.only(top: 14, left: 16, right: 16),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: SizedBox(
                              child: Text(
                                'Supporting text',
                                style: TextStyle(
                                  color: Color(0xFF51453A),
                                  fontSize: 12,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  height: 0.11,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
