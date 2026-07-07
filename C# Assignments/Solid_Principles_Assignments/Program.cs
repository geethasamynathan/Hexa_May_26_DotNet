using System;
using SmartCourierApp.DeliveryCalculators;
using SmartCourierApp.Invoices;
using SmartCourierApp.Models;
using SmartCourierApp.Notifications;
using SmartCourierApp.Services;

namespace SmartCourierApp
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.Write("Customer Name: ");
            string name = Console.ReadLine();

            Console.Write("Email: ");
            string email = Console.ReadLine();

            Console.Write("Mobile Number: ");
            string mobile = Console.ReadLine();

            Console.Write("Parcel Weight: ");
            double weight = Convert.ToDouble(Console.ReadLine());

            Console.Write("Source City: ");
            string source = Console.ReadLine();

            Console.Write("Destination City: ");
            string destination = Console.ReadLine();

            Console.WriteLine("1. Standard");
            Console.WriteLine("2. Express");
            Console.WriteLine("3. International");
            Console.Write("Choose Delivery Type: ");
            int deliveryChoice = Convert.ToInt32(Console.ReadLine());

            Console.WriteLine("1. Email");
            Console.WriteLine("2. SMS");
            Console.WriteLine("3. WhatsApp");
            Console.Write("Choose Notification Type: ");
            int notificationChoice = Convert.ToInt32(Console.ReadLine());

            IDeliveryChargeCalculator calculator;

            if (deliveryChoice == 1)
            {
                calculator = new StandardDeliveryCalculator();
            }
            else if (deliveryChoice == 2)
            {
                calculator = new ExpressDeliveryCalculator();
            }
            else
            {
                calculator = new InternationalDeliveryCalculator();
            }

            INotificationService notificationService;

            if (notificationChoice == 1)
            {
                notificationService = new EmailNotificationService();
            }
            else if (notificationChoice == 2)
            {
                notificationService = new SmsNotificationService();
            }
            else
            {
                notificationService = new WhatsAppNotificationService();
            }

            IInvoiceGenerator invoiceGenerator =
                new ConsoleInvoiceGenerator();

            CourierBooking booking = new CourierBooking
            {
                Customer = new Customer
                {
                    Name = name,
                    Email = email,
                    MobileNumber = mobile
                },

                Parcel = new Parcel
                {
                    Weight = weight,
                    SourceCity = source,
                    DestinationCity = destination
                }
            };

            if (deliveryChoice == 1)
            {
                booking.DeliveryType = "Standard";
            }
            else if (deliveryChoice == 2)
            {
                booking.DeliveryType = "Express";
            }
            else
            {
                booking.DeliveryType = "International";
            }

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