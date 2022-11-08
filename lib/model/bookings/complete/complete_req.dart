class CompleteBookingRequestModel {
    CompleteBookingRequestModel({
        this.rooms,
        this.checkout,
        this.pay,
    });

    String? rooms;
    String? checkout;
    String? pay;
    String? razorpaymentId;
    String? order;

    Map<String, dynamic> toJson() => {
        "rooms": rooms,
        "checkout": checkout,
        "pay": pay,
        "razorpayment_id": razorpaymentId,
        "order": order,
    };
}
