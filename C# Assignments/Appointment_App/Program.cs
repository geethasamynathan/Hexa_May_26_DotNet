using System;
using System.Collections.Generic;

namespace Appointment_app
{
    public class Program
    {
        static void Main(string[] args)
        {
            List<Appointment> appointments = new List<Appointment>();

            Appointment a1 = new Appointment
            {
                AppointmentId = 1,
                PatientName = "Arun",
                DoctorName = "Dr. Meena",
                PatientAge = 25,
                AppointmentDate = DateTime.Now.AddDays(2),
                Specialization = "Cardiology",
                ConsultationFee = 500,
                Status = "Scheduled"
            };

            Appointment a2 = new Appointment
            {
                AppointmentId = 2,
                PatientName = "Kavya",
                DoctorName = "Dr. Raj",
                PatientAge = 30,
                AppointmentDate = DateTime.Now.AddDays(1),
                Specialization = "Dermatology",
                ConsultationFee = 1000,
                Status = "Scheduled"
            };

            Appointment a3 = new Appointment
            {
                AppointmentId = 3,
                PatientName = "Saranya",
                DoctorName = "Dr. Anaga",
                PatientAge = 25,
                AppointmentDate = DateTime.Now.AddDays(1),
                Specialization = "Cardiology",
                ConsultationFee = 500,
                Status = "Completed"
            };

            Appointment a4 = new Appointment
            {
                AppointmentId = 4,
                PatientName = "Varun",
                DoctorName = "Dr. Angith",
                PatientAge = 29,
                AppointmentDate = DateTime.Now.AddDays(1),
                Specialization = "Dermatologist",
                ConsultationFee = 300,
                Status = "Cancelled"
            };

            Appointment a5 = new Appointment
            {
                AppointmentId = 5,
                PatientName = "Danwin",
                DoctorName = "Dr. Akash",
                PatientAge = 25,
                AppointmentDate = DateTime.Now.AddDays(1),
                Specialization = "Pediatrics",
                ConsultationFee = 700,
                Status = "Scheduled"
            };


            appointments.Add(a1);
            appointments.Add(a2);
            appointments.Add(a3);
            appointments.Add(a4);
            appointments.Add(a5);

            foreach (var appt in appointments)
            {
                appt.ScheduleAppointment();
            }

            foreach (var appt in appointments)
            {
                appt.Display();
            }

            foreach (var appt in appointments)
            {
                if (appt.Status == "Scheduled" && appt.AppointmentDate > DateTime.Now.AddDays(1))
                {
                    appt.Display();
                }
            }

            foreach (var appt in appointments)
            {
                if (appt.Status == "Completed")
                {
                    appt.Display();
                }
            }

            foreach (var appt in appointments)
            {
                if (appt.Status == "Cancelled")
                {
                    appt.Display();
                }
            }

            Console.WriteLine("\n--- Cardiology Appointments ---");
            foreach (var appt in appointments)
            {
                if (appt.Specialization == "Cardiology")
                {
                    appt.Display();
                }
            }

            Console.WriteLine("\n---  Consultation Fees  Greater than 500---");

            foreach (var appt in appointments)
            {
                if (appt.ConsultationFee > 500)
                {
                    appt.Display();
                }
            }

            Console.WriteLine("\n--- Sorted By Appointment Date ---");
            var sortedAppointments = appointments.OrderBy(a => a.AppointmentDate);
            foreach (var appt in sortedAppointments)
            {
                appt.Display();
            }

            Console.WriteLine("\n--- Search by Name ----");
            string searchName = "Anaga";
            foreach (var appt in appointments)
            {
                if (appt.PatientName == searchName)
                {
                    appt.Display();
                }
            }

            Console.WriteLine("\n--- Group by Doctor Name ---");
            var groupedByDoctor = appointments.GroupBy(a => a.DoctorName);
            foreach (var group in groupedByDoctor)
            {
                Console.WriteLine($"\nDoctor: {group.Key}");
                foreach (var appt in group)
                {
                    appt.Display();
                }
            }

            Console.WriteLine("\n ---Count By Status ---");
            var countByStatus = appointments.GroupBy(a => a.Status);
            foreach (var group in countByStatus)
            {
                Console.WriteLine($"\nStatus: {group.Key}, Count: {group.Count()}");
            }

            Console.WriteLine("\n--- Total Fees Collected ---");
            var totalFees = appointments.Sum(a => a.ConsultationFee);
            Console.WriteLine($"Total Fees Collected: {totalFees}");

            Console.WriteLine("\n--- Average Fees ---");
            var averageFees = appointments.Average(a => a.ConsultationFee);
            Console.WriteLine($"Average Fees: {averageFees}");

            Console.WriteLine("\n--- Upcoming Appointments ---");


        }
    }
}