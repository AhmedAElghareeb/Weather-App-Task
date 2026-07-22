import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/src/core/utils/app_spaces.dart';

import '../../cubit/weather_cubit.dart';

/// The main UI body for the Weather feature.
/// Utilizes a StatefulWidget to manage the TextEditingController lifecycle locally.
class WeatherBody extends StatefulWidget {
  const WeatherBody({super.key});

  @override
  State<WeatherBody> createState() => _WeatherBodyState();
}

class _WeatherBodyState extends State<WeatherBody> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    // Always dispose controllers to avoid memory leaks
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        // Determine the background gradient based on whether it is day or night.
        // Fallback to a default daytime gradient if data is not yet loaded.
        final isDay = state.weatherData?.current.isDay == 1;
        final hasData = state.status == WeatherStatus.loaded;

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.transparent,
            systemNavigationBarIconBrightness: Brightness.light,
          ),
          child: Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            // Immersive design: no AppBar, filling the screen with the gradient background.
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: (hasData && !isDay)
                      ? [
                          const Color(0xFF1A1A2E),
                          const Color(0xFF16213E),
                        ] // Night gradient
                      : [const Color(0xFF4A90E2), const Color(0xFF50E3C2)],
                  // Day gradient
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  AppSpaces.verticalSpace7,
                  _buildSearchBar(context, state),
                  Expanded(child: _buildContent(context, state)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Builds the top search bar allowing users to input a city name.
  Widget _buildSearchBar(BuildContext context, WeatherState state) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: TextField(
        controller: _searchController,
        style: const TextStyle(color: Colors.white),
        // Trigger search when the user hits 'Enter' or 'Search' on keyboard.
        onSubmitted: (value) => _performSearch(context, value),
        textInputAction: TextInputAction.search,
        onTapOutside: (ev) => FocusManager.instance.primaryFocus?.unfocus(),
        decoration: InputDecoration(
          hintText: 'weather.searchCity'.tr(),
          hintStyle: TextStyle(color: Colors.white70, fontSize: 14.sp),
          filled: true,
          fillColor: Colors.white.withValues(alpha: 0.2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 14.h,
          ),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_searchController.text.isNotEmpty ||
                  state.status != WeatherStatus.initial)
                IconButton(
                  icon: const Icon(Icons.clear, color: Colors.white70),
                  onPressed: () {
                    _searchController.clear();
                    WeatherCubit.get(context).resetWeather();
                    setState(() {});
                  },
                ),
              IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: () =>
                    _performSearch(context, _searchController.text),
              ),
            ],
          ),
          alignLabelWithHint: true,
        ),
      ),
    );
  }

  /// Centralized method to trigger a weather search.
  void _performSearch(BuildContext context, String query) {
    if (query.trim().isNotEmpty) {
      // Hide the keyboard
      FocusScope.of(context).unfocus();
      WeatherCubit.get(context).searchWeather(query);
    }
  }

  /// Builds the main content area based on the current [WeatherState].
  Widget _buildContent(BuildContext context, WeatherState state) {
    switch (state.status) {
      case WeatherStatus.initial:
        return Center(
          child: Text(
            'weather.searchPrompt'.tr(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      case WeatherStatus.loading:
        return const Center(
          child: CircularProgressIndicator(color: Colors.white),
        );
      case WeatherStatus.error:
        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, color: Colors.white, size: 48.sp),
                SizedBox(height: 16.h),
                Text(
                  state.message,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
                SizedBox(height: 16.h),
                ElevatedButton.icon(
                  onPressed: () =>
                      _performSearch(context, _searchController.text),
                  icon: const Icon(Icons.refresh),
                  label: Text('weather.retryButton'.tr()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withValues(alpha: 0.3),
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      case WeatherStatus.loaded:
        return _buildWeatherCard(state);
    }
  }

  /// Builds the glassmorphism weather card displaying the [WeatherModel] data.
  Widget _buildWeatherCard(WeatherState state) {
    final data = state.weatherData!;
    final current = data.current;
    final location = data.location;

    // Ensure the icon URL is properly formed. The API returns //cdn.weatherapi.com/...
    String iconUrl = current.condition.icon;
    if (iconUrl.startsWith('//')) {
      iconUrl = 'https:$iconUrl';
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            // Display an offline banner if data is loaded from cache
            if (state.isOffline)
              Container(
                margin: EdgeInsets.only(bottom: 16.h),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.redAccent.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.wifi_off, color: Colors.white, size: 16.sp),
                    SizedBox(width: 8.w),
                    Text(
                      'weather.offlineMessage'.tr(),
                      style: TextStyle(color: Colors.white, fontSize: 12.sp),
                    ),
                  ],
                ),
              ),

            // Glassmorphism card effect using ClipRRect and BackdropFilter
            ClipRRect(
              borderRadius: BorderRadius.circular(24.r),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(24.r),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.3),
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    children: [
                      // Location Info
                      Text(
                        '${location.name}, ${location.country}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '${location.region.isNotEmpty ? '${location.region} • ' : ''}${location.localtime}',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14.sp,
                        ),
                      ),

                      SizedBox(height: 24.h),

                      // Weather Icon and Condition
                      if (iconUrl.isNotEmpty)
                        Image.network(
                          iconUrl,
                          width: 80.w,
                          height: 80.w,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.cloud,
                            color: Colors.white,
                            size: 60.sp,
                          ),
                        ),

                      // Temperature
                      Text(
                        '${current.tempC.round()}°C',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 64.sp,
                          fontWeight: FontWeight.w300,
                        ),
                      ),

                      // Condition Text
                      Text(
                        current.condition.text,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '${'weather.feelsLike'.tr()} ${current.feelslikeC.round()}°C',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14.sp,
                        ),
                      ),

                      SizedBox(height: 24.h),
                      Divider(
                        color: Colors.white.withValues(alpha: 0.3),
                        thickness: 1,
                      ),
                      SizedBox(height: 24.h),

                      // Detailed Info Grid
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildDetailItem(
                            Icons.air,
                            'weather.wind'.tr(),
                            '${current.windKph} ${'weather.km/h'.tr()}',
                          ),
                          _buildDetailItem(
                            Icons.water_drop_outlined,
                            'weather.humidity'.tr(),
                            '${current.humidity}%',
                          ),
                          _buildDetailItem(
                            Icons.speed,
                            'weather.pressure'.tr(),
                            '${current.pressureMb} ${'weather.hPa'.tr()}',
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildDetailItem(
                            Icons.visibility_outlined,
                            'weather.visibility'.tr(),
                            '${current.visKm} ${'weather.km'.tr()}',
                          ),
                          _buildDetailItem(
                            Icons.wb_sunny_outlined,
                            'weather.uvIndex'.tr(),
                            '${current.uv}',
                          ),
                          _buildDetailItem(
                            Icons.cloud_outlined,
                            'weather.cloud'.tr(),
                            '${current.cloud}%',
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),
                      Divider(
                        color: Colors.white.withValues(alpha: 0.3),
                        thickness: 1,
                      ),
                      SizedBox(height: 16.h),
                      TextButton.icon(
                        onPressed: () {
                          _searchController.clear();
                          WeatherCubit.get(context).resetWeather();
                          setState(() {});
                        },
                        icon: const Icon(Icons.refresh, color: Colors.white),
                        label: Text(
                          'weather.resetSearch'.tr(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white.withValues(alpha: 0.15),
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                            vertical: 12.h,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Reusable widget for building individual detailed weather data items.
  Widget _buildDetailItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.white70, size: 24.sp),
        SizedBox(height: 8.h),
        Text(
          label,
          style: TextStyle(color: Colors.white70, fontSize: 12.sp),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
