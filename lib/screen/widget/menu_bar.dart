import 'package:flutter/material.dart';

class DownMenuBar extends StatelessWidget {
  const DownMenuBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        onTap: (int index){
          switch (index){
            // case 0:
            //   Navigator.pushNamed(context, '/');
            //   break;
            case 0:
              Navigator.pushNamed(context, '/library');
              break;
            case 1:
              Navigator.pushNamed(context, '/community');
              break;
            case 2:
              Navigator.pushNamed(context, '/profile');
              break;
            default:
          }
        },
        items: const [
          //BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.black,), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.folder, color: Colors.black,), label: "라이브러리"),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt, color: Colors.black,), label: "커뮤니티"),
          BottomNavigationBarItem(icon: Icon(Icons.person, color: Colors.black,), label: "내 정보"),
        ],
    );
    //네비게이션 바 양식
    // return  Column(
    //   children: [
    //     Container(
    //       width: 412,
    //       height: 80,
    //       padding: const EdgeInsets.symmetric(horizontal: 8),
    //       decoration: ShapeDecoration(
    //         color: Color(0xFFF7ECE4),
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.only(
    //             bottomLeft: Radius.circular(18),
    //             bottomRight: Radius.circular(18),
    //           ),
    //         ),
    //       ),
    //       child: Row(
    //         mainAxisSize: MainAxisSize.min,
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Expanded(
    //             child: Container(
    //               padding: const EdgeInsets.only(top: 12, bottom: 16),
    //               child: Column(
    //                 mainAxisSize: MainAxisSize.min,
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: [
    //                   Container(
    //                     clipBehavior: Clip.antiAlias,
    //                     decoration: ShapeDecoration(
    //                       color: Color(0xFFFFDCBE),
    //                       shape: RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.circular(16),
    //                       ),
    //                     ),
    //                     child: Column(
    //                       mainAxisSize: MainAxisSize.min,
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       crossAxisAlignment: CrossAxisAlignment.center,
    //                       children: [
    //                         Container(
    //                           width: 64,
    //                           height: 32,
    //                           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
    //                           child: Row(
    //                             mainAxisSize: MainAxisSize.min,
    //                             mainAxisAlignment: MainAxisAlignment.center,
    //                             crossAxisAlignment: CrossAxisAlignment.center,
    //                             children: [
    //                               Container(
    //                                 width: 24,
    //                                 height: 24,
    //                                 child: Row(
    //                                   mainAxisSize: MainAxisSize.min,
    //                                   mainAxisAlignment: MainAxisAlignment.center,
    //                                   crossAxisAlignment: CrossAxisAlignment.center,
    //                                   children: [
    //                                     Container(
    //                                       width: 24,
    //                                       height: 24,
    //                                       decoration: BoxDecoration(
    //                                         image: DecorationImage(
    //                                           image: NetworkImage("https://via.placeholder.com/24x24"),
    //                                           fit: BoxFit.fill,
    //                                         ),
    //                                       ),
    //                                     ),
    //                                   ],
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   SizedBox(
    //                     width: double.infinity,
    //                     child: Text(
    //                       '홈',
    //                       textAlign: TextAlign.center,
    //                       style: TextStyle(
    //                         color: Color(0xFF201B16),
    //                         fontSize: 12,
    //                         fontFamily: 'Roboto',
    //                         fontWeight: FontWeight.w600,
    //                         height: 0.11,
    //                         letterSpacing: 0.50,
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //           Expanded(
    //             child: Container(
    //               padding: const EdgeInsets.only(top: 12, bottom: 16),
    //               child: Column(
    //                 mainAxisSize: MainAxisSize.min,
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: [
    //                   Container(
    //                     width: 32,
    //                     decoration: ShapeDecoration(
    //                       shape: RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.circular(16),
    //                       ),
    //                     ),
    //                     child: Row(
    //                       mainAxisSize: MainAxisSize.min,
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       crossAxisAlignment: CrossAxisAlignment.center,
    //                       children: [
    //                         Container(
    //                           width: 64,
    //                           height: 32,
    //                           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
    //                           child: Row(
    //                             mainAxisSize: MainAxisSize.min,
    //                             mainAxisAlignment: MainAxisAlignment.center,
    //                             crossAxisAlignment: CrossAxisAlignment.center,
    //                             children: [
    //                               Container(
    //                                 width: 24,
    //                                 height: 24,
    //                                 padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
    //                                 child: Row(
    //                                   mainAxisSize: MainAxisSize.min,
    //                                   mainAxisAlignment: MainAxisAlignment.center,
    //                                   crossAxisAlignment: CrossAxisAlignment.center,
    //                                   children: [
    //                                   ,
    //                                   ],
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   SizedBox(
    //                     width: double.infinity,
    //                     child: Text(
    //                       '라이브러리',
    //                       textAlign: TextAlign.center,
    //                       style: TextStyle(
    //                         color: Color(0xFF51453A),
    //                         fontSize: 12,
    //                         fontFamily: 'Roboto',
    //                         fontWeight: FontWeight.w500,
    //                         height: 0.11,
    //                         letterSpacing: 0.50,
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //           Expanded(
    //             child: Container(
    //               padding: const EdgeInsets.only(top: 12, bottom: 16),
    //               child: Column(
    //                 mainAxisSize: MainAxisSize.min,
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: [
    //                   Container(
    //                     width: 32,
    //                     decoration: ShapeDecoration(
    //                       shape: RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.circular(16),
    //                       ),
    //                     ),
    //                     child: Row(
    //                       mainAxisSize: MainAxisSize.min,
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       crossAxisAlignment: CrossAxisAlignment.center,
    //                       children: [
    //                         Container(
    //                           width: 64,
    //                           height: 32,
    //                           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
    //                           child: Row(
    //                             mainAxisSize: MainAxisSize.min,
    //                             mainAxisAlignment: MainAxisAlignment.center,
    //                             crossAxisAlignment: CrossAxisAlignment.center,
    //                             children: [
    //                               Container(
    //                                 width: 24,
    //                                 height: 24,
    //                                 child: Row(
    //                                   mainAxisSize: MainAxisSize.min,
    //                                   mainAxisAlignment: MainAxisAlignment.center,
    //                                   crossAxisAlignment: CrossAxisAlignment.center,
    //                                   children: [
    //                                     Container(
    //                                       width: 24,
    //                                       height: 24,
    //                                       decoration: BoxDecoration(
    //                                         image: DecorationImage(
    //                                           image: NetworkImage("https://via.placeholder.com/24x24"),
    //                                           fit: BoxFit.fill,
    //                                         ),
    //                                       ),
    //                                     ),
    //                                   ],
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   SizedBox(
    //                     width: double.infinity,
    //                     child: Text(
    //                       '커뮤니티',
    //                       textAlign: TextAlign.center,
    //                       style: TextStyle(
    //                         color: Color(0xFF51453A),
    //                         fontSize: 12,
    //                         fontFamily: 'Roboto',
    //                         fontWeight: FontWeight.w500,
    //                         height: 0.11,
    //                         letterSpacing: 0.50,
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //           Expanded(
    //             child: Container(
    //               padding: const EdgeInsets.only(top: 12, bottom: 16),
    //               child: Column(
    //                 mainAxisSize: MainAxisSize.min,
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: [
    //                   Container(
    //                     width: 32,
    //                     decoration: ShapeDecoration(
    //                       shape: RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.circular(16),
    //                       ),
    //                     ),
    //                     child: Row(
    //                       mainAxisSize: MainAxisSize.min,
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       crossAxisAlignment: CrossAxisAlignment.center,
    //                       children: [
    //                         Container(
    //                           width: 64,
    //                           height: 32,
    //                           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
    //                           child: Row(
    //                             mainAxisSize: MainAxisSize.min,
    //                             mainAxisAlignment: MainAxisAlignment.center,
    //                             crossAxisAlignment: CrossAxisAlignment.center,
    //                             children: [
    //                               Container(
    //                                 width: 24,
    //                                 height: 24,
    //                                 padding: const EdgeInsets.all(4),
    //                                 child: Row(
    //                                   mainAxisSize: MainAxisSize.min,
    //                                   mainAxisAlignment: MainAxisAlignment.center,
    //                                   crossAxisAlignment: CrossAxisAlignment.center,
    //                                   children: [
    //                                     Container(
    //                                       width: 16,
    //                                       height: 16,
    //                                       decoration: BoxDecoration(
    //                                         image: DecorationImage(
    //                                           image: NetworkImage("https://via.placeholder.com/16x16"),
    //                                           fit: BoxFit.fill,
    //                                         ),
    //                                       ),
    //                                     ),
    //                                   ],
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   SizedBox(
    //                     width: double.infinity,
    //                     child: Text(
    //                       '내 정보',
    //                       textAlign: TextAlign.center,
    //                       style: TextStyle(
    //                         color: Color(0xFF51453A),
    //                         fontSize: 12,
    //                         fontFamily: 'Roboto',
    //                         fontWeight: FontWeight.w500,
    //                         height: 0.11,
    //                         letterSpacing: 0.50,
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ],
    // );
  }
}