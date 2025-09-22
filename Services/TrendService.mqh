#include "..\Common\Helpers.mqh";

enum Enum_Trend_Status
  {
      UpTrendConfirm,
      DownTrendConfirm,
      UpTrendNotConfirm,
      DownTrendNotConfirm
  };

class TrendService
{
   private:
      Enum_Trend_Status lastStatus;
      datetime lastCheck;
      
      void CheckTrendStatus()
      {
         if(lastCheck == iTime(_Symbol, PERIOD_H4, 0))
            return;
            
         double ema20 = HELPER.GetEmaPrice(_Symbol, 20, _Period, 1, PRICE_CLOSE);
         double ema50 = HELPER.GetEmaPrice(_Symbol, 50, _Period, 1, PRICE_CLOSE);
         double ema100 = HELPER.GetEmaPrice(_Symbol, 100, _Period, 1, PRICE_CLOSE);
         double ema200 = HELPER.GetEmaPrice(_Symbol, 200, _Period, 1, PRICE_CLOSE);
         double price = HELPER.GetBidPrice(_Symbol);
         
         if(price > ema200 && ema20 > ema200 && ema50 > ema200 && ema100 > ema200)
         {
            lastStatus = UpTrendConfirm;
            return;
         }
         
         if(price > ema200)
         {
            lastStatus = UpTrendNotConfirm;
            return;
         }
            
         
         if(price < ema200 && ema20 < ema200 && ema50 < ema200 && ema100 < ema200)
         {
            lastStatus = DownTrendConfirm;
            return;
         }
            
         
         lastStatus = DownTrendNotConfirm;
      }
      
      public:
         TrendService()
         {
            CheckTrendStatus();
            lastCheck = iTime(_Symbol, PERIOD_H1, 0);
         }
         
         Enum_Trend_Status GetTrendStatus()
         {
            return lastStatus;
         }
         
         void OnTick()
         {
            CheckTrendStatus();
         }
};