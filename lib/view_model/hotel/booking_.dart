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
  // =========>>>>>  CHECKING, IS ROOM AVAILABLE OR NOT  <<<<<==========
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

  // =========>>>>>  TO GET BOOKING DATA  <<<<<==========
  Future<bool> _getBookingData(
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
      ShowDialogs.popUp(bookingResponse.message ?? 'Rooms are not available',
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

  // =========>>>>>  ON BOOKNOW BUTTON  <<<<<==========
  Future<void> onBookNowButton(AllRoomsModel hotel, double width) async {
    final bool isRoomAvailables =
        await isRoomAvailable(selectedDates, hotel.id ?? '', rooms);
    if (isRoomAvailables) {
      final bool isSuccess =
          await _getBookingData(hotel.id ?? '', rooms, selectedDates);
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

  // =========>>>>>  RAZORPAY CREDENTIALS  <<<<<==========
  late Razorpay razorPay;
  BookingViewModel() {
    razorPay = Razorpay();
    razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlerPaymentSuccess);
    razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlerErrorFailure);
    razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handlerExternalWallet);
  }

  void _handlerPaymentSuccess(PaymentSuccessResponse response) async {
    Navigations.pushRemoveUntil(const MainPage());
    ShowDialogs.popUp('Payment success', color: KColors.kThemeGreen);
    razorPay.clear();
  }

  void _handlerErrorFailure(PaymentFailureResponse response) {
    ShowDialogs.popUp('Payment failed !!');
    razorPay.clear();
  }

  void _handlerExternalWallet(ExternalWalletResponse response) {
    log('handlerExternalWallet');
    razorPay.clear();
  }

  // =========>>>>>  ON PAYNOW BUTTON  <<<<<==========
  Future<void> onPayNowButton(int amount) async {
    final PayNowResponseModel? response = await _getOnlinePaymentData(amount);
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

  // =========>>>>>  TO GET ONLINE PAYMENT DATA  <<<<<==========
  Future<PayNowResponseModel?> _getOnlinePaymentData(int amount) async {
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

  // =========>>>>>  ON PAY AT HOTEL BUTTON  <<<<<==========
  Future<void> onPayAtHotelButton() async {}
}
