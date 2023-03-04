import 'dart:async';
import 'dart:io';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';
import 'theme.dart';

enum LayoutSetting {
  First,
  Middle,
  Last,
}

enum Type { Link, SwitchButton, Text }

Widget PopupMenuCustom(
    GlobalKey<PopupMenuButtonState<int>>? key,
    BuildContext context,
    Widget widget,
    //Function? onSelected,
    List<PopupMenuItem> popupMenuItem,
    {Offset? offset}) {
  return PopupMenuButton(
      offset: offset ?? Offset(-20, 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: widget,
      //icon: icon,
      key: key,
      // onSelected: (value) {
      //   onSelected(value);
      // },
      itemBuilder: (context) => popupMenuItem);
}

Widget ButtonCustom(Color btnColor, Color btnTextColor, String btnText,
    {bool visible = true,
    EdgeInsetsGeometry? margin,
    Function? function,
    double height = 50,
    double width = double.infinity,
    double borderSize = 0,
    Color borderColor = Colors.black,
    EdgeInsets? padding,
    Icon? icons,
    Icon? iconTextFirst,
    Icon? iconTextLast,
    bool isDisable = false,
    double borderRadius = 15.0}) {
  return Visibility(
    visible: visible,
    child: Container(
      margin: margin,
      width: width,
      height: height,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            disabledForegroundColor: MyColors.disableTextButton,
            disabledBackgroundColor: MyColors.disableButton,
            foregroundColor: btnTextColor,
            backgroundColor: btnColor,
            padding: padding ?? EdgeInsets.only(right: 20, left: 20),
            side: isDisable
                ? BorderSide(
                    width: borderSize, color: MyColors.disableTextButton)
                : BorderSide(
                    width: borderSize,
                    color: borderSize == 0 ? btnColor : borderColor),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          onPressed: isDisable
              ? null
              : () {
                  print("onPressed");
                  if (function != null) {
                    function();
                  }
                },
          child: iconTextFirst == null
              ? icons ??
                  TextNormal2(btnText,
                      textColor:
                          isDisable ? MyColors.disableTextButton : btnTextColor,
                      fontSize: 11.sp)
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    iconTextFirst,
                    TextNormal2(btnText,
                        textColor: isDisable
                            ? MyColors.disableTextButton
                            : btnTextColor,
                        fontSize: 11.sp),
                    iconTextLast ?? Container(child: iconTextLast),
                  ],
                )),
    ),
  );
}

Widget ButtonCustom2(Color btnColor, Color btnTextColor, String btnText,
    {bool visible = true,
    EdgeInsetsGeometry? margin,
    Function? function,
    double height = 50,
    double width = double.infinity,
    double borderSize = 0,
    Color borderColor = Colors.black,
    EdgeInsets? padding,
    Icon? icons,
    Icon? iconTextFirst,
    Icon? iconTextLast,
    bool isDisable = false,
    double borderRadius = 10.0}) {
  return Visibility(
    visible: visible,
    child: Container(
      margin: margin,
      width: width,
      height: height == 50 ? 6.h : height,
      //height: height,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            disabledForegroundColor: MyColors.disableTextButton,
            disabledBackgroundColor: MyColors.disableButton,
            foregroundColor: btnTextColor,
            backgroundColor: btnColor,
            padding: padding ?? EdgeInsets.only(right: 20, left: 20),
            side: isDisable
                ? BorderSide(
                    width: borderSize, color: MyColors.disableTextButton)
                : BorderSide(
                    width: borderSize,
                    color: borderSize == 0 ? btnColor : borderColor),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius == 10.0 ? 10.sp : borderRadius),
            ),
          ),
          onPressed: isDisable
              ? null
              : () {
                  print("onPressed");
                  if (function != null) {
                    function();
                  }
                },
          child: iconTextFirst == null
              ? icons ??
                  TextNormal(btnText,
                      textColor:
                          isDisable ? MyColors.disableTextButton : btnTextColor)
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    iconTextFirst,
                    TextNormal(btnText,
                        textColor: isDisable
                            ? MyColors.disableTextButton
                            : btnTextColor),
                    //TextNormal(btnText, textColor: isDisable ? MyColors.disableTextButton  : btnTextColor),
                    iconTextLast ?? Container(child: iconTextLast),
                  ],
                )),
    ),
  );
}

Widget ShowDialogCustom(BuildContext context, String message,
    String buttonMessage, double height, Function? callback) {
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
    child: Container(
      height: height,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Text(message)),
            Spacer(),
            SizedBox(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    if (callback != null) {
                      callback();
                    }
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    buttonMessage,
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)))),
            )
          ],
        ),
      ),
    ),
  );
}

enum ButtonType {
  Success,
  Information,
  Wanning,
  Error,
}

Future<bool?> ShowDialogMessage(
  BuildContext contextMain,
  String title,
  String content,
  String buttonText, {
  String? buttonText2,
  ButtonType? buttonType,
  Function? actionButtonConfirm,
}) async {
  return await showDialog<bool>(
      barrierDismissible: false,
      context: contextMain,
      builder: (BuildContext context) {
        if (buttonType == ButtonType.Information) {
          return ShowDialogCustom2(context, title, content, [
            ButtonProperty(buttonText, Colors.white, MyColors.eZMockUpButtonColor, () {
              //Navigator.of(context).pop();
            }, borderColor: Colors.black),
          ]);
        } else if (buttonType == ButtonType.Wanning) {
          return ShowDialogCustom2(context, title, content, [
            ButtonProperty(buttonText == '' ? 'Cancel' : buttonText,
                Colors.black, Colors.white, () {
              //Navigator.of(contextb).pop();
            }, borderColor: Colors.black),
            ButtonProperty(
                buttonText2 ?? 'Confirm', Colors.white, MyColors.eZMockUpButtonColor, () {
              if (actionButtonConfirm != null) {
                actionButtonConfirm();
              } else {
                Navigator.of(context).pop(false);
              }
            }, borderColor: MyColors.eZMockUpButtonColor),
          ]);
        } else {
          return ShowDialogCustom2(context, title, content, [
            new ButtonProperty(buttonText, Colors.white, MyColors.eZMockUpButtonColor, () {
              //Navigator.of(context).pop();
            }, borderColor: MyColors.eZMockUpButtonColor),
          ]);
        }
      });
}

Widget ShowDialogCustom2(BuildContext context, String messageTitle,
    String messageDetail, List<ButtonProperty> lstButtonProperty) {
  return Dialog(
    insetPadding: EdgeInsets.all(30),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
    child: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(15.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
                child: TextNormal2(messageTitle,
                    fontSize: 15.sp, fontWeight: FontWeight.w500)),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: Center(
                  child: TextNormal2(messageDetail,
                      fontSize: 10.sp, textColor: Colors.grey.shade600)),
            ),
            if (lstButtonProperty.length == 1)
              SizedBox(
                height: 5.h,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      if (lstButtonProperty[0].function != null) {
                        lstButtonProperty[0].function();
                      }
                      Navigator.of(context).pop();
                    },
                    child: TextNormal2(
                        lstButtonProperty[0].buttonText,
                        textColor: lstButtonProperty[0].buttonColorText
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: lstButtonProperty[0].buttonColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)))),
              )
            else
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: SizedBox(
                          height: 5.h,
                          child: ElevatedButton(
                              onPressed: () {
                                if (lstButtonProperty[0].function != null) {
                                  lstButtonProperty[0].function();
                                }
                                Navigator.of(context).pop(true);
                              },
                              child: TextNormal2(
                                lstButtonProperty[0].buttonText,
                                textColor: lstButtonProperty[0].buttonColorText,
                              ),
                              style: ElevatedButton.styleFrom(
                                  side: lstButtonProperty[0].borderColor == null
                                      ? null
                                      : BorderSide(
                                          width: 1.0,
                                          color:
                                              lstButtonProperty[0].borderColor!,
                                        ),
                                  backgroundColor:
                                      lstButtonProperty[0].buttonColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)))),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: SizedBox(
                          height: 5.h,
                          child: ElevatedButton(
                              onPressed: () {
                                if (lstButtonProperty[1].function != null) {
                                  lstButtonProperty[1].function();
                                }
                                Navigator.of(context).pop(false);
                              },
                              child: TextNormal2(
                                  lstButtonProperty[1].buttonText,
                                  textColor: lstButtonProperty[1].buttonColorText
                              ),
                              style: ElevatedButton.styleFrom(
                                  side: lstButtonProperty[1].borderColor == null
                                      ? null
                                      : BorderSide(
                                          width: 1.0,
                                          color:
                                              lstButtonProperty[1].borderColor!,
                                        ),
                                  backgroundColor:
                                      lstButtonProperty[1].buttonColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ))),
                        ),
                      ),
                    )
                  ],
                ),
              )
          ],
        ),
      ),
    ),
  );
}

Widget ContainerSetting(BuildContext context, String textLeft, String textRight,
    Type type, LayoutSetting layoutSetting,
    {ValueNotifier<bool>? controller, Function? callback}) {
  return Container(
      padding: EdgeInsets.only(left: 7.w, top: 1.h, right: 7.w, bottom: 1.h),
      height: 8.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          //border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
          border: CheckLayOutSettingBorder(layoutSetting)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TextNormal(textLeft),
          CheckType(context, type, textRight, controller, callback)
        ],
      ));
}

Widget CheckType(BuildContext context, Type type, String textRight,
    ValueNotifier<bool>? controller, Function? callback) {
  if (type == Type.Link) {
    return InkWell(
        onTap: () {
          if (callback != null) {
            callback();
          } else {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  var dialog = ShowDialogCustom(
                      context, 'Test', 'ตกลง', 200.0, callback);
                  return dialog;
                });
          }
        },
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 5),
              child: TextNormal(textRight),
            ),
            Icon(Icons.arrow_forward_ios_rounded, size: 23),
          ],
        ));
  } else if (type == Type.SwitchButton) {
    return AdvancedSwitch(
        width: 48,
        height: 28,
        activeColor: Colors.orange,
        controller: controller ?? ValueNotifier<bool>(false));
  } else {
    return Row(children: [Text(textRight), Icon(null)]);
  }
}

BoxBorder CheckLayOutSettingBorder(LayoutSetting layoutSetting) {
  if (layoutSetting == LayoutSetting.First) {
    return Border(
      bottom: BorderSide(
        color: Colors.grey.shade200,
        width: 1.0,
      ),
      top: BorderSide(
        color: Colors.grey.shade200,
        width: 1.0,
      ),
    );
  } else if (layoutSetting == LayoutSetting.Middle) {
    return Border(
      bottom: BorderSide(
        color: Colors.grey.shade200,
        width: 1.0,
      ),
    );
  } else {
    return Border();
  }
}

Widget TextNormal2(String text,
    {TextAlign alignment = TextAlign.center,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.normal,
    Color textColor = Colors.black,
    int? maxline = null,
    TextDecoration decoration = TextDecoration.none}) {
  return Text(text,
      style: FontStyleNormal(
          fontSize: fontSize == 14 ? MyFontSize.sizeNormal : fontSize,
          //fontSize: 15.sp,
          fontWeight: fontWeight,
          textColor: textColor,
          decoration: decoration),
      textAlign: alignment,
      maxLines: maxline,
      overflow: maxline == null ? null : TextOverflow.ellipsis,
      softWrap: maxline == null ? true : false);
}

Widget TextNormal(String text,
    {TextAlign alignment = TextAlign.center,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.normal,
    Color textColor = Colors.black,
    int? maxline = null,
    TextDecoration decoration = TextDecoration.none}) {
  return Text(
    text,
    style: FontStyleNormal(
        fontSize: fontSize == 14 ? MyFontSize.sizeNormal : fontSize,
        fontWeight: fontWeight,
        textColor: textColor,
        decoration: decoration),
    textAlign: alignment,
    // maxLines: maxline,
    // overflow: TextOverflow.ellipsis,
      maxLines: maxline,
      overflow: maxline == null ? null : TextOverflow.ellipsis,
      softWrap: maxline == null ? true : false
  );
}

TextStyle FontStyleNormal(
    {double fontSize = 14,
    FontWeight fontWeight = FontWeight.normal,
    Color textColor = Colors.black,
    TextDecoration decoration = TextDecoration.none}) {
  return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontFamily: 'Prompt',
      color: textColor,
      decoration: decoration);
}

class ButtonProperty {
  String buttonText;
  Color buttonColorText;
  Color buttonColor;
  Color? borderColor;
  Function function;

  ButtonProperty(
      this.buttonText, this.buttonColorText, this.buttonColor, this.function,
      {this.borderColor});
}

List<T> ModuleSearch<T>(List<T> lst, List<String> lstFilter, String value) {
  final String cleanQuery = value.toLowerCase().trim();
  final List<T> result = lst
      .where(
        (item) => lstFilter.map((value) => value.toLowerCase().trim()).any(
          (value) {
            return value.contains(cleanQuery) == true;
          },
        ),
      )
      .toList();

  if (result.isEmpty) {
    return [];
  } else {
    return result;
  }
}

// ShowBottomSheet2(BuildContext context, String title, List<String> lst, Function function)
// {
//   List<BottomSheetAction> btmSheetAct = [];
//   for(int i = 0; i < lst.length; i++) {
//     btmSheetAct.add(
//         new BottomSheetAction(
//             title:Text(lst[i]),
//             onPressed: (context) {
//               print('Click item $lst[i]');
//               Navigator.of(context).pop();
//               function(lst[i]);
//             }));
//   }
//
//   showAdaptiveActionSheet(
//     title: TextNormal(title),
//     context: context,
//     actions: btmSheetAct,
//     cancelAction: CancelAction(title: Text('Cancel'), onPressed: (context) {
//       Navigator.of(context).pop();
//     }),// onPressed parameter is optional by default will dismiss the ActionSheet
//   );
// }

Future<File> createFileOfPdfUrl(String url) async {
  Completer<File> completer = Completer();
  print("Start download file from internet!");
  try {
    final filenamez = url.substring(url.lastIndexOf("/") + 1);
    print('filenamez : ' + filenamez);
    final filename = "pdpa";
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    var dir = await getApplicationDocumentsDirectory();
    print("Download files");
    print("${dir.path}/$filename");
    File file = File("${dir.path}/$filename");

    await file.writeAsBytes(bytes, flush: true);
    completer.complete(file);
  } catch (e) {
    throw Exception('Error parsing asset file! : ' + e.toString());
  }

  return completer.future;
}

Future<File> fromAsset(String asset, String filename) async {
  Completer<File> completer = Completer();

  try {
    var dir = await getApplicationDocumentsDirectory();
    File file = File("${dir.path}/$filename");
    var data = await rootBundle.load(asset);
    var bytes = data.buffer.asUint8List();
    await file.writeAsBytes(bytes, flush: true);
    completer.complete(file);
  } catch (e) {
    throw Exception('Error parsing asset file!');
  }

  return completer.future;
}

void ShowToast(BuildContext context, String message,
    {int timeDurationSec = 2,
    ToastType toastType = ToastType.Success,
    Color? colors,
    double height = 80.0}) {
  late FToast fToast;
  fToast = FToast();
  fToast.init(context);

  Widget toast = Container(
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: colors ?? toastType.bgColor),
    child: TextNormal2(message,
        textColor: toastType.txtColor, alignment: TextAlign.center),
  );

  fToast.showToast(
      child: toast,
      //gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: timeDurationSec),
      positionedToastBuilder: (context, child) {
        return Positioned(bottom: height, left: 24, right: 24, child: child);
      });

  // Custom Toast Position
  // fToast.showToast(
  //     child: toast,
  //     toastDuration: Duration(seconds: 1),
  //     positionedToastBuilder: (context, child) {
  //       return Positioned(
  //         child: child,
  //         top: 16.0,
  //         left: 16.0,
  //       );
  //     });
}

enum ToastType {
  Success,
  Wanning,
  Error,
}

extension ToastTypeColor on ToastType {
  Color get bgColor {
    switch (this) {
      case ToastType.Success:
        return Colors.greenAccent;
      case ToastType.Wanning:
        return Colors.orangeAccent;
      case ToastType.Error:
        return Colors.redAccent;
      default:
        return Colors.grey;
    }
  }

  Color get txtColor {
    switch (this) {
      case ToastType.Success:
        return Colors.black;
      case ToastType.Wanning:
        return Colors.white;
      case ToastType.Error:
        return Colors.white;
      default:
        return Colors.black;
    }
  }
}

ShowBottomSheet(BuildContext context, List<String> lst, Function function,
    {String? title}) {
  List<BottomSheetAction> btmSheetAct = [];
  for (int i = 0; i < lst.length; i++) {
    btmSheetAct.add(new BottomSheetAction(
        title: Text(lst[i]),
        onPressed: (context) {
          function(lst[i]);
          Navigator.of(context).pop();
        }));
  }

  showAdaptiveActionSheet(
    title: title == null ? null : TextNormal(title),
    context: context,
    actions: btmSheetAct,
    cancelAction: CancelAction(
        title: Text('Cancel'),
        onPressed: (context) {
          Navigator.of(context).pop();
        }), // onPressed parameter is optional by default will dismiss the ActionSheet
  );
}

typedef WidgetItemBuilder<T> = Widget Function(T item);
ShowBottomSheet2<T>(
    {required BuildContext context,
    required List<T> lstItem,
    required Function onPressedItem,
    required WidgetItemBuilder<T> itemBuilder,
    String? title,
    String? cancelText}) {
  List<BottomSheetAction> btmSheetAct = [];
  for (int i = 0; i < lstItem.length; i++) {
    btmSheetAct.add(BottomSheetAction(
        title: itemBuilder(lstItem[i]),
        onPressed: (context) {
          onPressedItem(lstItem[i]);
          Navigator.of(context).pop();
        }));
  }

  showAdaptiveActionSheet(
    title: title == null ? null : TextNormal(title, fontWeight: FontWeight.w500),
    context: context,
    actions: btmSheetAct,
    cancelAction: CancelAction(
        title: TextNormal(cancelText ?? 'Cancel', textColor: Color.fromARGB(255, 5, 169, 244), fontWeight: FontWeight.w500, fontSize: 14.sp),
        //title: Text(cancelText ?? 'Cancel'),
        onPressed: (context) {
          Navigator.of(context).pop();
        }), // onPressed parameter is optional by default will dismiss the ActionSheet
  );
}

Widget RowItemSelect(BuildContext context, String initialTextVal,
    String textHeader, String textValue, Function onSelect,
    {Widget? widgetText1, Widget? widgetText2, String? selectText, Color? selectTextColor, bool visible = true}) {
  return Container(
      //width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black12,
            width: 1.0,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
              padding: EdgeInsets.only(bottom: 2.h),
              width: MediaQuery.of(context).size.width,
              child: widgetText1 ??
                  TextNormal(textHeader,
                      alignment: TextAlign.left,
                      textColor: MyColors.eZMockUpGrey130)),
          Container(
            padding: EdgeInsets.only(bottom: 1.5.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: widgetText2 ??
                        TextNormal(textValue,
                            textColor: initialTextVal == textValue
                                ? Colors.grey.shade400
                                : visible ? Colors.black : Color.fromARGB(255, 89, 89, 89),
                            maxline: 1)),
                Visibility(
                  visible: visible,
                  child: InkWell(
                      onTap: () {
                        onSelect();
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 5),
                        child: TextNormal(selectText ?? 'Select',
                            decoration: TextDecoration.underline,
                            textColor: selectTextColor??MyColors.eZMockUpGrey130),
                      )),
                ),
              ],
            ),
          )
        ],
      ));
}

class LegendWidget extends StatelessWidget {
  LegendWidget(
      {super.key,
      required this.name,
      required this.color,
      required this.widthCircle,
      required this.heightCircle,
       this.fontWeight,
      this.fontSize,
      this.textColor});
  final String name;
  final Color color;
  final double widthCircle;
  final double heightCircle;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? textColor;


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: widthCircle,
          height: heightCircle,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 6),
        TextNormal2(name, fontSize: fontSize ?? 10.sp, maxline: 1,fontWeight:fontWeight??FontWeight.w500,textColor:textColor ?? Colors.black),
      ],
    );
  }
}

class LegendsListWidget extends StatelessWidget {
  const LegendsListWidget(
      {super.key,
      required this.legends,
      required this.axis,
      required this.spacing});
  final List<Legends> legends;
  final Axis axis;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: axis,
      spacing: spacing,
      children: legends
          .map(
            (e) => LegendWidget(
              name: e.name,
              color: e.color,
              widthCircle: e.widthCircle,
              heightCircle: e.heightCircle,
              fontSize: e.fontSize,
             fontWeight:e.fontWeight,
                textColor:e.textColor
            ),
          )
          .toList(),
    );
  }
}
//
// class LegendWidget extends StatelessWidget {
//   const LegendWidget({
//     super.key,
//     required this.name,
//     required this.color,
//   });
//   final String name;
//   final Color color;
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           width: 4.w,
//           height: 2.h,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: color,
//           ),
//         ),
//         const SizedBox(width: 6),
//         TextNormal2(name, fontSize: 10.sp)
//
//       ],
//     );
//   }
// }
//
// class LegendsListWidget extends StatelessWidget {
//   const LegendsListWidget({
//     super.key,
//     required this.legends,
//   });
//   final List<Legends> legends;
//
//   @override
//   Widget build(BuildContext context) {
//     return Wrap(
//       spacing: 16,
//       children: legends
//           .map(
//             (e) => LegendWidget(
//           name: e.name,
//           color: e.color,
//         ),
//       )
//           .toList(),
//     );
//   }
// }

class Legends {
  Legends(this.name, this.color, this.widthCircle, this.heightCircle,
      {this.widget, this.fontSize, this.fontWeight, this.textColor});
  final Widget? widget;
  final String name;
  final Color color;
  final double widthCircle;
  final double heightCircle;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? textColor;
}
