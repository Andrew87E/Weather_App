import 'package:collection/collection.dart';

class FeelsLike {
	double? day;
	double? night;
	double? eve;
	double? morn;

	FeelsLike({this.day, this.night, this.eve, this.morn});

	factory FeelsLike.fromJson(Map<String, dynamic> json) => FeelsLike(
				day: (json['day'] as num?)?.toDouble(),
				night: (json['night'] as num?)?.toDouble(),
				eve: (json['eve'] as num?)?.toDouble(),
				morn: (json['morn'] as num?)?.toDouble(),
			);

	Map<String, dynamic> toJson() => {
				'day': day,
				'night': night,
				'eve': eve,
				'morn': morn,
			};

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! FeelsLike) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toJson(), toJson());
	}

	@override
	int get hashCode =>
			day.hashCode ^
			night.hashCode ^
			eve.hashCode ^
			morn.hashCode;
}
