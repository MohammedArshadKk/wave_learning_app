import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wave_learning_app/model/channel_model.dart';

class ChannelIconAdd {
  final ImagePicker pickChannelIcon = ImagePicker();
  final FirebaseStorage storage = FirebaseStorage.instance;
 final FirebaseFirestore db=FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<XFile?> pickIcon() async {
    final pickIcon =
        await pickChannelIcon.pickImage(source: ImageSource.gallery);

    return pickIcon;
  }

  Future<String?> uploadIconTostorage(
      File? icon, ChannelModel channelModel) async {
    String filename = DateTime.now().toString();
   final ref= storage
        .ref('channels/${channelModel.channelName}$filename');
      await ref.putFile(icon!);
      final  iconUrl=await ref.getDownloadURL();
    return iconUrl;
  }

  addChannelInformationToDatabase(iconUrl, ChannelModel channelModel) async {
    try {
       final channel = ChannelModel(
      channelName: channelModel.channelName,
      email: channelModel.email,
      uid: channelModel.uid,
      description: channelModel.description,
      focusedSubject: channelModel.focusedSubject,
      channelIconUrl: iconUrl,
    );

    await db.collection('channels').doc().set(channel.toMap());
    log('Image URL saved to Firestore');
    } catch (e) {
      log(e.toString());
    }
   
  }

  editChannel(iconUrl,documentId,ChannelModel channelmodel)async{
     final channel = ChannelModel(
      channelName: channelmodel.channelName,
      email: channelmodel.email,
      uid: channelmodel.uid,
      description: channelmodel.description,
      focusedSubject: channelmodel.focusedSubject,
      channelIconUrl: iconUrl,
     );
   await db.collection('channels').doc(documentId).update(channel.toMap());
  }
}
