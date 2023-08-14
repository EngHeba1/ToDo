import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_task/firebase/firebase_function.dart';
import 'package:todo_task/home_layout/home_layout.dart';
import 'package:todo_task/provider/setting_provider.dart';
import 'package:todo_task/screens/creat_account.dart';

import '../styles/app_colors.dart';

class LogIn extends StatefulWidget {
  //const LogIn({super.key});
  static const routName="LogIn";

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  var emailController=TextEditingController();

  var passwordController=TextEditingController();

  bool obscureTextCheck = true;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<SettingProvid>(context);

    return Stack(children: [
      Image.asset("assets/images/login_screen.png",width: double.infinity,fit:BoxFit.fill),
      Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.all(8),
          child: Form(
            key: formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height*.2,),
              Text(pro.language=="en"?
                "HI":"أهلا",
              style: pro.language == "en"
                  ? GoogleFonts.novaSquare(
                color: Color.fromARGB(255, 137, 161, 238),
                fontSize: 45.sp,
              )
                  : GoogleFonts.cairo(
                color: Color.fromARGB(255, 137, 161, 238),
                fontSize: 50.sp,
              )),
                  Text(
                      pro.language == "en"
                          ? "Welcome Back"
                          : 'مرحبًا بعودتك',
                      style: pro.language == "en"
                          ? GoogleFonts.novaSquare(
                        color: Color.fromARGB(255, 137, 161, 238),
                        fontSize: 45.sp,
                      )
                          : GoogleFonts.cairo(
                        color: Color.fromARGB(255, 137, 161, 238),
                        fontSize: 50.sp,
                      )),
              SizedBox(
                height: 40.h,
              ),
              TextFormField(
                controller: emailController,
                validator: (email) {
                  if(email!.isEmpty) {
                    return pro.language == "en"
                        ? "Enter Email"
                        : "أدخل البريد الإلكتروني";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                enabledBorder:OutlineInputBorder(borderSide: BorderSide(color: AppCloros.lightColor)),
                  prefixIcon: Icon(
                    Icons.email,
                  ),
                    label: Text( pro.language == "en"
                        ? "Email"
                        : "البريد الإلكتروني",
                        style: pro.language == "en"
                            ? GoogleFonts.novaSquare(
                          color: AppCloros.lightColor,
                        )
                            : GoogleFonts.cairo(
                          color: AppCloros.lightColor,)),

              )
              ),
                  SizedBox(
                    height: 35.h,
                  ),
                  TextFormField(
                    controller: passwordController,
                    validator: (password) {
                      if (password!.isEmpty) {
                        return pro.language == "en"
                            ? "Enter Password"
                            : "أدخل كلمة المرور";
                      }
                      else if (password.length<6 ){
                        return pro.language == "en"
                            ? "At leats 6 character"
                            : "يجب ألا يقل عن 6 أحرف";
                      }
                      return null;
                    },
                    obscureText: obscureTextCheck,

                    decoration: InputDecoration(
                        label: Text(
                          pro.language == "en"
                              ? "Password"
                              : "كلمة المرور",
                          style: pro.language == "en"
                              ? GoogleFonts.novaSquare(
                            color: AppCloros.lightColor,
                          )
                              : GoogleFonts.cairo(
                            color: AppCloros.lightColor,
                          ),
                        ),
                        border: const OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: AppCloros.lightColor),
                        ),
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        suffix:
                        InkWell(
                            onTap: () {
                             setState(() {
                                obscureTextCheck = !obscureTextCheck;
                              });
                            },
                            child:
                               obscureTextCheck
                                ? const Icon(
                              Icons.visibility,
                              color: AppCloros.lightColor,
                            )
                                : const Icon(
                              Icons.visibility_off,
                              color: AppCloros.lightColor,
                            ))),
                 ),
                  SizedBox(
                    height: 35.h,
                  ),
                  ElevatedButton(
                    onPressed: (){
                      if( formKey.currentState!.validate()){
                FirebaseFunctions.logIn(

                 emailController.text,
                 passwordController.text,
                    (value){
                   showDialog(context: context,
                     barrierDismissible:false,
                       builder: (context) => AlertDialog(
                         title: Text("Error!"),
                         content: Text(value),

                         actions: [
                           ElevatedButton(onPressed: () => Navigator.pop(context),
                               child: Text("OK"))
                         ],

                       ),);
                    },

                      (){
                        pro.initUser();
                        Navigator.pushReplacementNamed(context, HomeLayout.routName);}

                );
                  }}, child: Text("Log In")),
                  Spacer(),
                  Row(children: [
                    pro.language=="en"?Text("Dont have an account?",
                    style: GoogleFonts.quicksand(color: Colors.black,fontSize: 15),)
                      :Text("لا تمتلك حساب؟",style: GoogleFonts.quicksand(color: Colors.black))
                  ,TextButton(onPressed: (){
                    Navigator.pushReplacementNamed(context, CreatAccount.routName);}, child:pro.language=="en"? Text("Creat an account",
                        ):
                    Text("أنشاء حساب",))],)
                  ,


                ]),
          ),
        ),

      )
    ],);
  }
}
