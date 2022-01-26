import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/constant/constants.dart';
import 'package:player/constant/time_ago.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/notification_data.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Notifications>? notifications = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 1, child: allNotifications()),
          ],
        ),
      ),
    );
  }

  Future<List<Notifications>?> getNotifications() async {
    APICall apiCall = new APICall();
    List<Notifications> data = [];
    bool connectivityStatus = await Utility.checkConnectivity();
    if (connectivityStatus) {
      NotificationData notificationData = await apiCall.getNotifications();

      if (notificationData.notifications != null) {
        data.addAll(notificationData.notifications!);
        notifications = data;
        notifications = notifications!.reversed.toList();
      }
    } else {}
    return notifications;
  }

  Future<void> _refreshTournaments(BuildContext context) async {
    getNotifications();
  }

  Widget allNotifications() {
    return Container(
      height: 700,
      padding: EdgeInsets.all(10.0),
      child: RefreshIndicator(
        onRefresh: () => _refreshTournaments(context),
        color: kBaseColor,
        child: FutureBuilder(
          future: getNotifications(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: Container(
                    child: CircularProgressIndicator(color: kBaseColor)),
              );
            }
            if (snapshot.hasData) {
              print("Has Data ${snapshot.data.length}");
              if (snapshot.data.length == 0) {
                return Container(
                  child: Center(
                    child: Text('No Data'),
                  ),
                );
              } else {
                return ListView.builder(
                  padding: EdgeInsets.only(bottom: 20),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return notificationItem(snapshot.data[index]);
                  },
                );
              }
            } else {
              return Container(
                child: Center(
                  child: Text('No Data'),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget notificationItem(dynamic notification) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        decoration: kServiceBoxItem,
        child: Stack(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          notification.title,
                          style: TextStyle(
                            color: kBaseColor,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      notification.body,
                      style: TextStyle(
                        color: Colors.grey.shade900,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      TimeAgo.timeAgoSinceDate(
                          notification.createdAt.toString()),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
