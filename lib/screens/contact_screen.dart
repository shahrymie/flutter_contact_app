import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contact_app/viewmodels/contact_view_model.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen>
    with SingleTickerProviderStateMixin {
  bool notification = false;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ContactViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text("Flutter Contact App"),
          LiteRollingSwitch(
            value: notification,
            colorOn: Colors.greenAccent[700],
            colorOff: Colors.redAccent[700],
            iconOn: Icons.notifications,
            iconOff: Icons.notifications_off,
            textSize: 16.0,
            onChanged: (bool state) {
              notification = state;
            },
          ),
        ]),
      ),
      body: Builder(
        builder: (context) => SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              viewModel.addLength().then((value) {
                if (value) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('Reached the last Contact'),
                      duration: Duration(milliseconds: 200)));
                }
              });
            },
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: viewModel.getLength(),
                itemBuilder: (_, index) {
                  return Container(
                    child: ListTile(
                      leading: GestureDetector(
                        onTap: () {
                          Share.share(
                              'Contact info: ${viewModel.getUser(index)}\nPhone Num: ${viewModel.getPhone(index)}\nLast Check-in: ${viewModel.getDateTime(index)}');
                        },
                        child: Icon(Icons.share),
                      ),
                      title: Text(viewModel.getUser(index)),
                      subtitle: Text(viewModel.getPhone(index)),
                      trailing: Text(viewModel.getCheckIn(index)),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
