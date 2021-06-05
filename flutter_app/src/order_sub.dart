import 'package:url_launcher/url_launcher.dart';

// opens the publix website if possible.
void orderSub() async {
  const url = "https://www.publix.com/pd/publix-chicken-tender-sub/BMO-DSB-100011?ch=18.2.1.&oeo=true";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not open webpage';
  }
}