import 'package:url_launcher/url_launcher.dart';

class UrlLauncherFrave {


  Future<void> openMapLaunch(String latitude, String longitude) async {

    var url = 'google.navigation:q=$latitude,$longitude&mode=d';
    var urlGoogleMap =  'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    try {
      bool isLaunched = await launchUrl(Uri.parse(url));
      if(!isLaunched) await launchUrl(Uri.parse(urlGoogleMap));
    } catch (e) {
      print(e);
    }

  }


  Future<void> makePhoneCall(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }


}

final urlLauncherFrave = UrlLauncherFrave();