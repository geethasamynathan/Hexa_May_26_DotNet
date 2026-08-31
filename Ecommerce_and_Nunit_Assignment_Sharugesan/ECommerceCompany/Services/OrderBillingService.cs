using System;
using System.Collections.Generic;
using System.Text;

namespace ECommerceCompany.Services
{
    public class OrderBillingService
    {
        public decimal CalculateSubTotal(decimal productPrice, int quantity)
        {
            if (productPrice <= 0 || quantity <= 0)
            {
                throw new ArgumentException("Product Price or Quantity should not be zero or negative");
            }

            return productPrice * quantity;
        }
        public decimal CalculateDiscount(decimal subTotal)
        {
            if(subTotal >= 5000)
            {
                return subTotal * 0.10m;
            }
            else if(subTotal>=2000 && subTotal <= 4999)
            {
                return subTotal * 0.05m;
            }
            else
            {
                return 0;
            }
        }
        public decimal CalculateDeliveryCharge(decimal amountAfterDiscount)
        {
            if (amountAfterDiscount < 1000)
            {
                return 100;
            }
            return 0;

        }

        public decimal CalculateFinalAmount(decimal productPrice, int quantity)
        {
            
            decimal subTotal = CalculateSubTotal(productPrice, quantity);

            decimal discount = CalculateDiscount(subTotal);

            decimal amountAfterDiscount = subTotal - discount;

            decimal deliveryCharge = CalculateDeliveryCharge(amountAfterDiscount);

            return amountAfterDiscount + deliveryCharge;
        }
    }
}
