using System;
using System.Collections.Generic;
using System.Text;

namespace AppointmentManagement.Models
{
    internal class Appointment_Business
    {
    }
    public partial class Appointment
    {
      
        public bool IsUpcomingAppointment()
        {
            return AppointmentDate > DateTime.Now &&
                   Status.Equals("Scheduled", StringComparison.OrdinalIgnoreCase);
        }

        public string GetAppointmentSummary()
        {
            return $"Appointment ID: {AppointmentId}, " +
                   $"Patient: {PatientName}, " +
                   $"Doctor: {DoctorName}, " +
                   $"Department: {Department}, " +
                   $"Date: {AppointmentDate:dd-MM-yyyy}, " +
                   $"Fee: {ConsultationFee}, " +
                   $"Status: {Status}";
        }
    }
}
