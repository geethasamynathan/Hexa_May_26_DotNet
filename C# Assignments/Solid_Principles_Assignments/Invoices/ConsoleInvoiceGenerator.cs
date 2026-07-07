using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using SmartCourierApp.Models;

namespace SmartCourierApp.Invoices
{
    public class ConsoleInvoiceGenerator : IInvoiceGenerator
    {
        public void GenerateInvoice(CourierBooking booking)
        {
            Console.WriteLine("\n------ INVOICE ------");
            Console.WriteLine($"Customer : {booking.Customer.Name}");
            Console.WriteLine($"Source : {booking.Parcel.SourceCity}");
            Console.WriteLine($"Destination : {booking.Parcel.DestinationCity}");
            Console.WriteLine($"Weight : {booking.Parcel.Weight} KG");
            Console.WriteLine($"Delivery Type : {booking.DeliveryType}");
            Console.WriteLine($"Total Charge : Rs.{booking.DeliveryCharge}");
            Console.WriteLine("----------------------");
        }
    }
}
