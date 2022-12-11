import 'package:flutter/material.dart';
import 'package:premio_inn/model/booking/payment/razorpay_checkout.dart';
import 'package:premio_inn/model/home/all_rooms.dart';
import 'package:premio_inn/utils/colors.dart';
import 'package:premio_inn/view/screens/hotel_view/widgets/bottom_sheet.dart';
import 'package:premio_inn/view/widgets/show_dialogs.dart';
import 'package:premio_inn/model/booking/export.dart';
import 'package:premio_inn/model/register/sign_in/signin_response_model.dart';
import 'package:premio_inn/services/booking/export.dart';
import 'package:premio_inn/utils/navigations.dart';
import 'package:premio_inn/utils/strings.dart';
import 'package:premio_inn/view/screens/hotel_view/widgets/payment_options.dart';
import 'package:premio_inn/view/screens/main_page/main_page.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HotelViewModel extends ChangeNotifier {
  // =========>>>>>  VARIABLES  <<<<<=========
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int guests = 1;
  int rooms = 1;
  int days = 1;
  int amount = 0;
  final PageController pController = PageController();
  bool isLoading = false;
  BookingResponseModel? bookingData;

  // =========>>>>>  INITIAL VALUES  <<<<<=========
  void onInit() {
    selectedDates = DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(days: 1)));
    guests = 1;
    rooms = 1;
    days = 1;
    notifyListeners();
  }

  // =========>>>>>  TO SELECT DATE RANGE  <<<<<=========
  DateTimeRange selectedDates = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().add(
      const Duration(days: 1),
    ),
  );
  Future<void> selectDate(BuildContext ctx, int amount) async {
    selectedDates = await showDateRangePicker(
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDateRange: selectedDates,
          context: ctx,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 30)),
          confirmText: 'Confirm',
          cancelText: 'Cancel',
        ) ??
        selectedDates;
    daysBetween(selectedDates.start, selectedDates.end);
    totalAmount(amount);
    notifyListeners();
  }

  // =========>>>>>  TO INCREMENT ROOM COUNT  <<<<<=========
  void roomCountPlus() {
    if (rooms < 10) {
      rooms++;
      if (guests < rooms) {
        guests++;
      }
    } else {
      ShowDialogs.popUp('10 rooms are alloweded at a time !!',
          color: Colors.black87);
    }
    notifyListeners();
  }

  // ==========>>>>>  TO DECREMENT ROOM COUNT  <<<<<==========
  void roomCountMinus() {
    if (rooms > 1) {
      rooms--;
      if (guests > rooms * 2) {
        guests = guests - 2;
      }
    } else {
      ShowDialogs.popUp('At least one room is needed !!',
          color: Colors.black87);
    }
    notifyListeners();
  }

  // ==========>>>>>  TO INCCREMENT GUEST COUNT  <<<<<==========
  void guestCountPlus() {
    if (guests < rooms * 2) {
      guests++;
    } else {
      ShowDialogs.popUp('Only two guests are allowed in a room!!',
          color: Colors.black87);
    }
    notifyListeners();
  }

  // ==========>>>>>  TO DECREMENT GUEST COUNT  <<<<<==========
  void guestCountMinus() {
    if (guests > 1) {
      guests--;
      if (rooms > guests) {
        rooms--;
      }
    } else {
      ShowDialogs.popUp(
        'At least one guest is needed !!',
        color: Colors.black87,
      );
    }
    notifyListeners();
  }

  // ==========>>>>>  TO GET TOTAL DAYS  <<<<<==========
  void daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    final totalDays = (to.difference(from).inHours / 24).round();
    days = totalDays;
    notifyListeners();
  }

  // ==========>>>>>  TO GET TOTAL AMOUNT TO BE PAID  <<<<<==========
  int totalAmount(int amount) {
    final int total = rooms * days * amount;
    this.amount = total;
    return total;
  }

  // ==========>>>>>  BOTTOM SHEET TO SELECT DATE, ROOMS AND GUESTS  <<<<<==========
  void selectRoomsAndGuests(double height, int amount, AllRoomsModel hotel) {
    showModalBottomSheet<RoomsAndGuestsBottomSheet>(
      enableDrag: false,
      isDismissible: false,
      backgroundColor: Colors.white,
      context: scaffoldKey.currentState!.context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      )),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (_) {
        return SizedBox(
          height: height,
          child: Scaffold(
            body: RoomsAndGuestsBottomSheet(
              amount: amount,
              hotel: hotel,
            ),
          ),
        );
      },
    );
  }

  // ==========>>>>>  FAVORITE BUTTON  <<<<<==========
  final Icon notFavIcon = Icon(
    Icons.favorite_border,
    size: 32,
    color: Colors.grey.shade600,
  );
  final Icon favIcon = const Icon(
    Icons.favorite_outlined,
    color: KColors.kRedColor,
    size: 32,
  );
  bool _isFav = false;
  bool get isFav => _isFav;
  set isFav(value) {
    _isFav = value;
    notifyListeners();
  }

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
        color: Colors.black87,
      );
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

  // =========>>>>>  ON BOOK_NOW BUTTON  <<<<<==========
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

  // =========>>>>>  ON PAYMENT SUCCESS  <<<<<==========
  void _handlerPaymentSuccess(PaymentSuccessResponse response) async {
    await _completeBooking(
      paymentType: 'ONLINE',
      signature: response.signature,
      payId: response.paymentId,
      odrId: response.orderId,
    );
    razorPay.clear();
  }

  // =========>>>>>  ON PAYMENT FAILURE  <<<<<==========
  void _handlerErrorFailure(PaymentFailureResponse response) {
    ShowDialogs.popUp('Payment failed !!');
    razorPay.clear();
  }

  // =========>>>>>  TO HANDLE EXTERNAL WALLETS  <<<<<==========
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
      ),
    );
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
      ),
    );
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
