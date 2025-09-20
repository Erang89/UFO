#include "..\Services\IZoneService.mqh";

input int Magic_Number = 280989;
double Max_Body_Candle_Zone_Percent = 0.5;
double Min_LegIn_LegOut_Point = 0;
int Max_Search_Zone_Candle = 10;
color Supply_Zone_Color = clrSalmon;
color Demand_Zone_Color = clrGreen;


static IZoneService* IZONESERVICE;