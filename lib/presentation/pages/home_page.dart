import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:weather_app/core/resource/resource.dart';
import 'package:weather_app/core/routes/routes.dart';
import 'package:weather_app/core/utils.dart';
import 'package:weather_app/domain/entities/weather_item.dart';
import 'package:weather_app/presentation/blocs/home/bloc/home_page_bloc.dart';
import 'package:weather_app/presentation/blocs/location/bloc/location_bloc.dart';
import 'package:weather_app/presentation/blocs/settings/bloc/settings_bloc.dart';
import 'package:weather_app/presentation/widgets/app_loading_widget.dart';
import 'package:weather_app/presentation/widgets/degree_text.dart';
import 'package:weather_app/presentation/widgets/horizontal_space.dart';
import 'package:weather_app/presentation/widgets/retry_widget.dart';
import 'package:weather_app/presentation/widgets/vertical_space.dart';
import 'package:weather_app/resources/resources.dart';
import 'package:easy_localization/easy_localization.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const double kVerticalSpace = 20;
  String bgImage = Gifs.cloudBlueG;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey(); // Create a key

  @override
  void didChangeDependencies() {
    BlocProvider.of<SettingsBloc>(context).getSettingState();
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
          key: _scaffoldKey,
          drawer: _buildDrawer(),
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
              child: _buildSettingBloc(),
            ),
          )),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Wearher App'),
          ),
          ListTile(
            title: Text(
              'home.settings'.tr(),
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: AppConst.kAppPrimaryColor),
            ),
            onTap: () {
              Navigator.pushNamed(context, Routes.kSettingPageRoute);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingBloc() {
    return BlocListener<SettingsBloc, SettingsState>(
        listener: (context, state) {
      if (state is SettingsSuccessState) {
        BlocProvider.of<LocationBloc>(context).add(LocationGetEvent());
      }
    }, child:
            BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
      if (state is SettingsInitial) {
        return const AppLoadingWidget();
      }

      return _buildLocationWidget();
    }));
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
              'home.allow_access'.tr(),
              onPressed: () {
                BlocProvider.of<LocationBloc>(context).add(LocationGetEvent());
              },
            );
          } else {
            return RetryWidget(
              'common.somthing_wrong'.tr(),
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
              'common.somthing_wrong'.tr(),
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
        Expanded(
            child: Stack(
          children: [
            Container(child: _detailsItem(selectedItem)),
            InkWell(
              onTap: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              child: const Align(
                alignment: Alignment.topLeft,
                child: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        )),
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
          child: LayoutBuilder(
            builder: (context, con) {
              return _buildDetailsItemFocusedData(weatherItem, con.maxHeight);
            },
          ),
        ),
        _buildSelectedDayDetails(weatherItem)
      ],
    );
  }

  Row _buildDetailsItemFocusedData(WeatherItem weatherItem, double maxHeight) {
    return Row(
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
            TemperatureWidget(
              weatherItem.getTemp(),
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  ?.copyWith(fontSize: maxHeight * 0.4),
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
    );
  }

  Widget _buildSelectedDayDetails(WeatherItem weatherItem) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${'home.humadity'.tr()} ${weatherItem.humidity!.round()}%',
            style: Theme.of(context).textTheme.headline3,
          ),
          const VerticalSpace(kVerticalSpace),
          Text(
            '${'home.pressure'.tr()} ${weatherItem.airPressure!.round()}',
            style: Theme.of(context).textTheme.headline3,
          ),
          const VerticalSpace(kVerticalSpace),
          Text(
            '${'home.wind'.tr()} ${weatherItem.windSpeed!.round()} K/H',
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
            content: Text('home.location_access_message'.tr()),
            actions: [
              TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  child: Text('commont.ok'.tr())),
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
                TemperatureWidget(
                  weatherItem.getMaxTemp(),
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                HorizontalSpace(2),
                Text(
                  '/',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                HorizontalSpace(2),
                TemperatureWidget(
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
