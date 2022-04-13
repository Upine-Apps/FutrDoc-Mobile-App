import 'package:flutter/material.dart';
import 'package:futr_doc/models/ICD.dart';
import 'package:futr_doc/models/Shadowing.dart';
import 'package:futr_doc/providers/ShadowingProvider.dart';
import 'package:provider/provider.dart';

import '../../custom-widgets/text-field/customTextFormField.dart';
import '../../service/shadowingService.dart';
import '../../theme/appColor.dart';

class ShadowingICD extends StatefulWidget {
  @override
  _ShadowingICDState createState() => _ShadowingICDState();
}

class _ShadowingICDState extends State<ShadowingICD> with AutomaticKeepAliveClientMixin{
  final TextEditingController _textController = TextEditingController();
  List<dynamic>? searchResults = [];
  List<dynamic>? selectedResults = [];

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance?.addPostFrameCallback((_) {
  //     selectedResults = context.read<ShadowingProvider>().lastShadowing.icd10;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10))),
      child: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
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
                  var response =
                      await ShadowingService.instance.getICD(val!, context);
                  setState(() {
                    searchResults = response['body'];
                    print(searchResults);
                  });
                },
                onEditingComplete: () {},
              ),
              if (searchResults != null && searchResults?.length != 0) ...[
                Container(
                  height: MediaQuery.of(context).size.height * .4,
                  padding: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.all(0),
                    itemCount: searchResults?.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        trailing: Text(searchResults![index]['icd'],
                            style: Theme.of(context).textTheme.headline6),
                        dense: true,
                        onTap: () {
                          Shadowing lastShadowing =
                              context.read<ShadowingProvider>().lastShadowing;
                          lastShadowing.icd10?.add(searchResults![index]);
                          print(lastShadowing.icd10);
                          context
                              .read<ShadowingProvider>()
                              .setLastShadowing(lastShadowing);
                          setState(() {
                            selectedResults?.add(searchResults![index]);
                            searchResults = [];
                          });
                        },
                        title: Text(
                          searchResults![index]['name']!,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        leading: Icon(Icons.search, color: AppColors.darkGrey),
                      );
                    },
                  ),
                )
              ],
              if (selectedResults != null && selectedResults?.length != 0) ...[
                SizedBox(
                  height: MediaQuery.of(context).size.height * .025,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.all(0),
                    itemCount: selectedResults?.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        trailing: Text(selectedResults![index]['icd'],
                            style: Theme.of(context).textTheme.headline6),
                        dense: true,
                        onTap: () {
                          Shadowing lastShadowing =
                              context.read<ShadowingProvider>().lastShadowing;
                          lastShadowing.icd10?.remove(selectedResults![index]);
                          context
                              .read<ShadowingProvider>()
                              .setLastShadowing(lastShadowing);
                          setState(() {
                            selectedResults?.remove(selectedResults![index]);

                            //TODO Remove value from provider
                          });
                        },
                        title: Text(
                          selectedResults![index]['name']!,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        leading: Icon(Icons.delete, color: AppColors.darkGrey),
                      );
                    },
                  ),
                )
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
