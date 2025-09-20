struct IZoneModel
{
      datetime ZoneTime;
      datetime LegOutCloseTime;
      int LegInIndex;
      int LegOutIndex;
      int ZoneStartIndex;
      int ZoneEndIndex;
      bool NotFresh;
      bool Expired;
      double Proximal;
      double Distal;
      double ProximalBody;
      double DistalBody;
}