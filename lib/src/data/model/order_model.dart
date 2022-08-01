class OrderModel {
  const OrderModel(
    this.receiverName,
    this.receiverPhone,
    this.receiverAddress,
  );

  // A function taking a BuildContext as input and
  // returns the internationalized name of the category.
  final String receiverName;
  final String receiverPhone;
  final String receiverAddress;
}
