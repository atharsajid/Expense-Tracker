import 'package:expense_tracker/constants/app_strings.dart';
import 'package:expense_tracker/domain/enums/transaction_type.dart';
import 'package:expense_tracker/domain/models/transaction.dart';
import 'package:expense_tracker/utilities/app_theme.dart';
import 'package:expense_tracker/utilities/extensions.dart/date_time_extensions.dart';
import 'package:expense_tracker/utilities/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TransactionChartWidget extends StatelessWidget {
  final List<Transaction>? dataSource;
  const TransactionChartWidget({
    super.key,
    this.dataSource,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getSize(200),
      width: MediaQuery.sizeOf(context).width * 0.75,
      child: SfCartesianChart(
        plotAreaBorderWidth: 0,
        tooltipBehavior: TooltipBehavior(
          enable: true,
        ),
        primaryXAxis: CategoryAxis(
          majorGridLines: const MajorGridLines(width: 0),
          majorTickLines: const MajorTickLines(size: 0),
          axisLine: const AxisLine(width: 0.4),
          axisLabelFormatter: (axisLabelRenderArgs) {
            return ChartAxisLabel(axisLabelRenderArgs.text, AppTheme.customFontStyle(fontSize: 8));
          },
        ),
        primaryYAxis: const NumericAxis(
          axisLine: AxisLine(width: 0.0),
          maximum: 10000,
          minimum: 0,
          interval: 2000,
          majorGridLines: MajorGridLines(width: 0.6),
          majorTickLines: MajorTickLines(size: 0),
        ),
        series: <ColumnSeries<Transaction, String>>[
          ColumnSeries<Transaction, String>(
            dataSource: dataSource,
            xValueMapper: (Transaction value, _) => value.date.toFormatDateTime(format: 'dd-MMM'),
            yValueMapper: (Transaction value, _) => value.amount,
            pointColorMapper: (Transaction value, index) =>
                value.type == TransactionType.EXPENSE.name ? AppTheme.errorColor : AppTheme.darkSuccessColor,
            width: 0.4,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(2)),
            name: AppStrings.transaction,
            enableTooltip: true,
          ),
        ],
      ),
    );
  }
}
