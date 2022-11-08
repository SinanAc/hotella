import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:premio_inn/model/bookings/booking/booking_req.dart';
import 'package:premio_inn/model/bookings/booking/booking_respo.dart';
import 'package:premio_inn/model/bookings/payment/paynow_respo_model.dart';
import 'package:premio_inn/model/bookings/payment/razorpay_checkout.dart';
import 'package:premio_inn/model/bookings/room_availability/request.dart';
import 'package:premio_inn/model/bookings/room_availability/response.dart';
import 'package:premio_inn/model/home/all_rooms.dart';
import 'package:premio_inn/services/booking/booking_service.dart';
import 'package:premio_inn/services/booking/paynow_service.dart';
import 'package:premio_inn/services/booking/room_availability.dart';
import 'package:premio_inn/utils/colors.dart';
import 'package:premio_inn/utils/navigations.dart';
import 'package:premio_inn/view/screens/hotel_view/widgets/payment_options.dart';
import 'package:premio_inn/view/screens/main_page/main_page.dart';
import 'package:premio_inn/view/widgets/show_dialogs.dart';
import 'package:premio_inn/view_model/hotel/hotel_view_model.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class BookingViewModel extends HotelViewModel {
  bool isLoading = false;
    Future<bool> getBookingId(
      String hotelId, int rooms, DateTimeRange dateRange) async {
    isLoading = true;
    notifyListeners();
    final data = BookingRequestModel(
        hotelId: hotelId, rooms: rooms, dateTimeRange: dateRange);
    final BookingResponseModel? bookingResponse =
        await BookingService().bookingService(data);
    if (bookingResponse == null) {
      isLoading = false;
      notifyListeners();
      ShowDialogs.popUp('Something went wrong !!');
      return false;
    } else if (bookingResponse.success == false) {
      isLoading = false;
      notifyListeners();
      ShowDialogs.popUp(
          bookingResponse.message ??
              'Rooms are not available on the selected range. Please try with other dates.',
          color: Colors.black87);
      return false;
    } else if (bookingResponse.success == true) {
      isLoading = false;
      notifyListeners();
      return bookingResponse.success ?? false;
    } else {
      isLoading = false;
      notifyListeners();
      ShowDialogs.popUp(bookingResponse.message ?? 'Something went wrong !!');
      return false;
    }
  }
  Future<bool> isRoomAvailable(
      DateTimeRange dateRange, String hotelId, int rooms) async {
    isLoading = true;
    notifyListeners();
    final data = RoomAvailabiltyRequestModel(
      dateTimeRange: dateRange,
      hotelId: hotelId,
      numberOfRooms: rooms,
    );
    final RoomAvailabilityResponseModel? isRoomAvailableResponse =
        await RoomAvailabilityService().isRoomAvailabileService(data);
    if (isRoomAvailableResponse == null) {
      isLoading = false;
      notifyListeners();
      ShowDialogs.popUp('Something went wrong !!');
      return false;
    } else if (isRoomAvailableResponse.isAvailable == false) {
      isLoading = false;
      notifyListeners();
      ShowDialogs.popUp(
          isRoomAvailableResponse.message ??
              'Rooms are not available on the selected range. Please try with other dates.',
          color: Colors.black87);
      return false;
    } else if (isRoomAvailableResponse.isAvailable == true) {
      isLoading = false;
      notifyListeners();
      return true;
    } else {
      isLoading = false;
      notifyListeners();
      ShowDialogs.popUp(
          isRoomAvailableResponse.message ?? 'Something went wrong !!');
      return false;
    }
  }

  Future<void> onBookNowButton(AllRoomsModel hotel, double width) async {
    final bool isRoomAvailables =
        await isRoomAvailable(selectedDates, hotel.id ?? '', rooms);
    if (isRoomAvailables) {
      final bool isSuccess =
          await getBookingId(hotel.id ?? '', rooms, selectedDates);
      isSuccess
          ? showPaymentOptions(
              width: width,
              onPayAtHotelButton: () {},
              onPayNowButton: () {
                Navigations.pop();
                onPayNowButton(totalAmount(hotel.price ?? 0));
              },
              price: totalAmount(hotel.price ?? 0),
            )
          : null;
    }
  }

  late Razorpay razorPay;
  BookingViewModel() {
    razorPay = Razorpay();
    razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  // void dispose() {
  //   razorPay.clear();
  // }

  void handlerPaymentSuccess(PaymentSuccessResponse response) async {
    Navigations.pushRemoveUntil(const MainPage());
    ShowDialogs.popUp('Payment success', color: KColors.kThemeGreen);
  }

  void handlerErrorFailure(PaymentFailureResponse response) {
    ShowDialogs.popUp('Payment failed !!');
  }

  void handlerExternalWallet(ExternalWalletResponse response) {
    log('handlerExternalWallet');
  }

  // -->> function to pay online
  Future<void> onPayNowButton(int amount) async {
    final PayNowResponseModel? response = await getOnlinePaymentData(amount);
    if (response == null) {
      ShowDialogs.popUp('Oops!! Something went wrong. Please try again later');
      return;
    }
    RazorpayCheckoutModel options = RazorpayCheckoutModel(
      key: response.keyId,
      amount: response.amount.toString(),
      currency: response.currency,
      name: "Hotella",
      description: "Payment to book your selected room via Hotella",
      orderId: response.id,
    );
    try {
      razorPay.open(options.toJson());
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  // ===========================  ================================ //

 // bool isPaynowLoading = false;
  Future<PayNowResponseModel?> getOnlinePaymentData(int amount) async {
    isLoading = true;
    super.notifyListeners();
    final PayNowResponseModel? response =
        await PayNowService().payNowService(amount);
    if (response == null) {
      isLoading = false;
      notifyListeners();
      ShowDialogs.popUp('Something went wrong !!');
      return null;
    } else if (response.id != null) {
      isLoading = false;
      notifyListeners();
      return response;
    } else {
      isLoading = false;
      notifyListeners();
      ShowDialogs.popUp(response.message ?? 'Something went wrong !!');
      return null;
    }
  }

  // -->> function to pay at hotel
  void onPayAtHotelButton() {}
}
