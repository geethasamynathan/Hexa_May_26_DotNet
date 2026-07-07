using System;
using System.Collections.Generic;
using System.Text;

namespace Appointment_app
{
    public partial class Appointment
    {
        public void ScheduleAppointment()
        {
            if (Validation())
            {
                Console.WriteLine("Appointment scheduled successfully.");
            }
            else
            {
                Console.WriteLine("Failed to schedule appointment. Please check the details and try again.");
            }
        }

        public void Display()
        {
            Console.WriteLine($"Appointment ID: {AppointmentId}");
            Console.WriteLine($"Patient Name: {PatientName}");
            Console.WriteLine($"Doctor Name: {DoctorName}");
            Console.WriteLine($"Patient Age: {PatientAge}");
            Console.WriteLine($"Appointment Date: {AppointmentDate}");
            Console.WriteLine($"Specialization: {Specialization}");
            Console.WriteLine($"Consultation Fee: {ConsultationFee}");
            Console.WriteLine($"Status: {Status}");
        }

    }
}