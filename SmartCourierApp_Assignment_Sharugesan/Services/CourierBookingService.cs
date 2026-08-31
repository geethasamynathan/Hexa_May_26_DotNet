using SmartCourierApp.DeliveryCalculators;
using SmartCourierApp.Invoices;
using SmartCourierApp.Models;
using SmartCourierApp.Notifications;
using System;
using System.Collections.Generic;
using System.Text;

namespace SmartCourierApp.Services
{
    public class CourierBookingService
    {
        private readonly IDeliveryChargeCalculator _calculator;
        private readonly INotificationService _notificationService;
        private readonly IInvoiceGenerator _invoiceGenerator;

        public CourierBookingService(
            IDeliveryChargeCalculator calculator,
            INotificationService notificationService,
            IInvoiceGenerator invoiceGenerator)
        {
            _calculator = calculator;
            _notificationService = notificationService;
            _invoiceGenerator = invoiceGenerator;
        }

        public void BookCourier(CourierBooking booking)
        {
            
            booking.DeliveryCharge =_calculator.CalculateCharge(booking.Parcel.Weight);

            
            _notificationService.SendNotification($"Courier booked successfully. Charge: {booking.DeliveryCharge}");

            
            _invoiceGenerator.GenerateInvoice(booking);
        }
    }
}
