class Rating {
  final String rideId;
  final String driverId;
  final String customerId;
  final double rating;
  final String comment;
  final DateTime timestamp;

  Rating({
    required this.rideId,
    required this.driverId,
    required this.customerId,
    required this.rating,
    this.comment = "",
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}
