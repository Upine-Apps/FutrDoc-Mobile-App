import 'package:flutter/material.dart';
import 'package:futr_doc/service/places.dart';
import 'package:provider/provider.dart';

import '../../custom-widgets/text-field/customTextFormField.dart';
import '../../models/PlaceSearch.dart';
import '../../models/Shadowing.dart';
import '../../providers/ShadowingProvider.dart';
import '../../theme/appColor.dart';

class ShadowingWhere extends StatefulWidget {
  @override
  _ShadowingWhereState createState() => _ShadowingWhereState();
}

class _ShadowingWhereState extends State<ShadowingWhere>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController _textController = TextEditingController();
  List<PlaceSearch> searchResults = [];
  PlaceSearch? selectedResult;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final node = FocusScope.of(context);
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
              onChanged: (val) async {
                var response = await PlacesService().getAutocomplete(val!);
                setState(() {
                  searchResults = response;
                });
              },
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
            ),
            if (searchResults != null && searchResults.length != 0) ...[
              Container(
                  height: MediaQuery.of(context).size.height * .4,
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
                          lastShadowing.clinic_name =
                              searchResults[index].description!;
                          context
                              .read<ShadowingProvider>()
                              .setLastShadowing(lastShadowing);
                          setState(() {
                            _textController.text =
                                searchResults[index].description!;
                            selectedResult = searchResults[index];
                            searchResults = [];
                          });
                        },
                        dense: true,
                        title: Text(
                          searchResults[index].description!,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        leading: Icon(Icons.search, color: AppColors.darkGrey),
                      );
                    },
                  ))
            ],
            if (selectedResult != null) ...[
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
                  itemCount: 1,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      dense: true,
                      onTap: () async {
                        setState(() {
                          selectedResult = null;
                        });
                        Shadowing lastShadowing =
                            context.read<ShadowingProvider>().lastShadowing;
                        lastShadowing.clinic_name = '';
                        context
                            .read<ShadowingProvider>()
                            .setLastShadowing(lastShadowing);
                      },
                      title: Text(
                        selectedResult!.description!,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      leading: Icon(Icons.delete, color: AppColors.darkGrey),
                    );
                  },
                ),
              )
            ]
          ],
        )));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
