import 'package:flutter/material.dart';
import 'package:get/get.dart';


class DownloadButton extends StatefulWidget {
  //const DownloadButton({super.key});

  final String text;
  final bool isIcon;

  // 생성자를 통해 매개변수를 받음
  DownloadButton({required this.text, required this.isIcon});

  @override
  State<DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Container(
          width: 118,
          height: 40,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Color(0xFF8B5000),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 16,
                    right: 24,
                    bottom: 10,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      widget.isIcon
                          ? Container(
                              width: 15,
                              height: 15,
                              //padding: const EdgeInsets.all(3),
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.file_download_outlined,
                                    color: Colors.white, // <--- Icon color
                                    size: 15,
                                  ),
                                ],
                              ),
                            )
                          : Text(''),
                      widget.isIcon ? SizedBox(width: 8) : Text(''),
                      Text(
                        '${widget.text}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          height: 0.10,
                          letterSpacing: 0.10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
