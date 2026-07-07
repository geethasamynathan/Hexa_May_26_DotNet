using System;
using System.Collections.Generic;
using System.Text;

namespace Appointment_app
{
    public partial class Appointment
    {
        public bool Validation()
        {
            if (string.IsNullOrEmpty(PatientName) || string.IsNullOrEmpty(DoctorName) || string.IsNullOrEmpty(Specialization))
            {
                Console.WriteLine("Patient Name, Doctor Name and Specialization cannot be empty.");
                return false;
            }
            if (PatientAge < 0)
            {
                Console.WriteLine("Invalid Patient age");
                return false;
            }
            if (AppointmentDate <= DateTime.MinValue)
            {
                Console.WriteLine("Choose correct appointment date");
                return false;
            }
            return true;
        }
    }
}