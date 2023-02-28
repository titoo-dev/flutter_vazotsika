import 'package:flutter/material.dart';
import 'package:flutter_vazotsika/app/modules/home/models/search_result_model.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class PlayerController extends GetxController {
  final AudioPlayer _audioPlayer = AudioPlayer();

  void playTrackPreview(TrackItem? track) async {
    UriAudioSource audioSource = AudioSource.uri(Uri.parse(track?.previewUrl ?? ''));
    try {
      await _audioPlayer.setAudioSource(audioSource);
      await _audioPlayer.play();
    } catch (e) {
      debugPrint('Error loading audio source $e');
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}