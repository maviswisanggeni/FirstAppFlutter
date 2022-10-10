import 'package:cobalatihan/DetailPage.dart';
import 'package:cobalatihan/PremiereLeagueModel.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class ListFootballPL extends StatefulWidget {
  const ListFootballPL({Key? key}) : super(key: key);

  @override
  State<ListFootballPL> createState() => _ListFootballPLState();
}

class _ListFootballPLState extends State<ListFootballPL> {

  PremiereLeagueModel? premiereLeagueModel;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllListPL();
  }

  void getAllListPL() async {
    setState(() {
      isLoading = false;
    });

    final res = await http.get(
      Uri.parse("https://www.thesportsdb.com/api/v1/json/2/search_all_teams.php?l=English%20Premier%20League"),
    );
    print("status code: " + res.statusCode.toString());
    premiereLeagueModel =
        PremiereLeagueModel.fromJson(json.decode(res.body.toString()));
    print("team 0: " + premiereLeagueModel!.teams![5].strTeam.toString());

    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 15),
          child: isLoading ?ListView.builder(
            itemCount: premiereLeagueModel!.teams!.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(
                        myTeams: premiereLeagueModel!.teams![index],
                      ),
                    ),
                  );
                },
                // child: Container(
                //   margin: EdgeInsets.all(20),
                //   height: 150,
                //   child: Stack(
                //     children: [
                //       Positioned.fill(
                //         child: ClipRRect(
                //           borderRadius: BorderRadius.circular(20),
                //           child: Image.network(
                //             premiereLeagueModel!.teams![index].strTeamBanner.toString(),
                //             fit: BoxFit.cover,
                //           ),
                //         ),
                //       ),
                //       Positioned(
                //         bottom: 0,
                //         left: 0,
                //         right: 0,
                //         child: Container(
                //           height: 120,
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.only(
                //               bottomLeft: Radius.circular(20),
                //               bottomRight: Radius.circular(20),
                //             ),
                //             gradient: LinearGradient(
                //               begin: Alignment.bottomCenter,
                //               end: Alignment.topCenter,
                //               colors: [
                //                 Colors.black.withOpacity(0.7),
                //                 Colors.transparent,
                //               ],
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                child: Container(
                  height: 100,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [
                        Colors.blueAccent.withAlpha(15),
                        Colors.blueAccent.withAlpha(15),
                      ],
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        margin: EdgeInsets.only(right: 10, left: 20),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              premiereLeagueModel!.teams![index].strTeamBadge.toString(),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              premiereLeagueModel!.teams![index].strTeam.toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              premiereLeagueModel!.teams![index].strLeague.toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Container(
                      //   width: 50,
                      //   height: 50,
                      //   margin: EdgeInsets.only(right: 10, left: 20),
                      //   child: Icon(
                      //     Icons.arrow_forward_ios,
                      //     size: 15,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              );
            },
          ) : CircularProgressIndicator(),
        ),
      ),
    );
  }
}
