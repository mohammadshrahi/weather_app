import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:weather_app/core/resource/resource.dart';
import 'package:weather_app/core/utils.dart';
import 'package:weather_app/domain/entities/weather_item.dart';
import 'package:weather_app/presentation/blocs/home/bloc/home_page_bloc.dart';
import 'package:weather_app/presentation/blocs/location/bloc/location_bloc.dart';
import 'package:weather_app/presentation/widgets/app_loading_widget.dart';
import 'package:weather_app/presentation/widgets/degree_text.dart';
import 'package:weather_app/presentation/widgets/horizontal_space.dart';
import 'package:weather_app/presentation/widgets/retry_widget.dart';
import 'package:weather_app/presentation/widgets/vertical_space.dart';
import 'package:weather_app/resources/resources.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const double kVerticalSpace = 20;
  String bgImage = Gifs.cloudBlueG;
  @override
  void didChangeDependencies() {
    BlocProvider.of<LocationBloc>(context).add(LocationGetEvent());
    super.didChangeDependencies();
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SmartRefresher(
        controller: _refreshController,
        onRefresh: () {
          if (BlocProvider.of<LocationBloc>(context).state
              is LocationSuccessState) {
            getWeatherData();
          } else if (BlocProvider.of<LocationBloc>(context).state
              is! LocationSuccessState) {
            BlocProvider.of<LocationBloc>(context).add(LocationGetEvent());
          } else {
            _refreshController.refreshCompleted();
          }
        },
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(bgImage), fit: BoxFit.fill)),
          padding: EdgeInsets.all(16),
          // color: Colors.blue,
          child: _buildLocationWidget(),
        ),
      )),
    );
  }

  Widget _buildLocationWidget() {
    return BlocListener<LocationBloc, LocationState>(
      listener: (context, state) {
        if (state is LocationSuccessState) {
          getWeatherData();
        }
        if (state is LocationFailedState) {
          if (state.failedResource.data is LocationPermission) {
            if (state.failedResource.data == LocationPermission.deniedForever) {
              _openAppSetting();
            }
          }
        }
      },
      child: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          if (state is LocationSuccessState) {
            return _buildHomePageBloc();
          }
          if (state is LocationLoadingState) {
            return AppLoadingWidget();
          } else if (state is LocationInitState) {
            return RetryWidget(
              'Allow Location Access',
              onPressed: () {
                BlocProvider.of<LocationBloc>(context).add(LocationGetEvent());
              },
            );
          } else {
            return RetryWidget(
              'Something went Wrong!please try again',
              onPressed: () {
                BlocProvider.of<LocationBloc>(context).add(LocationGetEvent());
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildHomePageBloc() {
    return BlocListener<HomePageBloc, HomePageState>(
      listener: (context, state) {
        if (state is HomePageSuccessState) {
          _refreshController.refreshCompleted();
          setState(() {
            bgImage = Utils.getBgImage(state.weatherItem.weatherStateAbbr!);
          });
        }
        if (state is HomePageFailedState) {
          _refreshController.refreshCompleted();
        }
      },
      child: BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) {
          if (state is HomePageSuccessState) {
            return _buildWearherWidget(state.weatherList, state.weatherItem);
          } else if (state is HomePageFailedState) {
            return RetryWidget(
              'Something went wrong!please try again',
              onPressed: () {
                getWeatherData();
              },
            );
          } else {
            return const AppLoadingWidget();
          }
        },
      ),
    );
  }

  Column _buildWearherWidget(List<WeatherItem> list, WeatherItem selectedItem) {
    return Column(
      children: [
        Expanded(child: Container(child: _detailsItem(selectedItem))),
        Container(
          height: 120,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return WeatherItemWidget(
                list[index],
                onTap: () {
                  BlocProvider.of<HomePageBloc>(context)
                      .add(HomePageWeatherSelect(list[index], index));
                },
              );
            },
            itemCount: list.length,
            scrollDirection: Axis.horizontal,
          ),
        )
      ],
    );
  }

  Widget _detailsItem(WeatherItem weatherItem) {
    return Flex(
      direction: MediaQuery.of(context).orientation == Orientation.portrait
          ? Axis.vertical
          : Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    (BlocProvider.of<LocationBloc>(context).state
                                as LocationSuccessState)
                            .successResource
                            .data
                            .title ??
                        '',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  const VerticalSpace(kVerticalSpace),
                  Row(
                    children: [
                      Text(
                        weatherItem.weatherStateName ?? '',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      HorizontalSpace(3),
                      SvgPicture.network(
                          Utils.getAssetsLink(weatherItem.weatherStateAbbr!))
                    ],
                  ),
                  DegreeText(
                    weatherItem.getTemp(),
                    style: Theme.of(context)
                        .textTheme
                        .headline2
                        ?.copyWith(fontSize: 100),
                    degreeSize: 20,
                  ),
                  Text(
                    AppDateUtils.fromYYYYMMdd(weatherItem.applicableDate!)
                        .getDayOfTheWeek(),
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
            ],
          ),
        ),
        _buildSelectedDayDetails(weatherItem)
      ],
    );
  }

  Widget _buildSelectedDayDetails(WeatherItem weatherItem) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Humadity ${weatherItem.humidity!.round()}%',
            style: Theme.of(context).textTheme.headline3,
          ),
          const VerticalSpace(kVerticalSpace),
          Text(
            'Pressure ${weatherItem.airPressure!.round()}',
            style: Theme.of(context).textTheme.headline3,
          ),
          const VerticalSpace(kVerticalSpace),
          Text(
            'Wind ${weatherItem.windSpeed!.round()} K/H',
            style: Theme.of(context).textTheme.headline3,
          ),
          const VerticalSpace(
            kVerticalSpace,
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return LayoutBuilder(builder: (context, constaints) {
      double size = constaints.maxHeight > constaints.maxWidth
          ? constaints.maxWidth
          : constaints.maxHeight;
      return Container(
        padding: EdgeInsets.all(20),
        child: SvgPicture.asset(
          Images.sn,
          width: size,
          height: size,
        ),
      );
    });
  }

  void getWeatherData() {
    BlocProvider.of<HomePageBloc>(context).add(HomePageWeatherGet(
        (BlocProvider.of<LocationBloc>(context).state as LocationSuccessState)
            .successResource
            .data
            .woeid!));
  }

  void _openAppSetting() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
                'Location access is required to fetch location weather! Please change location access permission from the app settings'),
            actions: [
              TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  child: Text('Ok')),
            ],
          );
        });
  }
}

class WeatherItemWidget extends StatelessWidget {
  const WeatherItemWidget(
    this.weatherItem, {
    this.onTap,
    Key? key,
  }) : super(key: key);
  final WeatherItem weatherItem;
  final Function? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              AppDateUtils.fromYYYYMMdd(weatherItem.applicableDate ?? '')
                  .getDayOfTheWeek(),
              style: Theme.of(context).textTheme.bodyText1,
            ),
            VerticalSpace(10),
            SvgPicture.network(
              Utils.getAssetsLink(weatherItem.weatherStateAbbr ?? 'c'),
              width: 30,
              height: 30,
              // color: Colors.white,
            ),
            VerticalSpace(10),
            Row(
              children: [
                DegreeText(
                  weatherItem.getMaxTemp(),
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                HorizontalSpace(2),
                Text(
                  '/',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                HorizontalSpace(2),
                DegreeText(
                  weatherItem.getMinTemp(),
                  style: Theme.of(context).textTheme.bodyText1,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
