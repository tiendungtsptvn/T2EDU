import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';
import 'package:t4edu_source_source/global/app_color.dart';
import 'package:t4edu_source_source/global/app_navigation.dart';
import 'package:t4edu_source_source/global/app_text.dart';
import 'package:t4edu_source_source/global/app_textStyle.dart';

class BuBuAlertDialog extends StatefulWidget {
  final String title;
  final String des;
  final String cancelText;
  final String acceptText;
  final Function accept;
  final bool isAccept;
  final bool isCancel;
  final Function actionCancel;
  final bool isClose;
  final TextAlign textAlign;

  BuBuAlertDialog(
      {this.title,
      this.des,
      this.accept,
      this.isAccept = true,
      this.acceptText,
      this.cancelText,
      this.isCancel = false,
      this.actionCancel,
      this.isClose = false,
      this.textAlign,
      Key key})
      : super(key: key);

  @override
  _BuBuAlertDialogState createState() => _BuBuAlertDialogState();
}

class _BuBuAlertDialogState extends State<BuBuAlertDialog> {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.only(top: 12),
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 12),
          Visibility(
            visible: widget.isClose,
            child: Padding(
              padding: const EdgeInsets.only(right:10.0),
              child: Align (
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: (){
                      GetIt.I<Navigation>().pop();
                    },
                    child: Icon(Icons.close),
                  )
              ),
            ),
          ),
          Center(
            child: Text(
              widget.title.toUpperCase(),
              textAlign: TextAlign.center,
              style:
              AppTextStyles.normal(color: AppColors.red,fontWeight: FontWeight.w600,fontSize: 16),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 10,
              bottom: 22
            ),
            child: Text(
              widget.des,
              style: AppTextStyles.normal(
                  color: AppColors.black,fontSize: 14,fontWeight: FontWeight.w600,),
              textAlign: widget.textAlign ?? TextAlign.center,
            ),
          ),
          Container(
            height: 1,
            color: AppColors.black.withOpacity(0.1),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 41,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15)
                    ),
                  ),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: widget.accept,
                    child: Center(child: AppTexts.normal(widget.acceptText,fontSize: 16,fontWeight: FontWeight.w600,color: AppColors.blue)),
                  ),
                ),
              ),
              Container(
                height: 41,
                width: 1,
                color: AppColors.black.withOpacity(0.1),
              ),
              Expanded(
                child: Container(
                  height: 41,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15)
                    ),
                  ),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: widget.actionCancel,
                    child: Center(child: AppTexts.normal(widget.cancelText,fontSize: 16,fontWeight: FontWeight.w600,color: AppColors.red)),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

