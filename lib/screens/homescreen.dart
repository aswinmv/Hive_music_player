import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/const/colors.dart';
import 'package:music_player/const/textstyle.dart';
import 'package:music_player/controllers/playercontroller.dart';
import 'package:music_player/screens/player.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

var controller = Get.put(PlayerController());

    return Scaffold(
      backgroundColor: byDarkcolor,
      appBar: AppBar(
        actions: [IconButton(onPressed: () {
          
        }, icon: const Icon(Icons.search_rounded,color: whiteColor,))],
        leading: const Icon(Icons.sort_rounded ,color: whiteColor,),
        backgroundColor: byDarkcolor,
      title:  Text("Hive",style: ourStyle(color: whiteColor,family: GoogleFonts.poppins,size: 18)),
      ),
      body: FutureBuilder<List<SongModel>>(future:controller.audioQuery.querySongs(
        ignoreCase: true,
orderType: OrderType.ASC_OR_SMALLER,
sortType: null,
uriType: UriType.EXTERNAL,
      ),
      
       builder: (context, snapshot) {
        if(snapshot.data == null){return const Center(child: CircularProgressIndicator(),);}
        else if(snapshot.data!.isEmpty){
          return Text("No Music Found",style: ourStyle(size: 25),);
        }
        else {
          // print(snapshot.data);
          return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
          return Container(
            
            margin: const EdgeInsets.only(bottom: 6),
            
            child:  Obx(
              () =>
               ListTile(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                tileColor: bagColor,
                title: Text(snapshot.data![index].displayName,
                overflow: TextOverflow.clip,
                 maxLines: 1,
                style: ourStyle(size: 14),),
            
                subtitle: Text(snapshot.data![index].artist.toString(),
                overflow: TextOverflow.ellipsis,
                 maxLines: 1,
                style: ourStyle(size: 12),),
            
                leading: QueryArtworkWidget(id: snapshot.data![index].id, type: ArtworkType.AUDIO,
                nullArtworkWidget: const Icon(Icons.music_note,color: whiteColor,size: 32,),),
                
            
                trailing: controller.playIndex.value ==index && controller.isPlaying.value
                ? const Icon(Icons.play_arrow,color: whiteColor,size: 26,)
                : null,
                onTap: () {
                   Get.to(()=>  Player(data: snapshot.data!,),
              transition: Transition.downToUp
);

                  controller.playSong(snapshot.data![index].uri!,index);
                },
              ),
            ));
        },),
      );}
        
      },)
    );
  }
}



