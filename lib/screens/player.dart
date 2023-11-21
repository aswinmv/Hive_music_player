import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/const/colors.dart';
import 'package:music_player/const/textstyle.dart';
import 'package:music_player/controllers/playercontroller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Player extends StatelessWidget {
  final List<SongModel> data;
  const Player({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
var controller = Get.find<PlayerController>();

    return Scaffold(
      backgroundColor: bagColor,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Obx(() => 
             Expanded(child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              height: 300,
              width: 320,
              decoration: BoxDecoration(
                 color: Colors.transparent, 
                borderRadius: BorderRadius.circular(25)),
              alignment: Alignment.center,
             
              child: QueryArtworkWidget(id: data[controller.playIndex.value].id, type: ArtworkType.AUDIO,
              artworkHeight: double.infinity,
              artworkWidth: double.infinity,
              artworkFit: BoxFit.cover,
              nullArtworkWidget: const Icon(Icons.music_note),
              ))),
          ),
            const SizedBox(height: 15,),
           Expanded(child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration( color: whiteColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16))
            ),
            child: Obx(() => 
               Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(data[controller.playIndex.value].displayName ,overflow: TextOverflow.clip,
                    textAlign: TextAlign.center,
                     maxLines: 2,style: ourStyle(size: 24,color: byDarkcolor),),
                  ),
                  const SizedBox(height: 10,),
                  Text(data[controller.playIndex.value].artist.toString(),overflow: TextOverflow.ellipsis,
                   maxLines: 1,
                   textAlign: TextAlign.center,
                  style: ourStyle(color: byDarkcolor,size: 20),),
                  const SizedBox(height: 12,),
                  Obx(() => 
                   Row(children: [
                      Text(controller.position.value,style: ourStyle(color: byDarkcolor,size: 15),),
                      Expanded(
                        child: Slider(
                          activeColor: slideColor,
                          inactiveColor: bagColor,
                          thumbColor: slideColor,
                          min:const  Duration(seconds: 0).inSeconds.toDouble(),
                          max: controller.max.value,
                          value: controller.value.value,
                         onChanged: (newValue) {
                          controller.changeDurationtoSeconds(newValue.toInt());
                          newValue = newValue; 
                        },),
                      ),
                      Text(controller.duration.value,style: ourStyle(color: byDarkcolor,size: 15),)
                    ],),
                  ),
                 const  SizedBox(height: 12,),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                     IconButton(onPressed: () {
                      controller.playSong(data[controller.playIndex.value+5].uri, controller.playIndex.value+5);
                 }, icon: const Icon(Icons.shuffle_rounded,size: 18,)
                 ),
                //  previous button ////////////////////////////////////////////////////////////////
                  IconButton(onPressed: () {
                    controller.playSong(data[controller.playIndex.value-1].uri, controller.playIndex.value-1);
                 }, icon: const Icon(Icons.skip_previous_rounded,size: 32,)
                 ),
                  Obx(() => 
                     CircleAvatar(
                      radius: 35,
                      backgroundColor: byDarkcolor,
                      child: Transform.scale(
                        scale: 1.5,
                        child: IconButton(onPressed: () {
                          if(controller.isPlaying.value){
                            controller.audioPlayer.pause();
                            controller.isPlaying(false);
                          }else {
                             controller.audioPlayer.play();
                            controller.isPlaying(true);
                          }
                                     }, 
                                     icon: controller.isPlaying.value 
                                     ? const Icon(Icons.pause,size: 34,)
                                     :const Icon(Icons.play_arrow_rounded,size: 34,)
                                     ),
                      ),
                    ),
                  ),
                  // next button///////////////////////////////////////////////////////////////////
                  IconButton(onPressed: () {
                     controller.playSong(data[controller.playIndex.value+1].uri, controller.playIndex.value+1);
                 }, icon: const Icon(Icons.skip_next_rounded,size: 32,)
                 ),
                  IconButton(onPressed: () {
                    controller.playSong(data[controller.playIndex.value+1-1].uri, controller.playIndex.value+1-1);
                 }, icon: const Icon(Icons.repeat,size: 18,)
                 )
                 ],)
                ],
              ),
            ),
           ))
        ]),
      ),
    );
  }
}