import 'package:base_structure/src/core/components/app_appbars/global_appbar.dart';
import 'package:base_structure/src/core/components/payment/payment_webview.dart';
import 'package:base_structure/src/core/navigation/app_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key, required this.payUrl});

  final String payUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppbar(
        title: 'payment'.tr(),
        onBackPressed: () async {
          if (payUrl.contains('/app_url')) {
            await SystemNavigator.pop();
          } else {
            AppRouter.pop();
          }
        },
      ),
      body: PaymentWebViewWidget(
        redirectPaymentUrl: payUrl,
        callBackKey: '/callback',
        successKey: 'success',
        failedKey: 'failed',
        onSuccess: () {
          // DialogHelper.onShowAnimatedDialog(
          //   navigatorKey.currentContext!,
          //   widget: AppAlertDialogWidget(
          //     isSuccess: true,
          //     height: 200.h,
          //     title: ''.tr(),
          //     subtitle: ''.tr(),
          //     description: ''.tr(),
          //     buttonTitle: ''.tr(),
          //     onConfirm: () {
          //       AppRouter.pop();
          //       AppRouter.pop();
          //       AppRouter.pushReplacement(AppRoutes.deposit);
          //     },
          //   ),
          // );
        },
        onFailed: () {
          // AppRouter.pop();
          // AppToast.showError('payment_error_message'.tr());
        },
      ),
    );
  }
}
