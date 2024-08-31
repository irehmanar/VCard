import 'dart:convert';
import 'package:flutter/material.dart';
import 'AppFontSize.dart';
import 'GlobalAppColor.dart';
import 'TextFieldWidget.dart';
import 'VCard.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  bool isPhone = false;
  bool isName = false;


  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.backGroundColour,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColours.backGroundColour,
        title: const Padding(
          padding: EdgeInsets.only(top: 16.0),
          child: Text(
            "VCard Generator",
            style: TextStyle(
              color: AppColours.textColor,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [

                // SizedBox(height: MediaQuery.sizeOf(context).height * 0.051),
                const SizedBox(height: 16),
                const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "User Name",
                    style: TextStyle(
                      color: AppColours.textColor,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                MainTextFieldWidget(
                  textInputAction: TextInputAction.done,
                  controller: fullNameController,
                  keyboardType: TextInputType.text,
                  isReadOnly: false,
                  showAsterisk: isName,
                  placeHolder: 'Add Name',
                ),


                const SizedBox(height: 16),
                const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Organization Name",
                    style: TextStyle(
                      color: AppColours.textColor,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                MainTextFieldWidget(
                  textInputAction: TextInputAction.done,
                  controller: businessNameController,
                  keyboardType: TextInputType.text,
                  isReadOnly: false,
                  showAsterisk: false,
                  placeHolder: 'Add Organization Name',
                ),


                const SizedBox(height: 16),
                const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "User Email",
                    style: TextStyle(
                      color: AppColours.textColor,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                MainTextFieldWidget(
                  textInputAction: TextInputAction.done,
                  controller: emailController,
                  keyboardType: TextInputType.text,
                  isReadOnly: false,
                  showAsterisk: false,
                  placeHolder: 'Add email',
                ),

                const SizedBox(height: 16),
                const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "User Phone Number",
                    style: TextStyle(
                      color: AppColours.textColor,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                MainTextFieldWidget(
                  textInputAction: TextInputAction.done,
                  controller: phoneController,
                  keyboardType: TextInputType.text,
                  isReadOnly: false,
                  showAsterisk: isPhone,
                  placeHolder: 'Add Phone',
                ),



                const SizedBox(height: 16),
                const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Business Address",
                    style: TextStyle(
                      color: AppColours.textColor,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                MainTextFieldWidget(
                  textInputAction: TextInputAction.done,
                  controller: addressController,
                  keyboardType: TextInputType.text,
                  isReadOnly: false,
                  showAsterisk: false,
                  placeHolder: 'Add Address',
                ),



                const SizedBox(height: 16),
                const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Website",
                    style: TextStyle(
                      color: AppColours.textColor,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                MainTextFieldWidget(
                  textInputAction: TextInputAction.done,
                  controller: websiteController,
                  keyboardType: TextInputType.text,
                  isReadOnly: false,
                  showAsterisk: false,
                  placeHolder: 'Add website',
                ),







                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if(fullNameController.text.isEmpty || phoneController
                          .text.isEmpty){
                        if(fullNameController.text.isEmpty) {
                          setState(() {
                            isName = true;
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('User name is required'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                        if(phoneController.text.isEmpty){
                         setState(() {
                           isPhone = true;
                           ScaffoldMessenger.of(context).showSnackBar(
                             const SnackBar(
                               content: Text('Phone number is required'),
                               backgroundColor: Colors.red,
                             ),
                           );
                         });


                        }

                      }
                      else{
                        String vCardContent = await VCardGenerator.generateVCard(
                          name: fullNameController.text,
                          organization: businessNameController.text,
                          workPhone:  phoneController.text,
                          // imageFile: imageFile,  // Pass the selected image file here
                          email: emailController.text,
                          address: addressController.text,
                          website: websiteController.text,  // Pass the website here
                        );
                        await VCardGenerator.shareVCard(vCardContent:
                        vCardContent, context: context,name: fullNameController.text);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                      backgroundColor: AppColours.buttonColors,
                      foregroundColor: Colors.white,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Share your VCard',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}