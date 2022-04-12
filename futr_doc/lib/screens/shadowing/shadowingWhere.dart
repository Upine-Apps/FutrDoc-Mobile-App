import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../custom-widgets/text-field/customTextFormField.dart';
import '../../models/Shadowing.dart';
import '../../providers/ShadowingProvider.dart';
import '../../theme/appColor.dart';

class ShadowingWhere extends StatefulWidget {
  @override
  _ShadowingWhereState createState() => _ShadowingWhereState();
}

class _ShadowingWhereState extends State<ShadowingWhere> {
  final TextEditingController _textController = TextEditingController();
  var searchResults = [
    'Hope Famly Health Center',
    'Memorial Herrmann',
    'St. Joseph Health Regional'
  ];
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * .05),
            Text(
              'What clinic did you shadow at?',
              style: Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .05),
            CustomTextFormField(
              prefixIcon: Icon(Icons.search, color: AppColors.lighterBlue),
              labelText: 'Search by location',
              controller: _textController,
              onChanged: (val) async {/*shows google maps*/},
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
                        onTap: () async {
                          Shadowing lastShadowing =
                              context.read<ShadowingProvider>().lastShadowing;
                          // lastShadowing.clinic_name = widget.title;
                          // context.read<ShadowingProvider>().lastShadowing != Shadowing.emptyShadowingObject ? : ;
                          // context.read<ShadowingProvider>().setLastShadowing(updatedShadowing)
                        },
                        dense: true,
                        title: Text(
                          searchResults[index],
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        leading: Icon(Icons.search, color: AppColors.darkGrey),
                      );
                    },
                  ))
            ]
          ],
        )));
  }
}
