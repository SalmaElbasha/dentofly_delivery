import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:sixvalley_delivery_boy/features/splash/controllers/splash_controller.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/common/basewidgets/custom_app_bar_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class PolicyScreen extends StatefulWidget {
  final bool isPrivacyPolicy;
  const PolicyScreen({Key? key, required this.isPrivacyPolicy}) : super(key: key);

  @override
  State<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {

  Future<void> _loadData() async {

    Get.find<SplashController>().getConfigData();



  }



  @override
  void initState() {
    super.initState();
    _loadData().then((_) {
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    String _data = widget.isPrivacyPolicy
        ? Get.find<SplashController>().configModel?.privacyPolicy ?? ""
        : Get.find<SplashController>().configModel?.termsConditions ?? "";

    return Scaffold(
      appBar: CustomAppBarWidget(
        title: widget.isPrivacyPolicy ? 'privacy_policy'.tr : 'terms_and_condition'.tr,
        isBack: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).cardColor,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(Dimensions.paddingSizeSmall),
          physics: const BouncingScrollPhysics(),
          child: HtmlWidget(
            _data,
            key: Key(widget.isPrivacyPolicy ? 'privacy_policy' : 'terms_and_condition'),
            onTapUrl: (String url) async {
              await launchUrl(Uri.parse(url));
              return true;
            },
          ),
        ),
      ),
    );
  }
}
