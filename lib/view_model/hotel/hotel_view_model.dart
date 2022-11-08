import 'dart:developer';
import 'package:dio/dio.dart';
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
import 'package:premio_inn/services/dio/interceptor.dart'; 
import 'package:premio_inn/utils/colors.dart';
import 'package:premio_inn/utils/navigations.dart';
import 'package:premio_inn/utils/url.dart';
import 'package:premio_inn/view/screens/hotel_view/widgets/bottom_sheet.dart';
import 'package:premio_inn/view/screens/main_page/main_page.dart';
import 'package:premio_inn/view/widgets/show_dialogs.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class HotelViewModel extends ChangeNotifier {
  // -->> initial values
  void onInit() {
    selectedDates = DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(days: 1)));
    guests = 1;
    rooms = 1;
    days = 1;
    notifyListeners();
  }

  // -->> vaiables
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  DateTimeRange selectedDates = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().add(
      const Duration(days: 1),
    ),
  );
  int guests = 1;
  int rooms = 1;
  int days = 1;
  int amount = 0;
  final Icon notFavIcon = Icon(
    Icons.favorite_border,
    size: 32,
    color: Colors.grey.shade600,
  );
  final Icon favIcon =
      const Icon(Icons.favorite_outlined, color: KColors.kRedColor, size: 32);
  final PageController pController = PageController();

  // -->> function to select date range
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

  // -->> function to room count ++
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

  // -->> function to room count --
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

  // -->> function to guest count ++
  void guestCountPlus() {
    if (guests < rooms * 2) {
      guests++;
    } else {
      ShowDialogs.popUp('Only two guests are allowed in a room!!',
          color: Colors.black87);
    }
    notifyListeners();
  }

  // -->> function to guest count --
  void guestCountMinus() {
    if (guests > 1) {
      guests--;
      if (rooms > guests) {
        rooms--;
      }
    } else {
      ShowDialogs.popUp('At least one guest is needed !!',
          color: Colors.black87);
    }
    notifyListeners();
  }

  // -->> function to get the total days selected
  void daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    final totalDays = (to.difference(from).inHours / 24).round();
    days = totalDays;
    notifyListeners();
  }

  // -->> function to get the total amount to be paid
  int totalAmount(int amount) {
    final int total = rooms * days * amount;
    this.amount = amount;
    return total;
  }

  // -->> to get bottom sheet
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
            )));
      },
    );
  }

  // -->> add to favorite bool
  bool _isFav = false;
  get isFav => _isFav;
  set isFav(value) {
    _isFav = value;
    notifyListeners();
  }

    // variables
  bool isLoading = false;
  // -->> function to check is room available or not
  Future<bool> isRoomAvailable(
      DateTimeRange dateRange, String hotelId, int rooms) async {
    isLoading = true;
    notifyListeners();
    final data = RoomAvailabiltyRequestModel(
      dateTimeRange: dateRange,
      hotelId: hotelId,
      numberOfRooms: rooms,
    );
    final RoomAvailabilityResponseModel? isRoomAvailableResponse= await RoomAvailabilityService().isRoomAvailabileService(data);
    if(isRoomAvailableResponse==null){
      isLoading = false;
      notifyListeners();
      ShowDialogs.popUp('Something went wrong !!');
      return false;  
    }else if (isRoomAvailableResponse.isAvailable==false) {
      isLoading = false;
      notifyListeners();
      ShowDialogs.popUp(isRoomAvailableResponse.message??'Rooms are not available on the selected range. Please try with other dates.',color: Colors.black87);
      return false;  
    }else if (isRoomAvailableResponse.isAvailable==true) {
      isLoading = false;
      notifyListeners();
      return true;  
    }else{
      isLoading = false;
      notifyListeners();
      ShowDialogs.popUp(isRoomAvailableResponse.message??'Something went wrong !!');
      return false;  
    }
  }

    Future<String> getBookingId(String hotelId, int rooms) async {
    isLoading = true;
    notifyListeners();
    final data = BookingRequestModel(
      hotelId: hotelId,
      rooms: rooms,
    );
    final BookingResponseModel? bookingResponse= await BookingService().bookingService(data);
    if(bookingResponse==null){
      isLoading = false;
      notifyListeners();
      ShowDialogs.popUp('Something went wrong !!');
      return '';  
    }else if (bookingResponse.success==false) {
      isLoading = false;
      notifyListeners();
      ShowDialogs.popUp(bookingResponse.message??'Rooms are not available on the selected range. Please try with other dates.',color: Colors.black87);
      return '';  
    }else if (bookingResponse.success==true) {
      isLoading = false;
      notifyListeners();
      return bookingResponse.response?.room??'';  
    }else{
      isLoading = false;
      notifyListeners();
      ShowDialogs.popUp(bookingResponse.message??'Something went wrong !!');
      return '';  
    }
  }



  // ==================== BOOKING SECTION ====================
  late Razorpay razorPay;
  HotelViewModel() {
    razorPay = Razorpay();
    razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  void disposes() {
    razorPay.clear();
  }

  void handlerPaymentSuccess(PaymentSuccessResponse response) {
    Navigations.pushRemoveUntil(const MainPage());
    log('Payment success==============');
  }

  void handlerErrorFailure(PaymentFailureResponse response) {
    log('Payment error');
  }

  void handlerExternalWallet(ExternalWalletResponse response) {
    log('handlerExternalWallet');
  }

  // -->> function to pay online
  Future<void> onPayNowButton(int amount)async {
    final PayNowResponseModel? response = await getOnlinePaymentData(amount);
    if(response==null){
      ShowDialogs.popUp('Oops!! Something went wrong. Please try again later');
      return;
    }
    //final Map<String, dynamic> options = {
      // "key": Url.razorKey,
      // "amount": response.amount,

      // "name": "Hotella",
      // "description": "Payment to book your selected room via Hotella",
      // "prefill": {"contact": "9744875629", "email": "sinanac124@gmail.com"},
      // "external": {
      //   "wallets": ["paytm"]
      // }
   //};
    RazorpayCheckoutModel options = RazorpayCheckoutModel(
      key: response.keyId,
      amount: response.amount.toString(),
      currency: "INR",
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


   // ===========================  ================================
    bool isPaynowLoading = false;
      Future<PayNowResponseModel?> getOnlinePaymentData(int amount) async {
    isPaynowLoading = true;
    notifyListeners();
    final PayNowResponseModel? response= await PayNowService().payNowService(amount);
    if(response==null){
      isPaynowLoading = false;
      notifyListeners();
      ShowDialogs.popUp('Something went wrong !!');
      return null;  
    }else if (response.id !=null) {
      isPaynowLoading = false;
      notifyListeners();
      return response;  
    }else{
      isPaynowLoading = false;
      notifyListeners();
      ShowDialogs.popUp(response.message??'Something went wrong !!');
      return null;  
    }
  }

  // -->> function to pay at hotel
  void onPayAtHotelButton() {}
}
