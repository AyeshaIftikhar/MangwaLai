import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFF900c3f)),
        backgroundColor: Colors.white,
        title: Text(
          'Privacy Policy',
          style: TextStyle(color: Color(0xFF900c3f)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            Column(
              children: [
                Text(
                  'Privacy Policy\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                    'Axact Studios built the Grocery Man app as a Commercial app. This SERVICE is provided by Axact Studios and is '
                    'intended for use as is.\n'
                    'This page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal '
                    'Information if anyone decided to use my Service.\n'
                    'If you choose to use my Service, then you agree to the collection and use of information in relation to this policy.\n'
                    'The Personal Information that I collect is used for providing and improving the Service. I will not use or share '
                    'your information with anyone except as described in this Privacy Policy.\n'
                    'The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which is '
                    'accessible at Grocery Man unless otherwise defined in this Privacy Policy.\n'),
                Text(
                  'Information Collection and Use\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                    'For a better experience, while using our Service, I may require you to provide us with certain personally '
                    'identifiable information, including but not limited to Name, Phone No., Address, Pincode. The information that I '
                    'request will be retained on your device and is not collected by me in any way.'
                    'The app does use third party services that may collect information used to identify you.'
                    'Link to privacy policy of third party service providers used by the app are given at the end.\n'),
                Text(
                  'Log Data\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                    'I want to inform you that whenever you use my Service, in a case of an error in the app I collect data and '
                    'information (through third party products) on your phone called Log Data. This Log Data may include '
                    'information such as your device Internet Protocol (“IP”) address, device name, operating system version, the '
                    'configuration of the app when utilizing my Service, the time and date of your use of the Service, and other statistics.\n'),
                Text(
                  'Cookies\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                    'Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These '
                    'are sent to your browser from the websites that you visit and are stored on your device\'s internal memory.'
                    'This Service does not use these “cookies” explicitly. However, the app may use third party code and libraries '
                    'that use “cookies” to collect information and improve their services. You have the option to either accept or '
                    'refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, '
                    'you may not be able to use some portions of this Service.\n'),
                Text(
                  'Service Providers\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                    'I may employ third-party companies and individuals due to the following reasons:\n'
                    '* To facilitate our Service;\n'
                    '* To provide the Service on our behalf;\n'
                    '* To perform Service-related services; or \n'
                    '* To assist us in analyzing how our Service is used.\n'
                    'I want to inform users of this Service that these third parties have access to your Personal Information. The '
                    'reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or '
                    'use the information for any other purpose.\n'),
                Text(
                  'Security\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                    'I value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable '
                    'means of protecting it. But remember that no method of transmission over the internet, or method of electronic '
                    'storage is 100% secure and reliable, and I cannot guarantee its absolute security.\n'),
                Text(
                  'Links to Other Sites\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                    'This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. '
                    'Note that these external sites are not operated by me. Therefore, I strongly advise you to review the Privacy '
                    'Policy of these websites. I have no control over and assume no responsibility for the content, privacy policies, or '
                    'practices of any third-party sites or services.\n'),
                Text(
                  'Children’s Privacy\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                    'These Services do not address anyone under the age of 13. I do not knowingly collect personally identifiable '
                    'information from children under 13. In the case I discover that a child under 13 has provided me with personal '
                    'information, I immediately delete this from our servers. If you are a parent or guardian and you are aware that '
                    'your child has provided us with personal information, please contact me so that I will be able to do necessary actions.\n'),
                Text(
                  'Changes to This Privacy Policy\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                    'I may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any '
                    'changes. I will notify you of any changes by posting the new Privacy Policy on this page.'
                    'This policy is effective as of 15-05-2021.\n'),
                Text(
                  'Contact Us\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                    'If you have any questions or suggestions about my Privacy Policy, do not hesitate to contact me.'
                    'Our official email address is mangwalaiapp@gmail.com.'),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: _launchURL1,
                  child: Text(
                    'Google Play Services',
                    style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                    onTap: _launchURL,
                    child: Text(
                      'Google Analytics for Firebase',
                      style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline),
                    )),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                    onTap: _launchURL2,
                    child: Text(
                      'RazorPay for Payments',
                      style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _launchURL1() async {
    const url = 'https://policies.google.com/privacy';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURL() async {
    const url = 'https://firebase.google.com/policies/analytics';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURL2() async {
    const url = 'https://razorpay.com/privacy/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
