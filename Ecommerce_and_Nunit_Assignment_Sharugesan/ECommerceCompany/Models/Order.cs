using System;
using System.Collections.Generic;
using System.Text;

namespace ECommerceCompany.Models
{
    public class Order
    {
        public decimal ProductPrice { get; set; }
        public int Qty {  get; set; }
        public Order(decimal price, int qty)
        {
            ProductPrice= price;
            Qty=qty;
        }
    }
}
