import 'package:flutter/material.dart';
import './data/heatmap_color_mode.dart';
import 'widget/heatmap_calendar_page_custom.dart';
import './widget/heatmap_color_tip.dart';
import './util/date_util.dart';

class HeatMapCalendarWeekly extends StatefulWidget {
  /// The datasets which fill blocks based on its value.
  final Map<DateTime, int>? datasets;

  /// The color value of every block's default color.
  final Color? defaultColor;

  /// The colorsets which give the color value for its thresholds key value.
  ///
  /// Be aware that first Color is the maximum value if [ColorMode] is [ColorMode.opacity].
  /// Also colorsets must have at least one color.
  final Map<int, Color> colorsets;

  /// The double value of every block's borderRadius.
  final double? borderRadius;

  /// The date values of initial year and month.
  final DateTime? initDate;

  /// BitişTarihi olarak ayarlıyorum
  final DateTime? endDate;

  /// The double value of every block's size.
  final double? size;

  /// The text color value of every blocks.
  final Color? textColor;

  /// The double value of every block's fontSize.
  final double? fontSize;

  /// The double value of month label's fontSize.
  final double? monthFontSize;

  /// The double value of week label's fontSize.
  final double? weekFontSize;
  
  ///
  final TextStyle? textStyle;

  /// The text color value of week labels.
  final Color? weekTextColor;

  /// Make block size flexible if value is true.
  ///
  /// Default value is false.
  final bool? flexible;

  /// The margin value for every block.
  final EdgeInsets? margin;

  /// ColorMode changes the color mode of blocks.
  ///
  /// [ColorMode.opacity] requires just one colorsets value and changes color
  /// dynamically based on hightest value of [datasets].
  /// [ColorMode.color] changes colors based on [colorsets] thresholds key value.
  ///
  /// Default value is [ColorMode.opacity].
  final ColorMode colorMode;

  /// Function that will be called when a block is clicked.
  ///
  /// Paratmeter gives clicked [DateTime] value.
  final Function(DateTime)? onClick;

  /// Function that will be called when month is changed.
  ///
  /// Paratmeter gives [DateTime] value of current month.
  final Function(DateTime)? onMonthChange;
  final double? width;
  final double? height;
  /// Show color tip which represents the color range at the below.
  ///
  /// Default value is true.
  final bool? showColorTip;
  final Function(DateTime)? onWeekChange;

  final MainAxisAlignment? mainAxisAlignment;
  /// Widgets which shown at left and right side of colorTip.
  ///
  /// First value is the left side widget and second value is the right side widget.
  /// Be aware that [colorTipHelper.length] have to greater or equal to 2.
  /// Give null value makes default 'less' and 'more' [Text].
  final List<Widget?>? colorTipHelper;

  /// The integer value which represents the number of [HeatMapColorTip]'s tip container.
  final int? colorTipCount;

  /// The double value of [HeatMapColorTip]'s tip container's size.
  final double? colorTipSize;

  final BoxBorder? border;

    final BoxBorder? coloredBorder;
  final TextStyle? coloredTextStyle;

  const HeatMapCalendarWeekly({
    Key? key,
    required this.colorsets,
    this.colorMode = ColorMode.opacity,
    this.defaultColor,
    this.datasets,
    this.initDate,
    this.size = 42,
    this.fontSize,
    this.monthFontSize,
    this.textColor,
    this.weekFontSize,
    this.weekTextColor,
    this.borderRadius,
    this.flexible = false,
    this.margin,
    this.onClick,
    this.onMonthChange,
    this.showColorTip = true,
    this.colorTipHelper,
    this.colorTipCount,
    this.colorTipSize, 
    this.endDate, 
    this.onWeekChange, 
    this.border,
    this.coloredBorder,
    this.coloredTextStyle,
    this.textStyle, this.width, this.height,  this.mainAxisAlignment,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HeatMapCalendar();
}

class _HeatMapCalendar extends State<HeatMapCalendarWeekly> {
  // The DateTime value of first day of the current month.
  DateTime? _currentDate;
  

  @override
  void initState() {
    super.initState();
    setState(() {
      // Set _currentDate value to first day of initialized date or
      // today's month if widget.initDate is null.
      _currentDate =
          DateUtil.startDayOfMonthCustom(widget.initDate ?? DateTime.now());
    });
  }
void changeWeek(int direction) {
  setState(() {
    _currentDate = DateUtil.changeDay(_currentDate ?? DateTime.now(), 7 * direction);
  });
  if (widget.onWeekChange != null) widget.onWeekChange!(_currentDate!);
}


  void changeMonth(int direction) {
    setState(() {
      _currentDate =
          DateUtil.changeMonth(_currentDate ?? DateTime.now(), direction);
    });
    if (widget.onMonthChange != null) widget.onMonthChange!(_currentDate!);
  }

  /// Header widget which shows left, right buttons and year/month text.
/*   Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        // Previous month button.
        IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 14,
          ),
          onPressed: () => changeWeek(-1),
        ),

        // Text which shows the current year and month
 

        // Next month button.
        IconButton(
          icon: const Icon(
            Icons.arrow_forward_ios,
            size: 14,
          ),
          onPressed: () => changeWeek(1),
        ),
      ],
    );
  } */


  /// Expand width dynamically if [flexible] is true.
  Widget _intrinsicWidth({
    required Widget child,
  }) =>
      (widget.flexible ?? false) ? child : IntrinsicWidth(child: child);

  @override
  Widget build(BuildContext context) {
    return _intrinsicWidth(
      child:
         Column(
          
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
           // _header(),
           // _weekLabel(),
            SizedBox(
              width: widget.width,
              height: widget.height,
              child: 
            HeatMapCalendarPageWeekly(
              
              baseDate: _currentDate ?? DateTime.now(),
              colorMode: widget.colorMode,
              flexible: widget.flexible,
              size: widget.size,
              fontSize: widget.fontSize,
              defaultColor: widget.defaultColor,
              textColor: widget.textColor,
              margin: widget.margin,
              datasets: widget.datasets,
              colorsets: widget.colorsets,
              borderRadius: widget.borderRadius,
              textStyle: widget.textStyle,
              mainAxisAlignment: widget.mainAxisAlignment,
              border: widget.border,
              coloredBorder: widget.coloredBorder,
              coloredTextStyle: widget.coloredTextStyle,
              
            )),
            if (widget.showColorTip == true)
              HeatMapColorTip(
                
                colorMode: widget.colorMode,
                colorsets: widget.colorsets,
                leftWidget: widget.colorTipHelper?[0],
                rightWidget: widget.colorTipHelper?[1],
                containerCount: widget.colorTipCount,
                size: widget.colorTipSize,
              
              ),
          ],
        ),
      
    );
  }
}
