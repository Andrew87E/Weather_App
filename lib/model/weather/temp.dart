import 'package:collection/collection.dart';

class Temp {
	double? day;
	double? min;
	double? max;
	double? night;
	double? eve;
	double? morn;

	Temp({this.day, this.min, this.max, this.night, this.eve, this.morn});

	factory Temp.fromJson(Map<String, dynamic> json) => Temp(
				day: (json['day'] as num?)?.toDouble(),
				min: (json['min'] as num?)?.toDouble(),
				max: (json['max'] as num?)?.toDouble(),
				night: (json['night'] as num?)?.toDouble(),
				eve: (json['eve'] as num?)?.toDouble(),
				morn: (json['morn'] as num?)?.toDouble(),
			);

	Map<String, dynamic> toJson() => {
				'day': day,
				'min': min,
				'max': max,
				'night': night,
				'eve': eve,
				'morn': morn,
			};

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! Temp) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toJson(), toJson());
	}

	@override
	int get hashCode =>
			day.hashCode ^
			min.hashCode ^
			max.hashCode ^
			night.hashCode ^
			eve.hashCode ^
			morn.hashCode;
}
