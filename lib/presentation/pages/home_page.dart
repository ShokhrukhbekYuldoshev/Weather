import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:weather_service/cubit/home/home_cubit.dart';
import 'package:weather_service/data/models/weather.dart';
import 'package:weather_service/presentation/utils/assets.dart';
import 'package:weather_service/presentation/utils/colors.dart';
import 'package:weather_service/presentation/utils/extensions.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Weather _weather;
  static const String _weatherBoxName = 'myBox';
  static const String _weatherKey = 'weather';

  @override
  void initState() {
    super.initState();
    _loadCachedWeather();
    context.read<HomeCubit>().getWeatherByLocation();
  }

  void _loadCachedWeather() {
    try {
      final weather = Hive.box(_weatherBoxName).get(_weatherKey);
      if (weather != null && weather is Weather) {
        _weather = weather;
      } else {
        _weather = Weather.empty();
      }
    } catch (e) {
      _weather = Weather.empty();
    }
  }

  String _getWeatherImage({
    required int weatherId,
    required bool isDay,
    required bool isBig,
  }) {
    // Group weather conditions by ranges for cleaner logic
    switch (weatherId ~/ 100) {
      case 2: // Thunderstorm (200-299)
        return isBig ? PngAsset.thunderstormBig : PngAsset.thunderstormSmall;
      case 3: // Drizzle (300-399)
        return isBig ? PngAsset.drizzleBig : PngAsset.drizzleSmall;
      case 5: // Rain (500-599)
        return isBig ? PngAsset.rainBig : PngAsset.drizzleSmall;
      case 6: // Snow (600-699)
        return isBig ? PngAsset.snowBig : PngAsset.snowSmall;
      case 8: // Clear or clouds (800-899)
        if (weatherId == 800) {
          return isBig ? PngAsset.clearSkyBig : PngAsset.clearSkySmall;
        } else if (weatherId > 800) {
          return isBig
              ? PngAsset.fewCloudsBig
              : (isDay
                    ? PngAsset.fewCloudsDaySmall
                    : PngAsset.fewCloudsNightSmall);
        }
        break;
    }

    return PngAsset.clearSkySmall;
  }

  String _getMinMaxTemp(Weather weather) {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final todayTemps = weather.list
        .where((e) => e.dtTxt.contains(today))
        .toList();

    if (todayTemps.isEmpty) return 'Max: --º Min: --º';

    final maxTemp = todayTemps
        .map((e) => e.main.tempMax)
        .reduce((value, element) => value > element ? value : element);
    final minTemp = todayTemps
        .map((e) => e.main.tempMin)
        .reduce((value, element) => value < element ? value : element);

    return 'Max: ${maxTemp.toStringAsFixed(0)}º Min: ${minTemp.toStringAsFixed(0)}º';
  }

  String _getFormattedDate(String dateTime) {
    const months = {
      '01': 'January',
      '02': 'February',
      '03': 'March',
      '04': 'April',
      '05': 'May',
      '06': 'June',
      '07': 'July',
      '08': 'August',
      '09': 'September',
      '10': 'October',
      '11': 'November',
      '12': 'December',
    };

    try {
      final dateParts = dateTime.split('-');
      final day = dateParts[2].split(' ')[0];
      final month = months[dateParts[1]];
      return '$day $month';
    } catch (e) {
      return 'Invalid date';
    }
  }

  String _getHumidityDescription(int humidity) {
    if (humidity < 30) return 'Dry';
    if (humidity < 60) return 'Comfortable';
    return 'Humid';
  }

  String _getWindDescription(int windDeg) {
    const directions = ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW'];
    final index = ((windDeg + 22.5) ~/ 45) % 8;
    return 'Wind direction: ${directions[index]}';
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? errorColor : null,
        duration: isError
            ? const Duration(seconds: 3)
            : const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        switch (state) {
          case HomeFailure():
            _showSnackBar(state.message, isError: true);
          case HomeLoaded():
            setState(() {
              _weather = state.weather;
            });
            _showSnackBar('Weather updated successfully!');
          case HomeLoading():
            _showSnackBar('Loading weather data...');
          default:
            break;
        }
      },
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final isLoading = state is HomeLoading && _weather.list.isEmpty;

          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              constraints: const BoxConstraints.expand(),
              padding: EdgeInsets.fromLTRB(
                24,
                MediaQuery.of(context).padding.top + 16,
                24,
                24,
              ),
              decoration: BoxDecoration(gradient: primaryLightGradient),
              child: _buildBody(isLoading, state),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(bool isLoading, HomeState state) {
    if (isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: whiteColor),
            SizedBox(height: 16),
            Text(
              'Loading weather...',
              style: TextStyle(color: whiteColor, fontSize: 16),
            ),
          ],
        ),
      );
    }

    if (_weather.list.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No weather data available',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: whiteColor,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Pull down to refresh',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: whiteColor,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<HomeCubit>().getWeatherByLocation();
      },
      color: whiteColor,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            _buildLocationHeader(),
            const SizedBox(height: 15),
            _buildWeatherIcon(),
            const SizedBox(height: 15),
            _buildTemperatureDisplay(),
            const SizedBox(height: 24),
            _buildHourlyForecast(),
            const SizedBox(height: 24),
            _buildWeatherDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationHeader() {
    return Row(
      children: [
        SvgPicture.asset(SvgAsset.pin),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            '${_weather.city.name}, ${_weather.city.country}',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: whiteColor,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildWeatherIcon() {
    return Container(
      height: 200,
      width: 200,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(color: shadowColor, blurRadius: 100, offset: Offset(0, 5)),
        ],
      ),
      child: Image.asset(
        _getWeatherImage(
          weatherId: _weather.list.first.weather.first.id,
          isBig: true,
          isDay: _weather.list.first.sys.pod == 'd',
        ),
      ),
    );
  }

  Widget _buildTemperatureDisplay() {
    return Column(
      children: [
        Text(
          '${_weather.list.first.main.temp.toStringAsFixed(0)}º',
          style: const TextStyle(
            color: whiteColor,
            fontSize: 64,
            fontFamily: 'Ubuntu',
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          _weather.list.first.weather.first.description.capitalize(),
          style: const TextStyle(
            color: whiteColor,
            fontSize: 17,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _getMinMaxTemp(_weather),
          style: const TextStyle(
            color: whiteColor,
            fontSize: 17,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildHourlyForecast() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: whiteColor.withOpacity(0.2),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16),
      height: 230,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Today',
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  _getFormattedDate(_weather.list.first.dtTxt),
                  style: const TextStyle(
                    color: whiteColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Divider(color: whiteColor, thickness: 1, height: 1),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _weather.list.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                final forecast = _weather.list[index];
                return Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: index == 0
                        ? whiteColor.withOpacity(0.2)
                        : Colors.transparent,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat(
                          'HH:mm',
                        ).format(DateTime.parse(forecast.dtTxt)),
                        style: const TextStyle(
                          color: whiteColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Image.asset(
                        _getWeatherImage(
                          weatherId: forecast.weather.first.id,
                          isDay: forecast.sys.pod == 'd',
                          isBig: false,
                        ),
                        width: 32,
                        height: 32,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${forecast.main.temp.toStringAsFixed(0)}º',
                        style: const TextStyle(
                          color: whiteColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherDetails() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: whiteColor.withOpacity(0.2),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildDetailRow(
            icon: SvgAsset.drop,
            value: '${_weather.list.first.main.humidity}%',
            description: _getHumidityDescription(
              _weather.list.first.main.humidity,
            ),
          ),
          const SizedBox(height: 16),
          _buildDetailRow(
            icon: SvgAsset.wind,
            value: '${_weather.list.first.wind.speed} m/s',
            description: _getWindDescription(_weather.list.first.wind.deg),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required String icon,
    required String value,
    required String description,
  }) {
    return Row(
      children: [
        SvgPicture.asset(icon),
        const SizedBox(width: 8),
        Text(
          value,
          style: const TextStyle(
            color: whiteColor,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        Text(
          description,
          style: const TextStyle(
            color: whiteColor,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
