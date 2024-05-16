import 'package:flutter/material.dart';
import 'package:jongsul/tools/style.dart';
import 'dart:async';


const List<String> _tags = <String>[];

class UploadProblemScreen extends StatefulWidget {
  const UploadProblemScreen({super.key});

  @override
  State<UploadProblemScreen> createState() => _UploadProblemScreenState();
}

class _UploadProblemScreenState extends State<UploadProblemScreen> {
  TextEditingController description = TextEditingController();
  TextEditingController tag = TextEditingController();
  final FocusNode _chipFocusNode = FocusNode();
  List<String> _toppings = <String>[];
  List<String> _suggestions = <String>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("문제 공유")), // 앱바 사용
        body: SafeArea(
          //메인 화면
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Divider(
                  color: Color(0xFFD5C3B5),
                  height: 1,
                ),

                Padding(
                  padding: EdgeInsets.only(left: 20, top: 50, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '설명',
                        style: TextStyle(fontSize: 25),
                      ),
                      Text(
                        '(100자 이내)',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                    ],
                  ),
                ),

                Divider(
                  color: Color(0xFFD5C3B5),
                  height: 1,
                ),
                Center(
                  child: Padding(
                    child: TextField(
                      maxLength: 100,
                      maxLines: 5,
                      controller: description,
                      decoration: InputDecoration(
                        hintText: '설명을 입력해 주세요.',
                        labelStyle: TextStyle(color: Color(0xFF8B5000)),
                        border: InputBorder.none,
                        counterText: '', //글자수 제한 표시 없앰
                      ),
                      // textInputAction: TextInputAction.search,
                    ),
                    padding: EdgeInsets.all(20),
                  ),
                ),
                Divider(
                  color: Color(0xFFD5C3B5),
                  height: 1,
                ),
                SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '태그',
                        style: TextStyle(fontSize: 25),
                      ),
                    ],
                  ),
                ),

                Divider(
                  color: Color(0xFFD5C3B5),
                  height: 1,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 500,
                        child: Padding(
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: ChipsInput<String>(
                                  values: _toppings,
                                  // decoration: const InputDecoration(
                                  //   prefixIcon: Icon(Icons.local_pizza_rounded),
                                  //   // hintText: 'Search for toppings',
                                  // ),
                                  strutStyle: const StrutStyle(fontSize: 15),
                                  onChanged: _onChanged,
                                  onSubmitted: _onSubmitted,
                                  chipBuilder: _chipBuilder,
                                 // onTextChanged: _onSearchChanged,
                                ),
                              ),


                            ],
                          ),

                          // TextField(
                          //   // maxLines: 30, // 최대 높이(줄) 설정
                          //   // minLines: 1, // 최소 높이(줄) 설정
                          //   maxLength: 1000,
                          //   controller: tag,
                          //   decoration: InputDecoration(
                          //     hintText: '태그를 입력해 주세요.',
                          //     labelStyle: TextStyle(color: Color(0xFF8B5000)),
                          //     border: InputBorder.none,
                          //     counterText: '', //글자수 제한 표시 없앰
                          //   ),
                          //   //textInputAction: TextInputAction.search,
                          // ),
                          padding: EdgeInsets.all(20),

                        ),
                      ),
                      // Padding(
                      //     padding: EdgeInsets.only(right: 10),
                      //     child: ElevatedButton(
                      //       //icon: Icon(Icons.download, size: 18),
                      //       child: Text("추가", style: TextStyle(
                      //           color: Colors.white, fontSize: 14, fontWeight: FontWeight.normal)),
                      //       onPressed: () {},
                      //       style: ElevatedButton.styleFrom(
                      //           backgroundColor: Color(0XFF8B5000),
                      //           padding: EdgeInsets.symmetric(
                      //               horizontal: 30, vertical: 15),
                      //       ),
                      //     )),
                    ]),
                Divider(
                  color: Color(0xFFD5C3B5),
                  height: 1,
                ),
                SizedBox(
                  height: 30,
                ),


                // FlatButton(
                //   onPressed: () {
                //     // 여기에 게시글을 서버에 전송하는 로직을 추가할 수 있습니다.
                //     String postContent = subjectController.text;
                //   },
                //   color: Colors.blue,
                //   textColor: Colors.white,
                //   child: Text('Post'),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          ElevatedButton(
                            //icon: Icon(Icons.download, size: 18),
                            child: Text("공유하기",style: TextStyle(
                                color: Colors.white, fontSize: 14,
                                fontWeight: FontWeight.normal)),
                            onPressed: () {
                              //   Navigator.push(
                              //     context,
                              //     MaterialPageRoute(builder: (context) => GenerateProblemUserChoiceScreen()),
                              //   );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0XFF8B5000),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 15),
                                ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
  // Future<void> _onSearchChanged(String value) async {
  //   final List<String> results = await _suggestionCallback(value);
  //   setState(() {
  //     _suggestions = results
  //         .where((String topping) => !_toppings.contains(topping))
  //         .toList();
  //   });
  // }

  Widget _chipBuilder(BuildContext context, String topping) {
    return ToppingInputChip(
      topping: topping,
      onDeleted: _onChipDeleted,
      onSelected: _onChipTapped,
    );
  }

  // void _selectSuggestion(String topping) {
  //   setState(() {
  //     _toppings.add(topping);
  //     _suggestions = <String>[];
  //   });
  // }

  void _onChipTapped(String topping) {}

  void _onChipDeleted(String topping) {
    setState(() {
      _toppings.remove(topping);
      _suggestions = <String>[];
    });
  }

  void _onSubmitted(String text) {
    if (text.trim().isNotEmpty) {
      setState(() {
        _toppings = <String>[..._toppings, text.trim()];
      });
    } else {
      _chipFocusNode.unfocus();
      setState(() {
        _toppings = <String>[];
      });
    }
  }

  void _onChanged(List<String> data) {
    setState(() {
      _toppings = data;
    });
  }

  FutureOr<List<String>> _suggestionCallback(String text) {
    if (text.isNotEmpty) {
      return _tags.where((String topping) {
        return topping.toLowerCase().contains(text.toLowerCase());
      }).toList();
    }
    return const <String>[];
  }
}

class ChipsInput<T> extends StatefulWidget {
  const ChipsInput({
    super.key,
    required this.values,
    this.decoration = const InputDecoration(),
    this.style,
    this.strutStyle,
    required this.chipBuilder,
    required this.onChanged,
    this.onChipTapped,
    this.onSubmitted,
    this.onTextChanged,
  });

  final List<T> values;
  final InputDecoration decoration;
  final TextStyle? style;
  final StrutStyle? strutStyle;

  final ValueChanged<List<T>> onChanged;
  final ValueChanged<T>? onChipTapped;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onTextChanged;

  final Widget Function(BuildContext context, T data) chipBuilder;

  @override
  ChipsInputState<T> createState() => ChipsInputState<T>();
}

class ChipsInputState<T> extends State<ChipsInput<T>> {
  @visibleForTesting
  late final ChipsInputEditingController<T> controller;

  String _previousText = '';
  TextSelection? _previousSelection;

  @override
  void initState() {
    super.initState();

    controller = ChipsInputEditingController<T>(
      <T>[...widget.values],
      widget.chipBuilder,
    );
    controller.addListener(_textListener);
  }

  @override
  void dispose() {
    controller.removeListener(_textListener);
    controller.dispose();

    super.dispose();
  }

  void _textListener() {
    final String currentText = controller.text;

    if (_previousSelection != null) {
      final int currentNumber = countReplacements(currentText);
      final int previousNumber = countReplacements(_previousText);

      final int cursorEnd = _previousSelection!.extentOffset;
      final int cursorStart = _previousSelection!.baseOffset;

      final List<T> values = <T>[...widget.values];

      // If the current number and the previous number of replacements are different, then
      // the user has deleted the InputChip using the keyboard. In this case, we trigger
      // the onChanged callback. We need to be sure also that the current number of
      // replacements is different from the input chip to avoid double-deletion.
      if (currentNumber < previousNumber && currentNumber != values.length) {
        if (cursorStart == cursorEnd) {
          values.removeRange(cursorStart - 1, cursorEnd);
        } else {
          if (cursorStart > cursorEnd) {
            values.removeRange(cursorEnd, cursorStart);
          } else {
            values.removeRange(cursorStart, cursorEnd);
          }
        }
        widget.onChanged(values);
      }
    }

    _previousText = currentText;
    _previousSelection = controller.selection;
  }

  static int countReplacements(String text) {
    return text.codeUnits
        .where(
            (int u) => u == ChipsInputEditingController.kObjectReplacementChar)
        .length;
  }

  @override
  Widget build(BuildContext context) {
    controller.updateValues(<T>[...widget.values]);

    return TextField(
      minLines: 1,
      maxLines: 3,
      textInputAction: TextInputAction.done,
      style: widget.style,
      strutStyle: widget.strutStyle,
      controller: controller,
      decoration: InputDecoration(
            hintText: '태그를 입력해 주세요.',
            labelStyle: TextStyle(color: Color(0xFF8B5000)),
            border: InputBorder.none,
            counterText: '', //글자수 제한 표시 없앰
          ),
      onChanged: (String value) =>
          widget.onTextChanged?.call(controller.textWithoutReplacements),
      onSubmitted: (String value) =>
          widget.onSubmitted?.call(controller.textWithoutReplacements),
    );
  }
}

class ChipsInputEditingController<T> extends TextEditingController {
  ChipsInputEditingController(this.values, this.chipBuilder)
      : super(
    text: String.fromCharCode(kObjectReplacementChar) * values.length,
  );

  // This constant character acts as a placeholder in the TextField text value.
  // There will be one character for each of the InputChip displayed.
  static const int kObjectReplacementChar = 0xFFFE;

  List<T> values;

  final Widget Function(BuildContext context, T data) chipBuilder;

  /// Called whenever chip is either added or removed
  /// from the outside the context of the text field.
  void updateValues(List<T> values) {
    if (values.length != this.values.length) {
      final String char = String.fromCharCode(kObjectReplacementChar);
      final int length = values.length;
      value = TextEditingValue(
        text: char * length,
        selection: TextSelection.collapsed(offset: length),
      );
      this.values = values;
    }
  }

  String get textWithoutReplacements {
    final String char = String.fromCharCode(kObjectReplacementChar);
    return text.replaceAll(RegExp(char), '');
  }

  String get textWithReplacements => text;

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
        TextStyle? style,
        required bool withComposing}) {
    final Iterable<WidgetSpan> chipWidgets =
    values.map((T v) => WidgetSpan(child: chipBuilder(context, v)));

    return TextSpan(
      style: style,
      children: <InlineSpan>[
        ...chipWidgets,
        if (textWithoutReplacements.isNotEmpty)
          TextSpan(text: textWithoutReplacements)
      ],
    );
  }
}

class ToppingSuggestion extends StatelessWidget {
  const ToppingSuggestion(this.topping, {super.key, this.onTap});

  final String topping;
  final ValueChanged<String>? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: ObjectKey(topping),
      title: Text(topping),
      onTap: () => onTap?.call(topping),
    );
  }
}

class ToppingInputChip extends StatelessWidget {
  const ToppingInputChip({
    super.key,
    required this.topping,
    required this.onDeleted,
    required this.onSelected,
  });

  final String topping;
  final ValueChanged<String> onDeleted;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 3),
      child: InputChip(
        key: ObjectKey(topping),
        label: Text(topping),

        onDeleted: () => onDeleted(topping),
        onSelected: (bool value) => onSelected(topping),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: const EdgeInsets.all(2),
      ),
    );
  }
}

//https://api.flutter.dev/flutter/material/InputChip-class.html