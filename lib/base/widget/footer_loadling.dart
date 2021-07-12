import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/material.dart'
    hide RefreshIndicator, RefreshIndicatorState;
import 'package:t4edu_source_source/global/app_color.dart';
import 'package:t4edu_source_source/global/app_path.dart';


class FooterLoad extends LoadIndicator {
  final String idleText, loadingText, noDataText, failedText, canLoadingText;

  final OuterBuilder outerBuilder;

  final Widget idleIcon, loadingIcon, noMoreIcon, failedIcon, canLoadingIcon;

  /// icon and text middle margin
  final double spacing;

  final IconPosition iconPos;

  final TextStyle textStyle;

  /// notice that ,this attrs only works for LoadStyle.ShowWhenLoading
  final Duration completeDuration;

  const FooterLoad({
    Key key,
    VoidCallback onClick,
    LoadStyle loadStyle: LoadStyle.ShowAlways,
    double height: 60.0,
    this.outerBuilder,
    this.textStyle,
    this.loadingText,
    this.noDataText,
    this.noMoreIcon,
    this.idleText,
    this.failedText,
    this.canLoadingText,
    this.failedIcon,
    this.iconPos: IconPosition.left,
    this.spacing: 15.0,
    this.completeDuration: const Duration(milliseconds: 300),
    this.loadingIcon,
    this.canLoadingIcon,
    this.idleIcon,
  }) : super(
    key: key,
    loadStyle: loadStyle,
    height: height,
    onClick: onClick,
  );

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return _FooterLoadState();
  }
}

class _FooterLoadState extends LoadIndicatorState<FooterLoad> {
  Widget _buildText(LoadStatus mode) {
    RefreshString strings =
        RefreshLocalizations.of(context)?.currentLocalization ??
            EnRefreshString();
    return Text(
      mode == LoadStatus.loading
          ? widget.loadingText ?? strings.loadingText
          : LoadStatus.noMore == mode
          ? widget.noDataText ?? strings.noMoreText
          : LoadStatus.failed == mode
          ? widget.failedText ?? strings.loadFailedText
          : LoadStatus.canLoading == mode
          ? widget.canLoadingText ?? strings.canLoadingText
          : widget.idleText ?? strings.idleLoadingText,
      style: widget.textStyle ??
          TextStyle(color: AppColors.black, fontSize: 12.0),
    );
  }

  Widget _buildIcon(LoadStatus mode) {
    Widget icon = mode == LoadStatus.loading
        ? widget.loadingIcon ??
        SizedBox(
          width: 18.0,
          height: 18.0,
          child: Lottie.asset(
            AppPath.loading,
            width: 25,
            height: 25,
            fit: BoxFit.fill,
            // options: LottieOptions(enableMergePaths: true),
          ),
        )
        : mode == LoadStatus.noMore
        ? widget.noMoreIcon
        : mode == LoadStatus.failed
        ? widget.failedIcon ??
        Icon(
          Icons.error,
          color: AppColors.black,
          size: 18.0,
        )
        : mode == LoadStatus.canLoading
        ? widget.canLoadingIcon ??
        Icon(
          Icons.autorenew,
          color: AppColors.black,
          size: 18.0,
        )
        : widget.idleIcon ??
        Icon(
          Icons.arrow_upward,
          color: AppColors.black,
          size: 18.0,
        );
    return icon ?? Container();
  }

  @override
  Future endLoading() {
    return Future.delayed(widget.completeDuration);
  }

  @override
  Widget buildContent(BuildContext context, LoadStatus mode) {
    // TODO: implement buildChild
    Widget textWidget = _buildText(mode);
    Widget iconWidget = _buildIcon(mode);
    List<Widget> children = <Widget>[iconWidget, textWidget];
    final Widget container = Wrap(
      spacing: widget.spacing,
      textDirection: widget.iconPos == IconPosition.left
          ? TextDirection.ltr
          : TextDirection.rtl,
      direction: widget.iconPos == IconPosition.bottom ||
          widget.iconPos == IconPosition.top
          ? Axis.vertical
          : Axis.horizontal,
      crossAxisAlignment: WrapCrossAlignment.center,
      verticalDirection: widget.iconPos == IconPosition.bottom
          ? VerticalDirection.up
          : VerticalDirection.down,
      alignment: WrapAlignment.center,
      children: children,
    );
    return widget.outerBuilder != null
        ? widget.outerBuilder(container)
        : Container(
      height: widget.height,
      child: Center(
        child: container,
      ),
    );
  }
}
