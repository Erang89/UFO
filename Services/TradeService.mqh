#include "..\Common\Variables.mqh";
#include "TrendService.mqh";

class TradeService
{
   private: 
      datetime lastCheck;
      datetime lastCheckEma9Daily;
      double lastEma9Daily;
      bool isBussy;
      
      void Trade()
      {
         if(isBussy || lastCheck == iTime(_Symbol, _Period, 0))
            return;
         
         isBussy = true;
         
         //Print("Trade Checking");
            
         lastCheck = iTime(_Symbol, _Period, 0);
         bool isTrading = HELPER.IsTrading(_Symbol);
         
         if(isTrading)
         {  
            isBussy = false;
            return;
         }
         
          //Print("Trade Checking 2");
           
          Enum_Trend_Status trendStatus = TRENDSERVICE.GetTrendStatus();
          if(trendStatus == UpTrendNotConfirm || trendStatus == DownTrendNotConfirm)
          {
            isBussy = false;
            return;
          }
            
            
         //Print("Trade Checking 3");
         
         bool ema9Daily = GetEma9Daily();
      
         //if(trendStatus == UpTrendConfirm)
            //TradeBuy(ema9Daily);
         
         if(trendStatus == DownTrendConfirm)
            TradeSell(ema9Daily);
          
          //DeleteTrade();  
          Print("Trade Checking 4");
          isBussy = false;        
      }
   
      void TradeBuy(double ema9Daily)
      {
         IZoneModel zones[];
         IZONESERVICE.GetDemandZones(zones);
         
         for(int i=0; i<ArraySize(zones);i++)
         {
            IZoneModel zone = zones[i];
            if(zone.Expired)
            {
               Print("Zone Expired. P: ", zone.Proximal);
               continue;
            }
               
             
             bool isZoneHasEma9Daily = true; //ema9Daily < zone.Proximal && ema9Daily > zone.Distal
             
             if(isZoneHasEma9Daily)
             {
                Print("DZ: P: ", zone.Proximal, " D: ", zone.Distal, " Ema: ", ema9Daily, " Ema Inside"); 
                
               double entry = HELPER.GetAskPrice(zone.Proximal, _Symbol);
               double dailyAtr = HELPER.GetDailyATR(_Symbol);
               double sl = NormalizeDouble(zone.Distal - dailyAtr * Daily_ATR_Buffer_Percent, _Digits);
               double diff = entry - sl;
               
               if(P1_Enable)
               {
                  Print("Open P1");
                  double tp = entry + diff * 1;
                  double size = HELPER.CountTradeLotSize(_Symbol, entry, sl, P1_SizePercent);
                  
                  OrderModel model;
                  model.Entry = entry;
                  model.SL = sl;
                  model.TP = tp;
                  model.LotSize = size;
                  model.OrderSymbol = _Symbol;
                  model.OrderType = ORDER_TYPE_BUY_LIMIT;
                  HELPER.PlaceLimitOrder(model);
               }
               
               if(P2_Enable)
               {
                  double tp = entry + diff * 2;
                  double size = HELPER.CountTradeLotSize(_Symbol, entry, sl, P2_SizePercent);
                  
                  OrderModel model;
                  model.Entry = entry;
                  model.SL = sl;
                  model.TP = tp;
                  model.LotSize = size;
                  model.OrderSymbol = _Symbol;
                  model.OrderType = ORDER_TYPE_BUY_LIMIT;
                  HELPER.PlaceLimitOrder(model);
               }
               
               if(P3_Enable)
               {
                  double tp = entry + diff * 3;
                  double size = HELPER.CountTradeLotSize(_Symbol, entry, sl, P3_SizePercent);
                  
                  OrderModel model;
                  model.Entry = entry;
                  model.SL = sl;
                  model.TP = tp;
                  model.LotSize = size;
                  model.OrderSymbol = _Symbol;
                  model.OrderType = ORDER_TYPE_BUY_LIMIT;
                  HELPER.PlaceLimitOrder(model);
               }
               
               if(P4_Enable)
               {
                  double tp = entry + diff * 4;
                  double size = HELPER.CountTradeLotSize(_Symbol, entry, sl, P4_SizePercent);
                  
                  OrderModel model;
                  model.Entry = entry;
                  model.SL = sl;
                  model.TP = tp;
                  model.LotSize = size;
                  model.OrderSymbol = _Symbol;
                  model.OrderType = ORDER_TYPE_BUY_LIMIT;
                  HELPER.PlaceLimitOrder(model);
               }
               
               if(P5_Enable)
               {
                  double tp = entry + diff * 5;
                  double size = HELPER.CountTradeLotSize(_Symbol, entry, sl, P5_SizePercent);
                  
                  OrderModel model;
                  model.Entry = entry;
                  model.SL = sl;
                  model.TP = tp;
                  model.LotSize = size;
                  model.OrderSymbol = _Symbol;
                  model.OrderType = ORDER_TYPE_BUY_LIMIT;
                  HELPER.PlaceLimitOrder(model);
               }
               
               break;
             }else
             {
               Print("DZ: P: ", zone.Proximal, " D: ", zone.Distal, " Ema: ", ema9Daily, " Ema Outside"); 
             }
         }
      }
   
      void TradeSell(double ema9Daily)
      {
         IZoneModel zones[];
         IZONESERVICE.GetSupplyZone(zones);
         
         
         for(int i=0; i<ArraySize(zones);i++)
         {
            IZoneModel zone = zones[i];
            if(zone.Expired)
               continue;
              
             bool isZoneHasEma9Daily = true; //ema9Daily > zone.Proximal && ema9Daily < zone.Distal
              
             if(isZoneHasEma9Daily)
             {
               
               double spread = HELPER.GetAskPrice(_Symbol) - HELPER.GetBidPrice(_Symbol);
               double entry = zone.Proximal;
               double dailyAtr = HELPER.GetDailyATR(_Symbol);
               double sl = NormalizeDouble(zone.Distal + spread + dailyAtr * Daily_ATR_Buffer_Percent, _Digits);
               double diff = sl - entry;
               
               if(P1_Enable)
               {
                  double tp = entry - diff * 1;
                  double size = HELPER.CountTradeLotSize(_Symbol, entry, sl, P1_SizePercent);
                  Print("OP 1: Entry: ", entry, " SL: ", sl, " TP: ", tp, " Size:", size, " Diff: ", diff, " Atr: ", dailyAtr, " Distal: ", zone.Distal, " Spread: ", HELPER.GetSpread(_Symbol)); 
               
                  OrderModel model;
                  model.Entry = entry;
                  model.SL = sl;
                  model.TP = tp;
                  model.LotSize = size;
                  model.OrderSymbol = _Symbol;
                  model.OrderType = ORDER_TYPE_SELL_LIMIT;
                  HELPER.PlaceLimitOrder(model);
               }
               
               if(P2_Enable)
               {
                  double tp = entry - diff * 2;
                  double size = HELPER.CountTradeLotSize(_Symbol, entry, sl, P2_SizePercent);
                  
                  OrderModel model;
                  model.Entry = entry;
                  model.SL = sl;
                  model.TP = tp;
                  model.LotSize = size;
                  model.OrderSymbol = _Symbol;
                  model.OrderType = ORDER_TYPE_SELL_LIMIT;
                  HELPER.PlaceLimitOrder(model);
               }
               
               if(P3_Enable)
               {
                  double tp = entry - diff * 3;
                  double size = HELPER.CountTradeLotSize(_Symbol, entry, sl, P3_SizePercent);
                  
                  OrderModel model;
                  model.Entry = entry;
                  model.SL = sl;
                  model.TP = tp;
                  model.LotSize = size;
                  model.OrderSymbol = _Symbol;
                  model.OrderType = ORDER_TYPE_SELL_LIMIT;
                  HELPER.PlaceLimitOrder(model);
               }
               
               if(P4_Enable)
               {
                  double tp = entry - diff * 4;
                  double size = HELPER.CountTradeLotSize(_Symbol, entry, sl, P4_SizePercent);
                  
                  OrderModel model;
                  model.Entry = entry;
                  model.SL = sl;
                  model.TP = tp;
                  model.LotSize = size;
                  model.OrderSymbol = _Symbol;
                  model.OrderType = ORDER_TYPE_SELL_LIMIT;
                  HELPER.PlaceLimitOrder(model);
               }
               
               if(P5_Enable)
               {
                  double tp = entry - diff * 5;
                  double size = HELPER.CountTradeLotSize(_Symbol, entry, sl, P5_SizePercent);
                  
                  OrderModel model;
                  model.Entry = entry;
                  model.SL = sl;
                  model.TP = tp;
                  model.LotSize = size;
                  model.OrderSymbol = _Symbol;
                  model.OrderType = ORDER_TYPE_SELL_LIMIT;
                  HELPER.PlaceLimitOrder(model);
               }
               
               break;
             }else
             {
               Print("SZ: P: ", zone.Proximal, " D: ", zone.Distal, " Ema: ", ema9Daily, " Ema Outside");  
             }
         }
      }
      
      void DeleteTrade()
      {
         for(int i=0; i<OrdersTotal(); i++)
         {
            ulong ticket = OrderGetTicket(i);
            
            if(ticket > 0 && OrderSelect(ticket))
            {
               long   magic  = OrderGetInteger(ORDER_MAGIC);
               string symbol = OrderGetString(ORDER_SYMBOL);
               long orderType = OrderGetInteger(ORDER_TYPE);
               double proximal = OrderGetDouble(ORDER_PRICE_OPEN);
               double distal = OrderGetDouble(ORDER_SL);
               
               
               if(magic != Magic_Number || symbol == _Symbol)
                  continue;
               
               if(orderType == ORDER_TYPE_BUY_LIMIT)
               {
                  proximal = proximal - HELPER.GetSpread(_Symbol);
                  distal = distal + GetEma9Daily() * Daily_ATR_Buffer_Percent;
               }
               
               if(orderType == ORDER_TYPE_SELL_LIMIT)
               {
                  distal = distal - HELPER.GetSpread(_Symbol) - GetEma9Daily() * Daily_ATR_Buffer_Percent;
               }
               
               double ema9Price = GetEma9Daily();
               bool isEmaInUfo = orderType == ORDER_TYPE_BUY_LIMIT?
                                 ema9Price <= proximal && ema9Price > distal :
                                 orderType == ORDER_TYPE_SELL_LIMIT?
                                 ema9Price > proximal && ema9Price < distal : false; 
               
               
               Enum_Trend_Status trendStatus = TRENDSERVICE.GetTrendStatus();
               bool isTrendSupportOrder = (trendStatus == UpTrendConfirm && orderType == ORDER_TYPE_BUY_LIMIT) || (trendStatus == DownTrendConfirm && orderType == ORDER_TYPE_SELL_LIMIT);
               if(isEmaInUfo && isTrendSupportOrder)
                  continue;
                  
                HELPER.DeletePendingOrder(ticket);
                
            }
         }
      }
      
      double GetEma9Daily()
      { 
         if(lastCheckEma9Daily == iTime(_Symbol, PERIOD_M15, 1))
            return lastEma9Daily;
         
         lastCheckEma9Daily = iTime(_Symbol, PERIOD_M15, 1);
         lastEma9Daily = HELPER.GetCurrentPairEmaPrice(_Symbol, 9, PERIOD_D1, 0, PRICE_CLOSE);
         return lastEma9Daily;
      }
   
   public:
      TradeService()
      {
         Trade();
         lastCheck = iTime(_Symbol, _Period, 0);
      }
      
    void OnTick()
    {
      Trade();
    }  

};