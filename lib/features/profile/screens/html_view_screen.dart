import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:sixvalley_delivery_boy/common/basewidgets/custom_image_widget.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/common/basewidgets/custom_app_bar_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class HtmlViewScreen extends StatelessWidget {
  final String title;
  final String htmlContent;
  final String? bannerImageUrl;

  const HtmlViewScreen({
    Key? key,
    required this.title,
    required this.htmlContent,
    this.bannerImageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: Column(
        children: [
          CustomAppBarWidget(title: title),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(Dimensions.paddingSizeSmall),
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  if (bannerImageUrl != null && bannerImageUrl!.isNotEmpty)
                    Column(
                      children: [
                        SizedBox(height: Dimensions.paddingSizeSmall),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                          child: SizedBox(
                            height: 70,
                            width: double.infinity,
                            child: CustomImageWidget(
                              fit: BoxFit.cover,
                              image: bannerImageUrl!,
                            ),
                          ),
                        ),
                        SizedBox(height: Dimensions.paddingSizeSmall),
                      ],
                    ),
                  HtmlWidget(
                    htmlContent,
                    onTapUrl: (String url) {
                      return launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                    },
                    textStyle: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
