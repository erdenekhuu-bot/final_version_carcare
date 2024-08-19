import 'dart:convert';

// Model for the shop location
class ShopLocation {
  final int id;
  final double longitude;
  final double latitude;
  final String address;
  final String? province;
  final String? city;
  final String? country;
  final String? subProvince;
  final String? street;
  final int shop;

  ShopLocation({
    required this.id,
    required this.longitude,
    required this.latitude,
    required this.address,
    this.province,
    this.city,
    this.country,
    this.subProvince,
    this.street,
    required this.shop,
  });

  factory ShopLocation.fromJson(Map<String, dynamic> json) {
    return ShopLocation(
      id: json['id'],
      longitude: json['longitude'].toDouble(),
      latitude: json['latitude'].toDouble(),
      address: json['address'],
      province: json['province'],
      city: json['city'],
      country: json['country'],
      subProvince: json['sub_province'],
      street: json['street'],
      shop: json['shop'],
    );
  }
}

// Model for the icon asset
class IconAsset {
  final int id;
  final String name;
  final String path;
  final String? imagePath;
  final int fileSize;
  final int fileWidth;
  final int fileHeight;
  final DateTime createdAt;
  final String fileMimetype;

  IconAsset({
    required this.id,
    required this.name,
    required this.path,
    this.imagePath,
    required this.fileSize,
    required this.fileWidth,
    required this.fileHeight,
    required this.createdAt,
    required this.fileMimetype,
  });

  factory IconAsset.fromJson(Map<String, dynamic> json) {
    return IconAsset(
      id: json['id'],
      name: json['name'],
      path: json['path'],
      imagePath: json['image_path'],
      fileSize: json['file_size'],
      fileWidth: json['file_width'],
      fileHeight: json['file_height'],
      createdAt: DateTime.parse(json['created_at']),
      fileMimetype: json['filemimetype'],
    );
  }
}

// Model for shop schedule
class ShopSchedule {
  final int id;
  final int weekDay;
  final DateTime startTime;
  final DateTime endTime;
  final int shop;

  ShopSchedule({
    required this.id,
    required this.weekDay,
    required this.startTime,
    required this.endTime,
    required this.shop,
  });

  factory ShopSchedule.fromJson(Map<String, dynamic> json) {
    return ShopSchedule(
      id: json['id'],
      weekDay: json['week_day'],
      startTime: DateTime.parse(json['start_time']),
      endTime: DateTime.parse(json['end_time']),
      shop: json['shop'],
    );
  }
}

// Main model for shop
class Shop {
  final int id;
  final ShopLocation shopLocation;
  final IconAsset iconAsset;
  final List<ShopSchedule> shopSchedules;
  final String name;
  final String description;
  final String phone;
  final String additional;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String type;
  final String thumbnail;
  final int? parentShopId;
  final int? ratingId;
  final int thumbnailAssetId;

  Shop({
    required this.id,
    required this.shopLocation,
    required this.iconAsset,
    required this.shopSchedules,
    required this.name,
    required this.description,
    required this.phone,
    required this.additional,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
    required this.thumbnail,
    this.parentShopId,
    this.ratingId,
    required this.thumbnailAssetId,
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['id'],
      shopLocation: ShopLocation.fromJson(json['shop_location']),
      iconAsset: IconAsset.fromJson(json['icon_asset']),
      shopSchedules: (json['shop_schedules'] as List)
          .map((i) => ShopSchedule.fromJson(i))
          .toList(),
      name: json['name'],
      description: json['description'],
      phone: json['phone'],
      additional: json['additional'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      type: json['type'],
      thumbnail: json['thumbnail'],
      parentShopId: json['parent_shop_id'],
      ratingId: json['rating_id'],
      thumbnailAssetId: json['thumbnail_asset_id'],
    );
  }
}

// Function to parse JSON data into a list of Shop objects
List<Shop> parseShops(String responseBody) {
  final parsed = jsonDecode(responseBody)['results'].cast<Map<String, dynamic>>();
  return parsed.map<Shop>((json) => Shop.fromJson(json)).toList();
}
