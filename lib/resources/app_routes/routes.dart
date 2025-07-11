import 'package:aidea/resources/app_routes/route_names.dart';
import 'package:get/get.dart';


import '../../view/screens/cce/cce_dashboard.dart';
import '../../view/screens/cce/cce_data_entry.dart';
import '../../view/screens/cce/cce_plot_list.dart';
import '../../view/screens/cce/out_of_clusterlist.dart';
import '../../view/screens/cce/preharvest_report/basic_plot_details.dart';
import '../../view/screens/cce/preharvest_report/cultivation_details.dart';
import '../../view/screens/cce/preharvest_report/land_farmers.dart';
import '../../view/screens/cce/preharvest_report/preharvest_dashboard.dart';
import '../../view/screens/form1_dashboard.dart';
import '../../view/screens/screen_aidea_schemes.dart';
import '../../view/screens/screen_cce.dart';
import '../../view/screens/screen_cluster_detail.dart';
import '../../view/screens/screen_cluster_list.dart';
import '../../view/screens/screen_crop_details.dart';
import '../../view/screens/screen_dashboard.dart';
import '../../view/screens/screen_form1.dart';
import '../../view/screens/screen_irrigation.dart';
import '../../view/screens/screen_keyplot_details.dart';
import '../../view/screens/screen_land_utilization.dart';
import '../../view/screens/screen_login.dart';
import '../../view/screens/screen_zone_details.dart';

class AppRoutes {
  static appRoutes() => [
    GetPage(
      name: RouteNames.loginScreen,
      page: () => ViewLoginScreen(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: RouteNames.dashboardScreen,
      page: () => ScreenDashboard(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: RouteNames.earasScreen,
      page: () => ScreenSchemesExt(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: RouteNames.clusterScreen,
      page: () => ClusterViewPage(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: RouteNames.formScreen,
      page: () => const Form1(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: RouteNames.clusterdetail,
      page: () =>  ClusterDetailPage(displayIndex: 1,),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: RouteNames.zonedetail,
      page: () =>  ZoneDetailsPage(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: RouteNames.formdashboard,
      page: () =>  Form1Dashboard(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: RouteNames.keyplotOwner,
      page: () =>  KeyPlotOwner(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: RouteNames.cropDetails,
      page: () =>  CropDetails(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: RouteNames.landUtilization,
      page: () =>  LandUtilization(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: RouteNames.irrigation,
      page: () =>  IrrigationDetails(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: RouteNames.cceplotlist,
      page: () =>  CcePlotList(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: RouteNames.cceoutlist,
      page: () =>  CCEOutCluster(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: RouteNames.preharvestdash,
      page: () =>  PreharvestDashboard(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: RouteNames.ccedataEntry,
      page: () => CceDataEntry(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: RouteNames.cceReports,
      page: () => ScreenCCE(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: RouteNames.phcultivation,
      page: () => CultivationDetailsPage(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: RouteNames.ccedashboard,
      page: () => CceDashboard(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: RouteNames.cceBasicPlot,
      page: () => BasicPlotDetails(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: RouteNames.cceLandFarmer,
      page: () => LandFarmers(),
      transition: Transition.leftToRight,
    ),

  ];
}
