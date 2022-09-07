import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/currency_code.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_button_bottom_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_date_selector/ota_date_picker.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_icon_button.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/hotel/room_reservation/addon_service_calendar/bloc/addon_service_calendar_bloc.dart';
import 'package:ota/modules/hotel/room_reservation/addon_service_calendar/view_model/addon_service_argument_model.dart';
import 'package:ota/modules/search/filters/view/widgets/filter_row/counter_bloc.dart';
import 'package:ota/modules/search/filters/view/widgets/filter_row/filter_row_widget.dart';

const String _kCloseIconPath = "assets/images/icons/cross.svg";
const int _kMaxLine = 1;
const int _kMinServiceQuantity = 0;
const String formNextLine = '\n';

class AddonServiceCalendar extends StatelessWidget {
  final AddonServiceCalendarBloc _bloc = AddonServiceCalendarBloc();

  AddonServiceCalendar({Key? key}) : super(key: key);

  void _setAddOnServiceData(BuildContext context) {
    AddonServiceCalendarArgument argument = ModalRoute.of(context)
        ?.settings
        .arguments as AddonServiceCalendarArgument;
    _bloc.setAddOnServiceViewModelData(argument);
  }

  @override
  Widget build(BuildContext context) {
    _setAddOnServiceData(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.kLight100.withOpacity(0.94),
        centerTitle: true,
        title: Text(
          getTranslated(
              context, AppLocalizationsStrings.selectAdditionalServices),
          style: AppTheme.kHeading1Medium,
        ),
        leading: OtaIconButton(
          icon: Center(
            child: SvgPicture.asset(
              _kCloseIconPath,
              height: kSize16,
              width: kSize16,
              color: AppColors.kGrey70,
            ),
          ),
          onTap: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocBuilder(
        bloc: _bloc,
        builder: () {
          return Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              SafeArea(
                minimum: const EdgeInsets.only(bottom: kSize82),
                child: ListView(
                  children: [
                    _buildCalendar(),
                    _buildQuantityWidget(context),
                    _buildHorizontalDivider(AppColors.kBorderGrey),
                    _buildServiceTitle(),
                    _buildServiceDescription(),
                  ],
                ),
              ),
              _buildPriceFooter(context),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCalendar() {
    return OTADatePicker(
      selectedDate: _bloc.state.serviceSelectedDate,
      checkinDate: _bloc.state.checkInDate,
      checkoutDate: _bloc.state.checkOutDate,
      preselectedDates: _bloc.state.preselectedDates,
      onDateChange: (DateTime date) {
        _bloc.state.serviceSelectedDate = date;
      },
    );
  }

  Widget _buildHorizontalDivider(Color color) {
    return OtaHorizontalDivider(
      dividerColor: color,
    );
  }

  Widget _buildQuantityWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(kSize24, kSize16, kSize16, kSize16),
      child: FilterRowWidget(
        title: getTranslated(context, AppLocalizationsStrings.noOfServices),
        titleStyle: AppTheme.kBodyRegular,
        initialValue: _bloc.state.quantity,
        filterRowWidgetType: FilterRowType.hotelAddonService,
        onValueAdded: (value) => _bloc.updateAddOnServiceQuantity(value),
        onValueRemoved: (value) => _bloc.updateAddOnServiceQuantity(value),
        maxValue: _bloc.calculateMaxAddOnServiceQuantity,
      ),
    );
  }

  Widget _buildServiceTitle() {
    return Padding(
      padding:
          const EdgeInsets.only(right: kSize24, left: kSize24, top: kSize24),
      child: Text(
        _bloc.state.title,
        style: AppTheme.kHeading1Medium,
        maxLines: _kMaxLine,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildServiceDescription() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(kSize24, kSize16, kSize24, kSize24),
      child: Html(
        data: _bloc.state.description,
        style: _getHtmlStyleMap,
      ),
    );
  }

  Widget _buildPriceFooter(BuildContext context) {
    AddonServiceCalendarArgument argument = ModalRoute.of(context)
        ?.settings
        .arguments as AddonServiceCalendarArgument;
    CurrencyUtil currencyUtil = CurrencyUtil(currency: argument.currency);
    return OtaBottomButtonBar(
      containerHeight: kSize77,
      padding: const EdgeInsets.fromLTRB(kSize24, kSize16, kSize24, kSize9),
      button1: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyText1,
          children: <TextSpan>[
            TextSpan(
              text: currencyUtil.getFormattedPrice(_bloc.calculateTotalPrice),
              style: AppTheme.kHeading1Medium,
            ),
            TextSpan(
              text: formNextLine +
                  getTranslated(context, AppLocalizationsStrings.total),
              style: AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50),
            )
          ],
        ),
      ),
      button2: SizedBox(
        width: kSize120,
        height: kSize40,
        child:
            (argument.serviceSelectedDate != null && _bloc.state.quantity == 0)
                ? _buildRemoveButton(context)
                : OtaTextButton(
                    title: getTranslated(context, AppLocalizationsStrings.ok),
                    isDisabled: _bloc.state.serviceSelectedDate == null ||
                        _bloc.state.quantity <= _kMinServiceQuantity,
                    onPressed: () => Navigator.of(context).pop(_bloc.state),
                  ),
      ),
    );
  }

  Widget _buildRemoveButton(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppColors.kSystemWrong),
        shape: MaterialStateProperty.all(
          const RoundedRectangleBorder(
              borderRadius: AppTheme.kBorderRadiusAll24),
        ),
      ),
      child: Text(
        getTranslated(context, AppLocalizationsStrings.delete),
        overflow: TextOverflow.ellipsis,
        style: AppTheme.kButton.copyWith(color: AppColors.kLight100),
        textAlign: TextAlign.center,
      ),
      onPressed: () => Navigator.of(context).pop(_bloc.state),
    );
  }

  Map<String, Style> get _getHtmlStyleMap {
    return {
      htmlTagH1: Style.fromTextStyle(AppTheme.htmlBodyText),
      htmlTagH2: Style.fromTextStyle(AppTheme.htmlBodyText),
      htmlTagP: Style.fromTextStyle(AppTheme.htmlBodyText),
      htmlTagUL: Style.fromTextStyle(AppTheme.htmlBodyText),
      htmlTagLI: Style.fromTextStyle(AppTheme.htmlBodyText),
      htmlTagBody: Style(margin: EdgeInsets.zero, padding: EdgeInsets.zero),
      htmlTagFigure: Style(margin: EdgeInsets.zero),
    };
  }
}
