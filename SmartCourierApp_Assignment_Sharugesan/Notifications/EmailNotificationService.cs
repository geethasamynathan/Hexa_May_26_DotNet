using System;
using System.Collections.Generic;
using System.Text;

namespace SmartCourierApp.Notifications
{
    public class EmailNotificationService : INotificationService
    {
        public void SendNotification(string message)
        {
            Console.WriteLine($"EMAIL: {message}");
        }
    }
}
