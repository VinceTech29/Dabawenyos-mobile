class JobListing {
  final String id;
  final String title;
  final String company;
  final String type; // Full-time, Part-time, Government, Contract
  final String salary;
  final String location;
  final String posted;
  final String description;
  final List<String> qualifications;
  final bool isSaved;

  const JobListing({
    required this.id,
    required this.title,
    required this.company,
    required this.type,
    required this.salary,
    required this.location,
    required this.posted,
    required this.description,
    required this.qualifications,
    this.isSaved = false,
  });

  JobListing copyWith({
    String? id,
    String? title,
    String? company,
    String? type,
    String? salary,
    String? location,
    String? posted,
    String? description,
    List<String>? qualifications,
    bool? isSaved,
  }) {
    return JobListing(
      id: id ?? this.id,
      title: title ?? this.title,
      company: company ?? this.company,
      type: type ?? this.type,
      salary: salary ?? this.salary,
      location: location ?? this.location,
      posted: posted ?? this.posted,
      description: description ?? this.description,
      qualifications: qualifications ?? this.qualifications,
      isSaved: isSaved ?? this.isSaved,
    );
  }
}

class MarketplaceListing {
  final String id;
  final String title;
  final double price;
  final String priceFormatted;
  final String seller;
  final String barangay;
  final String category;
  final String imageUrl;
  final String description;
  final String posted;
  final bool isFavorite;

  const MarketplaceListing({
    required this.id,
    required this.title,
    required this.price,
    required this.priceFormatted,
    required this.seller,
    required this.barangay,
    required this.category,
    required this.imageUrl,
    required this.description,
    required this.posted,
    this.isFavorite = false,
  });

  MarketplaceListing copyWith({
    String? id,
    String? title,
    double? price,
    String? priceFormatted,
    String? seller,
    String? barangay,
    String? category,
    String? imageUrl,
    String? description,
    String? posted,
    bool? isFavorite,
  }) {
    return MarketplaceListing(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      priceFormatted: priceFormatted ?? this.priceFormatted,
      seller: seller ?? this.seller,
      barangay: barangay ?? this.barangay,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      posted: posted ?? this.posted,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

class GovOffice {
  final String id;
  final String name;
  final String department;
  final String address;
  final String hours;
  final String contact;
  final List<String> services;

  const GovOffice({
    required this.id,
    required this.name,
    required this.department,
    required this.address,
    required this.hours,
    required this.contact,
    required this.services,
  });
}

class TrafficUpdate {
  final String id;
  final String location;
  final String status; // closed, heavy, moderate, clear
  final String detail;
  final String time;

  const TrafficUpdate({
    required this.id,
    required this.location,
    required this.status,
    required this.detail,
    required this.time,
  });
}

class FloodReport {
  final String id;
  final String barangay;
  final String level; // passable, knee, waist, impassable
  final String street;
  final String reporter;
  final String time;

  const FloodReport({
    required this.id,
    required this.barangay,
    required this.level,
    required this.street,
    required this.reporter,
    required this.time,
  });
}
