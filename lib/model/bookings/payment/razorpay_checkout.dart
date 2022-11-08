class RazorpayCheckoutModel {
    RazorpayCheckoutModel({
        this.key,
        this.amount,
        this.currency,
        this.name,
        this.description,
        this.image,
        this.orderId,
        this.prefill,
    });

    String? key;
    String? amount;
    String? currency;
    String? name;
    String? description;
    String? image;
    String? orderId;
    Prefill? prefill;

    Map<String, dynamic> toJson() => {
        "key": key,
        "amount": amount,
        "currency": currency,
        "name": name,
        "description": description,
        "image": image,
        "order_id": orderId,
        "prefill": prefill?.toJson(),
    };
}

class Prefill {
    Prefill({
        this.name,
        this.email,
        this.contact,
    });

    String? name;
    String? email;
    String? contact;

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "contact": contact,
    };
}
