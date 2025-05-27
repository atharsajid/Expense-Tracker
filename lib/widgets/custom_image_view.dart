// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:expense_tracker/constants/app_images.dart';
import 'package:expense_tracker/utilities/app_theme.dart';
import 'package:expense_tracker/utilities/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomImageView extends StatelessWidget {
  ///[url] is required parameter for fetching network image
  String? url;

  ///[imagePath] is required parameter for showing png,jpg,etc image
  String? imagePath;

  ///[svgPath] is required parameter for showing svg image
  String? svgPath;

  ///[file] is required parameter for fetching image file
  File? file;

  double? height;
  double? width;
  Color? color;
  BoxFit? fit;
  final String placeHolder;
  Alignment? alignment;
  VoidCallback? onTap;
  EdgeInsetsGeometry? margin;
  BorderRadius? radius;
  BoxBorder? border;
  bool boxShadow = false;
  Widget? placeHolderWidget;

  ///a [CustomImageView] it can be used for showing any type of images
  /// it will shows the placeholder image if image is not found on network image
  CustomImageView({
    super.key,
    this.url,
    this.imagePath,
    this.svgPath,
    this.file,
    this.height,
    this.width,
    this.color,
    this.fit,
    this.alignment,
    this.onTap,
    this.radius,
    this.margin,
    this.border,
    this.placeHolder = AppImages.appLogo,
    this.boxShadow = false,
    this.placeHolderWidget,
  });

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment!,
            child: _buildWidget(),
          )
        : _buildWidget();
  }

  Widget _buildWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: _buildCircleImage(),
      ),
    );
  }

  ///build the image with border radius
  _buildCircleImage() {
    if (radius != null) {
      return ClipRRect(
        borderRadius: radius ?? BorderRadius.zero,
        child: _buildImageWithBorder(),
      );
    } else {
      return _buildImageWithBorder();
    }
  }

  ///build the image with border and border radius style
  _buildImageWithBorder() {
    if (border != null) {
      return Container(
        decoration: BoxDecoration(
          border: border,
          borderRadius: radius,
        ),
        child: _buildImageView(),
      );
    } else {
      return _buildImageView();
    }
  }

  Widget _buildImageView() {
    if (svgPath != null && svgPath!.isNotEmpty) {
      return boxShadow == true
          ? Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7, // Shadow color
                  ),
                ],
              ),
              child: SvgPicture.asset(
                svgPath!,
                height: height,
                width: width,
                fit: fit ?? BoxFit.contain,
                color: color,
              ),
            )
          : SizedBox(
              height: height,
              width: width,
              child: SvgPicture.asset(
                svgPath!,
                height: height,
                width: width,
                fit: fit ?? BoxFit.contain,
                color: color,
              ),
            );
    } else if (file != null && file!.path.isNotEmpty) {
      return Image.file(
        file!,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
        color: color,
      );
    } else if (url != null && url!.isNotEmpty) {
      return CachedNetworkImage(
        height: height,
        width: width,
        fit: fit,
        imageUrl: url!,
        color: color,
        placeholder: (context, url) =>
            placeHolderWidget ??
            const SizedBox(
              height: 30,
              width: 30,
              child:  LinearProgressIndicator(
                color: AppTheme.grey300Color,
                backgroundColor: AppTheme.success50,
              ),
            ),
        errorWidget: (context, url, error) =>
            placeHolderWidget ??
            Padding(
              padding: getPadding(all: 4),
              child: Image.asset(
                placeHolder,
                height: height,
                width: width,
                fit: BoxFit.contain,
                color: AppTheme.success50,
              ),
            ),
      );
    } else if (imagePath != null && imagePath!.isNotEmpty) {
      return Image.asset(
        imagePath!,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
        color: color,
      );
    }
    return const SizedBox();
  }
}
