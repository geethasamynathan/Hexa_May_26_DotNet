using ECommerceCompany.Services;

namespace ECommerceCompany
{
    internal class Program
    {
        static void Main(string[] args)
        {
            decimal price = 800;
            int qty = 7;
            OrderBillingService orderBillingService = new OrderBillingService();
            decimal subtotal = orderBillingService.CalculateSubTotal(price, qty);
            decimal finalamount = orderBillingService.CalculateFinalAmount(price, qty);
            decimal discount = orderBillingService.CalculateDiscount(subtotal);
            decimal deliverycharge = orderBillingService.CalculateDeliveryCharge(subtotal - discount);
            Console.WriteLine($"Product Price: {price}\nProduct Quantity: {qty}\nSubtotal: {subtotal}\nDiscount: {discount}\nDelivery Charges: {deliverycharge}\nFinal Amount: {finalamount}");
           
        }
    }
}
