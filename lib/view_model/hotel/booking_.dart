import 'package:flutter/material.dart';
import 'package:premio_inn/model/bookings/booking/booking_req.dart';
import 'package:premio_inn/model/bookings/booking/booking_respo.dart';
import 'package:premio_inn/model/bookings/complete/complete_req.dart';
import 'package:premio_inn/model/bookings/payment/paynow_respo_model.dart';
import 'package:premio_inn/model/bookings/payment/razorpay_checkout.dart';
import 'package:premio_inn/model/bookings/room_availability/request.dart';
import 'package:premio_inn/model/bookings/room_availability/response.dart';
import 'package:premio_inn/model/home/all_rooms.dart';
import 'package:premio_inn/model/register/sign_in/signin_response_model.dart';
import 'package:premio_inn/services/booking/booking_service.dart';
import 'package:premio_inn/services/booking/complete_service.dart';
import 'package:premio_inn/services/booking/paynow_service.dart';
import 'package:premio_inn/services/booking/room_availability.dart';
import 'package:premio_inn/utils/navigations.dart';
import 'package:premio_inn/utils/strings.dart';
import 'package:premio_inn/view/screens/hotel_view/widgets/payment_options.dart';
import 'package:premio_inn/view/screens/main_page/main_page.dart';
import 'package:premio_inn/view/widgets/show_dialogs.dart';
import 'package:premio_inn/view_model/hotel/hotel_view_model.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingViewModel extends HotelViewModel {
  bool isLoading = false;
  BookingResponseModel? bookingData;
  // =========>>>>>  CHECKING, IS ROOM AVAILABLE OR NOT  <<<<<==========
  Future<bool> isRoomAvailable(
      DateTimeRange dateRange, String hotelId, int rooms) async {
    _isLoadingTrue();
    final data = RoomAvailabiltyRequestModel(
      dateTimeRange: dateRange,
      hotelId: hotelId,
      numberOfRooms: rooms,
    );
    final RoomAvailabilityResponseModel? isRoomAvailableResponse =
        await RoomAvailabilityService().isRoomAvailabileService(data);
    if (isRoomAvailableResponse == null) {
      _isLoadingFalse();
      ShowDialogs.popUp('Something went wrong !!');
      return false;
    } else if (isRoomAvailableResponse.isAvailable == false) {
      _isLoadingFalse();
      ShowDialogs.popUp(
          isRoomAvailableResponse.message ??
              'Rooms are not available on the selected range. Please try with other dates.',
          color: Colors.black87);
      return false;
    } else if (isRoomAvailableResponse.isAvailable == true) {
      _isLoadingFalse();
      return true;
    } else {
      _isLoadingFalse();
      ShowDialogs.popUp(
          isRoomAvailableResponse.message ?? 'Something went wrong !!');
      return false;
    }
  }

  // =========>>>>>  TO GET BOOKING DATA  <<<<<==========
  Future<BookingResponseModel?> _getBookingData(
      String hotelId, int rooms, DateTimeRange dateRange) async {
    _isLoadingTrue();
    final data = BookingRequestModel(
        hotelId: hotelId, rooms: rooms, dateTimeRange: dateRange);
    final BookingResponseModel? bookingResponse =
        await BookingService().bookingService(data);
    if (bookingResponse == null) {
      _isLoadingFalse();
      ShowDialogs.popUp('Something went wrong !!');
      return null;
    } else if (bookingResponse.success == false) {
      _isLoadingFalse();
      ShowDialogs.popUp(bookingResponse.message ?? 'Rooms are not available',
          color: Colors.black87);
      return null;
    } else if (bookingResponse.success == true) {
      _isLoadingFalse();
      bookingData = bookingResponse;
      return bookingResponse;
    } else {
      _isLoadingFalse();
      ShowDialogs.popUp(bookingResponse.message ?? 'Something went wrong !!');
      return null;
    }
  }

  // =========>>>>>  ON BOOKNOW BUTTON  <<<<<==========
  Future<void> onBookNowButton(AllRoomsModel hotel, double width) async {
    final bool isRoomAvailables =
        await isRoomAvailable(selectedDates, hotel.id ?? '', rooms);
    if (isRoomAvailables) {
      final BookingResponseModel? response =
          await _getBookingData(hotel.id ?? '', rooms, selectedDates);
      if (response == null) {
        return;
      } else if (response.success == true) {
        showPaymentOptions(
          width: width,
          onPayAtHotelButton: () {
            Navigations.pop();
            _completeBooking(paymentType: 'PAY AT HOTEL');
          },
          onPayNowButton: () {
            Navigations.pop();
            _onPayNowButton(totalAmount(hotel.price ?? 0));
          },
          price: totalAmount(hotel.price ?? 0),
        );
      } else {
        return;
      }
    }
  }

  // =========>>>>>  BOOKING COMPLETE METHOD  <<<<<==========
  Future<void> _completeBooking({
    required String paymentType,
    String? signature,
    String? payId,
    String? odrId,
  }) async {
    if (bookingData == null) {
      return;
    } else {
      _isLoadingTrue();
      if (paymentType == 'PAY AT HOTEL') {
        final data = CompleteBookingRequestModel(
          rooms: bookingData?.response?.room ?? '',
          checkout: bookingData?.response?.id ?? '',
          pay: paymentType,
        );
        final complete =
            await BookingCompleteService().bookingCompleteService(data);
        if (complete == null) {
          _isLoadingFalse();
          ShowDialogs.popUp('Booking failed !!');
          return;
        } else if (complete.success == true) {
          _isLoadingFalse();
          ShowDialogs.popUp('Successfully booked', color: Colors.green);
          await Future.delayed(const Duration(seconds: 1));
          Navigations.pushRemoveUntil(const MainPage());
          return;
        } else {
          _isLoadingFalse();
          ShowDialogs.popUp('Booking failed !!');
          return;
        }
      } else {
        final data = CompleteBookingRequestModel(
          rooms: bookingData?.response?.room ?? '',
          checkout: bookingData?.response?.id ?? '',
          pay: paymentType,
          razorpaymentId: payId,
          order: odrId,
        );
        final complete = await BookingCompleteService()
            .bookingCompleteService(data, signature: signature);
        if (complete == null) {
          _isLoadingFalse();
          ShowDialogs.popUp('Booking failed !!');
          return;
        } else if (complete.success == true) {
          _isLoadingFalse();
          ShowDialogs.popUp('Successfully booked', color: Colors.green);
          await Future.delayed(const Duration(seconds: 1));
          Navigations.pushRemoveUntil(const MainPage());
          return;
        } else {
          _isLoadingFalse();
          ShowDialogs.popUp('Booking failed !!');
        }
      }
    }
  }

  // =========>>>>>  RAZORPAY CREDENTIALS  <<<<<==========
  late Razorpay razorPay;
  void initializeRazorPay() {
    razorPay = Razorpay();
    razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlerPaymentSuccess);
    razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlerErrorFailure);
    razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handlerExternalWallet);
  }

  _handlerPaymentSuccess(PaymentSuccessResponse response) async {
    await _completeBooking(
      paymentType: 'ONLINE',
      signature: response.signature,
      payId: response.paymentId,
      odrId: response.orderId,
    );
    razorPay.clear();
  }

  void _handlerErrorFailure(PaymentFailureResponse response) {
    ShowDialogs.popUp('Payment failed !!');
    razorPay.clear();
  }

  void _handlerExternalWallet(ExternalWalletResponse response) {
    razorPay.clear();
  }

  // =========>>>>>  ON PAYNOW BUTTON  <<<<<==========
  Future<void> _onPayNowButton(int amount) async {
    final PayNowResponseModel? response = await _getOnlinePaymentData(amount);
    if (response == null) {
      ShowDialogs.popUp('Oops!! Something went wrong. Please try again later');
      return;
    }
    final options = await _razorPayData(response);
    try {
      razorPay.open(options.toJson());
      notifyListeners();
    } catch (e) {
      ShowDialogs.popUp('Something went wrong !!');
    }
  }

  // =========>>>>>  TO GET ONLINE PAYMENT DATA  <<<<<==========
  Future<PayNowResponseModel?> _getOnlinePaymentData(int amount) async {
    _isLoadingTrue();
    final PayNowResponseModel? response =
        await PayNowService().payNowService(amount);
    if (response == null) {
      _isLoadingFalse();
      ShowDialogs.popUp('Something went wrong !!');
      return null;
    } else if (response.id != null) {
      _isLoadingFalse();
      return response;
    } else {
      _isLoadingFalse();
      ShowDialogs.popUp(response.message ?? 'Something went wrong !!');
      return null;
    }
  }

  // ==========>>>>>  RAZORPAY CHECKOUT OPTIONS  <<<<<==========
  Future<RazorpayCheckoutModel> _razorPayData(
      PayNowResponseModel response) async {
    final pref = await SharedPreferences.getInstance();
    final userData = SignInResponseModel(
        profile: Profile(
      name: pref.getString(KStrings.userName),
      email: pref.getString(KStrings.email),
      phone: pref.getString(KStrings.phone),
    ));
    RazorpayCheckoutModel options = RazorpayCheckoutModel(
        key: response.keyId,
        amount: response.amount.toString(),
        currency: response.currency,
        name: "Hotella",
        description: "Payment to book your selected room via Hotella",
        orderId: response.id,
        prefill: Prefill(
          name: userData.profile?.name ?? '',
          email: userData.profile?.email ?? '',
          contact: userData.profile?.phone ?? '',
        ));
    return options;
  }

  // ==========>>>>>  TO MAKE LOADING TRUE  <<<<<==========
  void _isLoadingTrue() {
    isLoading = true;
    notifyListeners();
  }

  // ==========>>>>>  TO MAKE LOADING FALSE  <<<<<==========
  void _isLoadingFalse() {
    isLoading = false;
    notifyListeners();
  }
}
