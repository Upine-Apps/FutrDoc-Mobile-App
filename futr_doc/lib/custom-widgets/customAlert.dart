import 'package:flutter/material.dart';
import 'package:futr_doc/theme/appColor.dart';

class CustomAlertDialog extends StatefulWidget {
  const CustomAlertDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.onContinue,
    this.confirmText,
  }) : super(key: key);

  final VoidCallback onContinue;
  final String title, description;
  final String? confirmText;

  @override
  _CustomAlertDialogState createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .4,
      child: Dialog(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 15),
            Text(
              "${widget.title}",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(height: 15),
            Text(
              "${widget.description}",
              style: Theme.of(context).textTheme.bodyText2,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 25),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 75,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: Theme.of(context).dividerColor,
                      width: 1,
                      style: BorderStyle.solid),
                  bottom: BorderSide(
                      color: Theme.of(context).dividerColor,
                      width: 1,
                      style: BorderStyle.solid),
                ),
              ),
              child: InkWell(
                customBorder: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.yellow, width: 2)),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                ),
                highlightColor: Colors.grey[200],
                onTap: widget.onContinue,
                child: Center(
                  child: Text(
                    widget.confirmText ?? "Continue",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 75,
              // decoration: BoxDecoration(
              //   border: Border(
              //     top: BorderSide(
              //         color: AppColors.darkGrey,
              //         width: 1,
              //         style: BorderStyle.solid),
              //   ),
              // ),
              child: InkWell(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                ),
                highlightColor: Colors.grey[200],
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Center(
                  child: Text(
                    "Cancel",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
