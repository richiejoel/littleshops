import 'package:huawei_analytics/huawei_analytics.dart' as AnalyticsHuawei;

class HuaweiAnalyticsManager {

  AnalyticsHuawei.HMSAnalytics hmsAnalytics;

  static final HuaweiAnalyticsManager _instance = HuaweiAnalyticsManager._internal(new AnalyticsHuawei.HMSAnalytics());


  factory HuaweiAnalyticsManager() {
    return _instance;
  }

  static HuaweiAnalyticsManager get instance => _instance;

  HuaweiAnalyticsManager._internal(this.hmsAnalytics);

}