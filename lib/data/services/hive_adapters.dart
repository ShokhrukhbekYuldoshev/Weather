import 'package:hive/hive.dart';
import 'package:weather_service/data/models/city.dart';
import 'package:weather_service/data/models/clouds.dart';
import 'package:weather_service/data/models/coord.dart';
import 'package:weather_service/data/models/main_data.dart';
import 'package:weather_service/data/models/sys.dart';
import 'package:weather_service/data/models/weather.dart';
import 'package:weather_service/data/models/weather_data.dart';
import 'package:weather_service/data/models/weather_description.dart';
import 'package:weather_service/data/models/wind.dart';

// register adapters
void registerHiveAdapters() {
  Hive.registerAdapter(CityAdapter());
  Hive.registerAdapter(CloudsAdapter());
  Hive.registerAdapter(CoordAdapter());
  Hive.registerAdapter(MainDataAdapter());
  Hive.registerAdapter(SysAdapter());
  Hive.registerAdapter(WeatherAdapter());
  Hive.registerAdapter(WeatherDataAdapter());
  Hive.registerAdapter(WeatherDescriptionAdapter());
  Hive.registerAdapter(WindAdapter());
}

class CityAdapter extends TypeAdapter<City> {
  @override
  final typeId = 0;

  @override
  City read(BinaryReader reader) {
    return City(
      id: reader.readInt(),
      name: reader.readString(),
      coord: reader.read() as Coord,
      country: reader.readString(),
      population: reader.readInt(),
      timezone: reader.readInt(),
      sunrise: reader.readInt(),
      sunset: reader.readInt(),
    );
  }

  @override
  void write(BinaryWriter writer, City obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.name);
    writer.write(obj.coord);
    writer.writeString(obj.country);
    writer.writeInt(obj.population);
    writer.writeInt(obj.timezone);
    writer.writeInt(obj.sunrise);
    writer.writeInt(obj.sunset);
  }
}

class CloudsAdapter extends TypeAdapter<Clouds> {
  @override
  final typeId = 1;

  @override
  Clouds read(BinaryReader reader) {
    return Clouds(
      all: reader.readInt(),
    );
  }

  @override
  void write(BinaryWriter writer, Clouds obj) {
    writer.writeInt(obj.all);
  }
}

class CoordAdapter extends TypeAdapter<Coord> {
  @override
  final typeId = 2;

  @override
  Coord read(BinaryReader reader) {
    return Coord(
      lon: reader.readDouble(),
      lat: reader.readDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, Coord obj) {
    writer.writeDouble(obj.lon);
    writer.writeDouble(obj.lat);
  }
}

class MainDataAdapter extends TypeAdapter<MainData> {
  @override
  final typeId = 3;

  @override
  MainData read(BinaryReader reader) {
    return MainData(
      temp: reader.readDouble(),
      feelsLike: reader.readDouble(),
      tempMin: reader.readDouble(),
      tempMax: reader.readDouble(),
      pressure: reader.readInt(),
      seaLevel: reader.readInt(),
      grndLevel: reader.readInt(),
      humidity: reader.readInt(),
      tempKf: reader.readDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, MainData obj) {
    writer.writeDouble(obj.temp);
    writer.writeDouble(obj.feelsLike);
    writer.writeDouble(obj.tempMin);
    writer.writeDouble(obj.tempMax);
    writer.writeInt(obj.pressure);
    writer.writeInt(obj.seaLevel);
    writer.writeInt(obj.grndLevel);
    writer.writeInt(obj.humidity);
    writer.writeDouble(obj.tempKf);
  }
}

class SysAdapter extends TypeAdapter<Sys> {
  @override
  final typeId = 4;

  @override
  Sys read(BinaryReader reader) {
    return Sys(
      pod: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, Sys obj) {
    writer.writeString(obj.pod);
  }
}

class WeatherAdapter extends TypeAdapter<Weather> {
  @override
  final typeId = 5;

  @override
  Weather read(BinaryReader reader) {
    return Weather(
      cod: reader.readString(),
      message: reader.readInt(),
      cnt: reader.readInt(),
      list: List<WeatherData>.from(reader.read() as List),
      city: reader.read() as City,
    );
  }

  @override
  void write(BinaryWriter writer, Weather obj) {
    writer.writeString(obj.cod);
    writer.writeInt(obj.message);
    writer.writeInt(obj.cnt);
    writer.write(obj.list);
    writer.write(obj.city);
  }
}

class WeatherDataAdapter extends TypeAdapter<WeatherData> {
  @override
  final typeId = 6;

  @override
  WeatherData read(BinaryReader reader) {
    return WeatherData(
      dt: reader.readInt(),
      main: reader.read() as MainData,
      weather: List<WeatherDescription>.from(reader.read() as List),
      clouds: reader.read() as Clouds,
      wind: reader.read() as Wind,
      visibility: reader.readInt(),
      pop: reader.readDouble(),
      sys: reader.read() as Sys,
      dtTxt: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, WeatherData obj) {
    writer.writeInt(obj.dt);
    writer.write(obj.main);
    writer.write(obj.weather);
    writer.write(obj.clouds);
    writer.write(obj.wind);
    writer.writeInt(obj.visibility);
    writer.writeDouble(obj.pop);
    writer.write(obj.sys);
    writer.writeString(obj.dtTxt);
  }
}

class WeatherDescriptionAdapter extends TypeAdapter<WeatherDescription> {
  @override
  final typeId = 7;

  @override
  WeatherDescription read(BinaryReader reader) {
    return WeatherDescription(
      id: reader.readInt(),
      main: reader.readString(),
      description: reader.readString(),
      icon: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, WeatherDescription obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.main);
    writer.writeString(obj.description);
    writer.writeString(obj.icon);
  }
}

class WindAdapter extends TypeAdapter<Wind> {
  @override
  final typeId = 8;

  @override
  Wind read(BinaryReader reader) {
    return Wind(
      speed: reader.readDouble(),
      deg: reader.readInt(),
      gust: reader.readDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, Wind obj) {
    writer.writeDouble(obj.speed);
    writer.writeInt(obj.deg);
    writer.writeDouble(obj.gust);
  }
}
