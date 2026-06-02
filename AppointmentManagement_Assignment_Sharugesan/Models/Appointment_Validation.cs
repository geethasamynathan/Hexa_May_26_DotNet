using System;
using System.Collections.Generic;
using System.Text;

namespace AppointmentManagement.Models
{
    internal class Appointment_Validation
    {
    }
    public partial class Appointment
    {
        public bool IsValidAppointment()
        {
            try
            {
                if (string.IsNullOrWhiteSpace(PatientName))
                {
                    Console.WriteLine("Validation Error: Patient Name is required.");
                    return false;
                }

                if (string.IsNullOrWhiteSpace(DoctorName))
                {
                    Console.WriteLine("Validation Error: Doctor Name is required.");
                    return false;
                }

                if (string.IsNullOrWhiteSpace(Department))
                {
                    Console.WriteLine("Validation Error: Department is required.");
                    return false;
                }

                if (ConsultationFee <= 0)
                {
                    Console.WriteLine("Validation Error: Consultation Fee must be greater than 0.");
                    return false;
                }

                if (string.IsNullOrWhiteSpace(Status))
                {
                    Console.WriteLine("Validation Error: Status is required.");
                    return false;
                }

                return true;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Unexpected Validation Error: {ex.Message}");
                return false;
            }
        }
    }
}
