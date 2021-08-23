class PushNotificationModel {
  final String push;
  final String title;
  final String messageBody;
  final String businessId;
  final String orderId;
  final String userLoggedId;

  PushNotificationModel({
    required this.push,
    required this.title,
    required this.messageBody,
    required this.businessId,
    required this.orderId,
    required this.userLoggedId
  });

  PushNotificationModel cloneWith({
    push,
    title,
    messageBody,
    businessId,
    orderId,
    userLoggedId
  }){
    return PushNotificationModel(
        push: push ?? this.push,
        title: title ?? this.title,
        messageBody: messageBody ?? this.messageBody,
        businessId: businessId ?? this.businessId,
        orderId: orderId ?? this.orderId,
        userLoggedId: userLoggedId ?? this.userLoggedId
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "push": this.push,
      "title": this.title,
      "messageBody": this.messageBody,
      "businessId": this.businessId,
      "orderId": this.orderId,
      "userLoggedId": this.userLoggedId
    };
  }

}