#include "..\Services\IZoneService.mqh";
#include "..\Services\IZoneDisplayService.mqh";
#include "..\Services\TrendService.mqh";
#include "..\Services\TradeService.mqh";
#include "..\Common\Helpers.mqh";


input int Magic_Number = 280989;
input double Max_Body_Candle_Zone_Percent = 0.5;
input double Min_LegIn_LegOut_Point = 0;
input int Max_Search_Zone_Candle = 10;
input color Supply_Zone_Color = clrSalmon;
input color Demand_Zone_Color = clrGreen;
input double Daily_ATR_Buffer_Percent = 0.06;

input bool P1_Enable = true;
input bool P2_Enable = true;
input bool P3_Enable = true;
input bool P4_Enable = true;
input bool P5_Enable = true;

input double P1_SizePercent = 0.005;
input double P2_SizePercent = 0.005;
input double P3_SizePercent = 0.005;
input double P4_SizePercent = 0.005;
input double P5_SizePercent = 0.005;


static IZoneService* IZONESERVICE;
static IZoneDisplayService* IZONEDISPLAYSERVICE;
static Helpers* HELPER;
static TrendService* TRENDSERVICE;
static TradeService* TRADESERVICE;