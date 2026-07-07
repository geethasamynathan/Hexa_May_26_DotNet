using System;
using System.Collections.Generic;
using System.Text;

namespace Appointment_app
{
    public partial class Appointment
    {
        public int AppointmentId { get; set; }
        public string PatientName { get; set; } = string.Empty;
        public string DoctorName { get; set; } = string.Empty;
        public int PatientAge { get; set; }
        public DateTime AppointmentDate { get; set; }
        public string Specialization { get; set; } = string.Empty;
        public decimal ConsultationFee { get; set; }
        public string Status { get; set; } = "Scheduled";


    }
}