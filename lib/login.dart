import 'package:flutter/material.dart';
import 'package:mockup/theme.dart';
import 'package:sizer/sizer.dart';
import '../textbox.dart';
import 'base_model.dart';
import 'function.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isChecked = false;
  late String _language;
  late bool _obscureText = true;
  final _controllerFaculty = TextEditingController();
  final _controllerDepartment = TextEditingController();
  final _controllerUsername = TextEditingController();
  final _controllerPassword = TextEditingController();

  late String _placeholder_FacultyCode;
  late String _checkbox_rememberMe;
  late String _label_title;
  late String _button_forgotPassword;
  late String _placeholder_DepartmentCode;
  late String _placeholder_User;
  late String _label_welcome;
  late String _placeholder_password;

  late List<Languages> lstLanguage = [];

  @override
  void initState() {
    super.initState();
    _language = 'English';
    _placeholder_FacultyCode = "Faculty Code";
    _checkbox_rememberMe = "";
    _label_title = "Login To Your Account";
    _button_forgotPassword = "";
    _placeholder_DepartmentCode = "Department Code";
    _placeholder_User = "Username or E-mail";
    _label_welcome = "Welcome to BUUFSCI";
    _placeholder_password = "Password";

    print('check LoginLoadScreen');
  }

  Color getColorButtonSubmit(){
    return _controllerFaculty.text.trim() != '' &&_controllerDepartment.text.trim() != '' &&
        _controllerUsername.text.trim() != '' &&
        _controllerPassword.text.trim() != ''
        ? MyColors.eZMockUpMyrtleYellow : Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => Scaffold(
          body: Container(
        color: const Color.fromARGB(255, 214, 224, 225),
        child: Stack(children: [
          SizedBox(
            height: 100.h,
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(color: MyColors.eZMockUpMyrtleYellow ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(color: MyColors.eZMockUpBlanchedAlmond ),
                ),
                // Container(
                //   height: (MediaQuery.of(context).size.height / 2),
                //     color: const Color.fromARGB(255, 44, 120, 115)),
                // Container(
                //     height: (MediaQuery.of(context).size.height / 2),
                //     color: const Color.fromARGB(255, 214, 224, 225)),
              ],
            ),
          ),
          SafeArea(
            child: SizedBox(
              height: 100.h,
              width: 100.w,
              child: SingleChildScrollView(
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.only(right: 5.w,left: 5.w, top: 2.5.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.topRight,
                          child: ButtonCustom2( MyColors.eZMockUpButtonColor, Colors.white, _language,
                              borderRadius: 10.w,
                              height: 5.h,
                              width: 30.w,
                              padding: EdgeInsets.only(left: 8, right: 5),
                              iconTextFirst: Icon(
                                Icons.language_rounded,
                                size: 5.w,
                              ),
                              iconTextLast: Icon(
                                Icons.arrow_drop_down_rounded,
                                size: 6.w,
                              ), function: () {
                            ShowBottomSheet2<Languages>(
                                context: context,
                                lstItem: lstLanguage,
                                onPressedItem: (Languages value) {
                                  setState(() {
                                    _language = value.name;
                                  });
                                  print(value.code);
                                },
                                itemBuilder: (Languages item) {
                                  return TextNormal(item.name, fontSize: MyFontSize.fontSizeShowBottomSheet, fontWeight: FontWeight.w500);
                                });
                          }),
                        ),

                        InkWell(
                          onTap: (){},
                          child: Container(
                            alignment: Alignment.topRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image.asset(
                                  // height: 90,
                                  // width: 90,
                                  height: 5.h,
                                  // "assets/image/EZ@U.png",
                                  "assets/image/EZ_AT_U_Logo.png",
                                  fit: BoxFit.fill,
                                ),
                                Image.asset(
                                  // height: 90,
                                  // width: 90,
                                  height: 5.h,
                                  "assets/image/icon_question_fill.png",
                                  fit: BoxFit.fill,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0.h),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.w),
                        child: Image.asset(
                          // height: 90,
                          // width: 90,
                          height: 15.h,
                          "assets/image/Logo_App.png",
                          fit: BoxFit.fill,
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 1.h, top: 2.h),
                    child: TextNormal2(_label_title, fontWeight: FontWeight.w600, fontSize: 16.sp, textColor: Colors.white),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 2.h), child: TextNormal2('$_label_welcome  1.0.0', textColor: Colors.white)),
                  Center(
                      child: Container(
                    //margin: EdgeInsets.only(top : 100),
                    padding: EdgeInsets.only(left: 6.w, right: 6.w),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 65.5.h,
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    height: 50.h,
                                    padding: EdgeInsets.only(
                                      top: 3.h,
                                      left: 6.w,
                                      right: 6.w,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24.sp),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          height: 7.5.h,
                                          margin: EdgeInsets.only(top: 1.h),
                                          padding: EdgeInsets.only(top: 1.h),
                                          child: TextBox(_controllerFaculty, fontSize: MyFontSize.sizeNormal, onChanged: (val) {
                                            setState(() {
                                              getColorButtonSubmit();
                                            });
                                          },
                                              hintText: _placeholder_FacultyCode,
                                              prefixIcon: Container(
                                                padding: EdgeInsets.only(top: 1.5.h, bottom: 1.5.h, right: 4.w, left: 4.w),
                                                child: Image.asset(
                                                  "assets/image/icon_home_fill.png",
                                                  height: 3.h,
                                                ),
                                              ) //Icon(Icons.cases_outlined),
                                              ),
                                        ),
                                        Container(
                                          height: 7.5.h,
                                          padding: EdgeInsets.only(top: 1.h),
                                          child: TextBox(_controllerFaculty, onChanged: (val) {
                                            setState(() {
                                              getColorButtonSubmit();
                                            });
                                          },
                                              hintText: _placeholder_DepartmentCode,
                                              prefixIcon: Container(
                                                padding: EdgeInsets.only(top: 1.5.h, bottom: 1.5.h, right: 4.w, left: 4.w),
                                                child: Image.asset("assets/image/icon_book_check_duotone.png", height: 3.h),
                                              ) //Icon(Icons.person_outline_rounded,),
                                          ),
                                        ),
                                        Container(
                                          height: 7.5.h,
                                          padding: EdgeInsets.only(top: 1.h),
                                          child: TextBox(_controllerUsername, onChanged: (val) {
                                            setState(() {
                                              getColorButtonSubmit();
                                            });
                                          },
                                              hintText: _placeholder_User,
                                              prefixIcon: Container(
                                                padding: EdgeInsets.only(top: 1.5.h, bottom: 1.5.h, right: 4.w, left: 4.w),
                                                child: Image.asset("assets/image/icon_user_duotone.png", height: 3.h),
                                              ) //Icon(Icons.person_outline_rounded,),
                                              ),
                                        ),
                                        Container(
                                          height: 7.5.h,
                                          padding: EdgeInsets.only(top: 1.h),
                                          child: TextBox(
                                            _controllerPassword,
                                            onChanged: (val) {
                                              setState(() {
                                                getColorButtonSubmit();
                                              });
                                            },
                                            hintText: _placeholder_password,
                                            obscureText: _obscureText,
                                            prefixIcon: Container(
                                              padding: EdgeInsets.only(top: 1.5.h, bottom: 1.5.h, right: 4.w, left: 4.w),
                                              child: Image.asset("assets/image/icon_unlock_duotone.png", height: 3.h),
                                            ), //Icon(Icons.lock_outline_rounded,),
                                            suffixIcon: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    _obscureText = !_obscureText;
                                                  });
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.only(top: 1.5.h, bottom: 1.5.h, right: 4.w, left: 4.w),
                                                  child: Icon(
                                                    _obscureText ? Icons.remove_red_eye_outlined : Icons.remove_red_eye_rounded,
                                                    size: 3.h,
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Expanded(child: SizedBox()),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
                ]),
              ),
            ),
          ),
        ]),
      )),
    );
  }
}
