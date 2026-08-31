using System;
using System.Collections.Generic;
using System.Text;

namespace AppointmentManagement.Models
{
    internal class Appointment_Properties
    {
    }
    public partial class Appointment
    {
        public int AppointmentId { get; set; }

        public string PatientName { get; set; } = string.Empty;

        public string DoctorName { get; set; } = string.Empty;

        public string Department { get; set; } = string.Empty;

        public DateTime AppointmentDate { get; set; }

        public decimal ConsultationFee { get; set; }

        public string Status { get; set; } = string.Empty;
    }
}
