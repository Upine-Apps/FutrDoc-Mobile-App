import 'package:flutter/material.dart';

import '../../custom-widgets/text-field/customTextFormField.dart';
import '../../service/shadowingService.dart';
import '../../theme/appColor.dart';

class ShadowingICD extends StatefulWidget {
  @override
  _ShadowingICDState createState() => _ShadowingICDState();
}

class _ShadowingICDState extends State<ShadowingICD> {
  final TextEditingController _textController = TextEditingController();
  var searchResults = [];
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * .05),
            Text(
              'What experience did you gain?',
              style: Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .05),
            CustomTextFormField(
              prefixIcon: Icon(Icons.search, color: AppColors.lighterBlue),
              labelText: 'Search',
              controller: _textController,
              onChanged: (val) async {
                var response = await ShadowingService.getICD(val!, context);
              },
              onEditingComplete: () {},
            ),
            if (searchResults != null && searchResults.length != 0) ...[
              Container(
                decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10))),
                child: ListView.builder(
                  padding: EdgeInsets.all(0),
                  itemCount: searchResults.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      dense: true,
                      title: Text(
                        searchResults[index],
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      leading: Icon(Icons.search, color: AppColors.darkGrey),
                    );
                  },
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
