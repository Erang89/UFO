//+------------------------------------------------------------------+
//|                                                          UFO.mq5 |
//|                                  Copyright 2025, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

#include "Common\Helpers.mqh";
#include "Common\Variables.mqh";
#include "Services\IZoneService.mqh";
#include "Services\IZoneDisplayService.mqh";
#include "Services\TrendService.mqh";
#include "Services\TradeService.mqh";


bool hasLoad;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
   //--- create timer
   EventSetTimer(60);
    IZONESERVICE = new IZoneService();
    IZONEDISPLAYSERVICE = new IZoneDisplayService();
    HELPER = new Helpers();
    TRENDSERVICE = new TrendService();
    TRADESERVICE = new TradeService();
    
    hasLoad = true;
   //---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
      if(IZONESERVICE !=   NULL){delete IZONESERVICE; IZONESERVICE = NULL; }
      if(IZONEDISPLAYSERVICE !=   NULL){delete IZONEDISPLAYSERVICE; IZONEDISPLAYSERVICE = NULL; }
      if(HELPER != NULL){delete HELPER; HELPER = NULL; }
      if(TRENDSERVICE != NULL){delete TRENDSERVICE; TRENDSERVICE = NULL; }
      if(TRADESERVICE != NULL){delete TRADESERVICE; TRADESERVICE = NULL; }
      
      //--- destroy timer
      hasLoad = false;
      EventKillTimer();
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {   
      if(!hasLoad)
         return;
      
      IZONESERVICE.OnTick();
      IZONEDISPLAYSERVICE.OnTick();
      TRENDSERVICE.OnTick();
      TRADESERVICE.OnTick();
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Trade function                                                   |
//+------------------------------------------------------------------+
void OnTrade()
  {
//---
   
  }
//+------------------------------------------------------------------+
//| TradeTransaction function                                        |
//+------------------------------------------------------------------+
void OnTradeTransaction(const MqlTradeTransaction& trans,
                        const MqlTradeRequest& request,
                        const MqlTradeResult& result)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int32_t id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| BookEvent function                                               |
//+------------------------------------------------------------------+
void OnBookEvent(const string &symbol)
  {
//---
   
  }
//+------------------------------------------------------------------+
