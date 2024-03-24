import 'package:flutter/material.dart';
import 'package:jongsul/screen/widget/menu_bar.dart';
import 'package:jongsul/tools/color.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: 40,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(),
                child: Stack(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const ShapeDecoration(
                        color: Color(0xFF8B5000),
                        shape: OvalBorder(),
                      ),
                    ),
                    // SizedBox(
                    //   width: 40,
                    //   height: 40,
                    //   child:
                    // ),

                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Snowmate28',
                          style: TextStyle(
                            color: Color(0xFF201B16),
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            height: 0.09,
                            letterSpacing: 0.15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
