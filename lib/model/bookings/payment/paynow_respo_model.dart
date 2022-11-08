class PayNowResponseModel {
    PayNowResponseModel({
        this.id,
        this.currency,
        this.amount,
        this.receipt,
        this.keyId,
        this.message
    });

    String? id;
    String? currency;
    int? amount;
    String? receipt;
    String? keyId;
    String? message;

    factory PayNowResponseModel.fromJson(Map<String, dynamic> json) => PayNowResponseModel(
        id: json["id"],
        currency: json["currency"],
        amount: json["amount"],
        receipt: json["receipt"],
        keyId: json["key_id"],
    );
}
