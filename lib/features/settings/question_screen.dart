import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medications/generated/l10n.dart';
import 'package:medications/shared/base_screen.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  late TextEditingController topicClr;
  late TextEditingController emailClr;
  late TextEditingController messageClr;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    topicClr = TextEditingController();
    emailClr = TextEditingController();
    messageClr = TextEditingController();
  }

  @override
  void dispose() {
    topicClr.dispose();
    emailClr.dispose();
    messageClr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    return BaseScreen(
      navigationBar: CupertinoNavigationBar(
        middle: Text(S.of(context).askAQuestion),
        border: null,
        trailing: !loading
            ? CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: topicClr.text.isNotEmpty &&
                        emailClr.text.isNotEmpty &&
                        messageClr.text.isNotEmpty
                    ? () async {
                        setState(() {
                          loading = true;
                        });
                        String message;
                        try {
                          final collection =
                              FirebaseFirestore.instance.collection('feedback');
                          await collection.doc().set({
                            'topic': topicClr.text,
                            'email': emailClr.text,
                            'message': messageClr.text,
                            'timestamp': DateTime.now(),
                          });
                          message =
                              S.of(context).yourQuestionHasBeenSuccessfullySent;
                        } catch (e) {
                          message = S
                              .of(context)
                              .somethingWentWrongWhileSendingTheQuestion;
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Center(child: Text(message)),
                          ),
                        );
                        Navigator.of(context).pop();
                      }
                    : null,
                child: Text(S.of(context).send),
              )
            : const CupertinoActivityIndicator(),
      ),
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                SizedBox(height: 24.h),
                CupertinoTextField(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: theme.primaryContrastingColor,
                  ),
                  placeholder: S.of(context).topicOfTheQuestion,
                  controller: topicClr,
                  onChanged: (value) => setState(() {}),
                ),
                SizedBox(height: 32.h),
                CupertinoTextField(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: theme.primaryContrastingColor,
                  ),
                  placeholder: S.of(context).email,
                  controller: emailClr,
                  onChanged: (value) => setState(() {}),
                ),
                SizedBox(height: 32.h),
                CupertinoTextField(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: theme.primaryContrastingColor,
                  ),
                  placeholder: S.of(context).yourMessage,
                  maxLines: 8,
                  controller: messageClr,
                  onChanged: (value) => setState(() {}),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
