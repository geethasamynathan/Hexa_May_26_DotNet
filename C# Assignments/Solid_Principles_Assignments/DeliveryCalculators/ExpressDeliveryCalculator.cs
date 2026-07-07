using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SmartCourierApp.DeliveryCalculators
{
    public class ExpressDeliveryCalculator : IDeliveryChargeCalculator
    {
        public decimal CalculateCharge(double weight)
        {
            return ((decimal)weight * 80) + 100;
        }
    }
}  
