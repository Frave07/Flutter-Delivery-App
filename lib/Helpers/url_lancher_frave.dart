part of 'Helpers.dart';

class UrlLauncherFrave {


  Future<void> openMapLaunch(String latitude, String longitude) async {

    var url = 'google.navigation:q=$latitude,$longitude&mode=d';
    var urlGoogleMap =  'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    try {
      bool isLaunched = await launch(url, forceSafariVC: false, forceWebView: false);
      if(!isLaunched) await launch(urlGoogleMap, forceSafariVC: false, forceWebView: false);
    } catch (e) {
      print(e);
    }

  }


  Future<void> makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


}

final urlLauncherFrave = UrlLauncherFrave();