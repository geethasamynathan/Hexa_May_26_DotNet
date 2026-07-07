using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SmartCourierApp.DeliveryCalculators
{
    public class StandardDeliveryCalculator : IDeliveryChargeCalculator
    {
        public decimal CalculateCharge(double weight)
        {
            return (decimal)weight * 50;
        }
    }
}
