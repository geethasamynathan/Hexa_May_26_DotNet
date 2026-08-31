using SmartCourierApp.DeliveryCalculators;
using SmartCourierApp.Invoices;
using SmartCourierApp.Models;
using SmartCourierApp.Notifications;
using SmartCourierApp.Services;

namespace SmartCourierApp
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Customer customer = new Customer
            {
                Name = "Karthick",
                Email = "Karthick@gmail.com",
                MobileNumber = "9999999999"
            };

            
            Parcel parcel = new Parcel
            {
                Weight = 5,
                SourceCity = "Chennai",
                DestinationCity = "Bangalore"
            };

            
            CourierBooking booking = new CourierBooking
            {
                Customer = customer,
                Parcel = parcel,
                DeliveryType = "Express",
                NotificationType = "Email"
            };

            
            IDeliveryChargeCalculator calculator =
                new ExpressDeliveryCalculator();

            
            INotificationService notificationService =
                new EmailNotificationService();

            
            IInvoiceGenerator invoiceGenerator =
                new ConsoleInvoiceGenerator();

            
            CourierBookingService bookingService =
                new CourierBookingService(
                    calculator,
                    notificationService,
                    invoiceGenerator);

            
            bookingService.BookCourier(booking);

            Console.ReadLine();
        }
    }
}
