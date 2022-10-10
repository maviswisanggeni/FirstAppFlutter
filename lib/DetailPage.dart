import 'package:cobalatihan/PremiereLeagueModel.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:readmore/readmore.dart';

import 'favDB.dart';
import 'favModel.dart';

class DetailPage extends StatefulWidget {
  final Teams myTeams;
  const DetailPage({Key? key, required this.myTeams}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool checkExist = false;
  Color colorChecked = Colors.grey;

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {}
  }

  Future read() async {
    checkExist = await FavDatabase.instance.read(widget.myTeams.strTeam);
    setState(() {});
  }

  Future addData() async {
    var fav;
    fav = FavoriteModel(
        image: widget.myTeams.strTeamBadge.toString(),
        name: widget.myTeams.strTeam.toString(),
        julukan: widget.myTeams.strKeywords.toString(),
        since: widget.myTeams.intFormedYear.toString());
    await FavDatabase.instance.create(fav);
    setState(() {
      checkExist = true;
    });
    // Navigator.pop(context);
  }

  Future deleteData() async {
    await FavDatabase.instance.delete(widget.myTeams.strTeam);
    setState(() {
      checkExist = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    read();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Detail Team", style: TextStyle(color: Colors.black),),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
              children: [
                // Text(widget.myTeams.strTeam.toString()),
                // Container(
                //   child: InkWell(
                //       onTap: () {
                //         var myUrl = "https://"+ widget.myTeams.strYoutube.toString();
                //         _launchInBrowser(myUrl);
                //       },
                //   child: Icon(Icons.play_circle_fill_rounded),
                // ),
                // ),
                Container(
                  height: 200,
                  color: Colors.white,
                  padding: EdgeInsets.all(10),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        child: Image.network(
                          widget.myTeams.strTeamFanart1.toString(),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 200,
                        ),
                      ),
                      Positioned(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.myTeams.strTeam.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.myTeams.strLeague.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 30,
                        top: 15,
                        child: Container(
                          width: 30,
                          height: 30,
                          child: IconButton(
                              icon: Icon(Icons.favorite_rounded, size: 30),
                              color:
                              checkExist ? Colors.red : colorChecked,
                              onPressed: () {
                                checkExist ? deleteData() : addData();
                              }),
                        ),
                      ),
                    ],
                  )
                ),
                Row(
                  children: [
                    // social media
                    IconSocialMedia(widget.myTeams.strFacebook.toString(), "assets/facebook-icon.png", "Facebook"),
                    IconSocialMedia(widget.myTeams.strTwitter.toString(), "assets/twitter-icon.png", "Twitter"),
                    IconSocialMedia(widget.myTeams.strInstagram.toString(), "assets/instagram-icon.png", "Instagram"),
                    IconSocialMedia(widget.myTeams.strYoutube.toString(), "assets/youtube-icon.png", "Youtube"),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Text(
                          "Description",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ReadMoreText(
                        widget.myTeams.strDescriptionEN.toString(),
                        trimLines: 5,
                        textAlign: TextAlign.justify,
                        colorClickableText: Colors.blueAccent,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Show more',
                        trimExpandedText: 'Show less',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 20,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: 120,
                          height: 70,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                child: Image.network(
                                  widget.myTeams.strStadiumThumb.toString(),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 70,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              widget.myTeams.strStadium.toString(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              widget.myTeams.strStadiumLocation.toString(),
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }

  Widget IconSocialMedia(String url, String icon, String text) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                var myUrl = "https://"+ url;
                _launchInBrowser(myUrl);
              },
              child: Image.asset(icon, width:30,),
            ),
            Text(text, style: TextStyle(
              color: Colors.black,
              fontSize: 12,
            ),),
          ],
        ),
      ),
    );
  }
}
