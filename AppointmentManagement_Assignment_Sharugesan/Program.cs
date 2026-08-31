using AppointmentManagement.Models;
namespace AppointmentManagement
{
    internal class Program
    {
        static void Main(string[] args)
        {
            List<Appointment> appointments = new List<Appointment>
            {
                new Appointment
                {
                    AppointmentId = 1,
                    PatientName = "Arun",
                    DoctorName = "Dr. Kumar",
                    Department = "Cardiology",
                    AppointmentDate = DateTime.Now.AddDays(2),
                    ConsultationFee = 700,
                    Status = "Scheduled"
                },

                new Appointment
                {
                    AppointmentId = 2,
                    PatientName = "Priya",
                    DoctorName = "Dr. Meena",
                    Department = "Neurology",
                    AppointmentDate = DateTime.Now.AddDays(-2),
                    ConsultationFee = 800,
                    Status = "Completed"
                },

                new Appointment
                {
                    AppointmentId = 3,
                    PatientName = "Ravi",
                    DoctorName = "Dr. Raj",
                    Department = "Cardiology",
                    AppointmentDate = DateTime.Now.AddDays(5),
                    ConsultationFee = 600,
                    Status = "Scheduled"
                },

                new Appointment
                {
                    AppointmentId = 4,
                    PatientName = "Karthik",
                    DoctorName = "Dr. Suresh",
                    Department = "Orthopedics",
                    AppointmentDate = DateTime.Now.AddDays(-5),
                    ConsultationFee = 450,
                    Status = "Completed"
                },

                new Appointment
                {
                    AppointmentId = 5,
                    PatientName = "Divya",
                    DoctorName = "Dr. Lakshmi",
                    Department = "Cardiology",
                    AppointmentDate = DateTime.Now.AddDays(1),
                    ConsultationFee = 900,
                    Status = "Scheduled"
                },

                new Appointment
                {
                    AppointmentId = 6,
                    PatientName = "Mohan",
                    DoctorName = "Dr. Anand",
                    Department = "Dermatology",
                    AppointmentDate = DateTime.Now.AddDays(-1),
                    ConsultationFee = 500,
                    Status = "Completed"
                }
            };

            Console.WriteLine("All Appointments");
            Console.WriteLine("---------------------------");
            foreach (var appointment in appointments)
            {
                Console.WriteLine(appointment.GetAppointmentSummary());
            }


            Console.WriteLine();
            Console.WriteLine("Scheduled Appointments");
            Console.WriteLine("---------------------------");
            var scheduledappointment = appointments.Where(a => a.Status == "Scheduled").ToList();
            foreach (var appointment in scheduledappointment)
            {
                Console.WriteLine(appointment.GetAppointmentSummary());
            }


            Console.WriteLine();
            Console.WriteLine("Completed Appointments");
            Console.WriteLine("---------------------------");
            var completedappointment = appointments.Where(a => a.Status == "Completed").ToList();
            foreach (var appointment in completedappointment)
            {
                Console.WriteLine(appointment.GetAppointmentSummary());
            }
            Console.WriteLine();
            Console.WriteLine("Cardiology Department Appointments");
            Console.WriteLine("---------------------------");
            var cardiologyDEPT = appointments.Where(a => a.Department == "Cardiology").ToList();
            foreach (var appointment in cardiologyDEPT)
            {
                Console.WriteLine(appointment.GetAppointmentSummary());
            }
            Console.WriteLine();
            Console.WriteLine("Consultation Fee Greater than 500");
            Console.WriteLine("---------------------------");
            var consultationFee_Greater500 = appointments.Where(a => a.ConsultationFee > 500).ToList();
            foreach (var appointment in consultationFee_Greater500)
            {
                Console.WriteLine(appointment.GetAppointmentSummary());
            }

            Console.WriteLine();
            Console.WriteLine("Order BY AppointmentDate");
            Console.WriteLine("---------------------------");
            var ordByDate = appointments.OrderBy(a => a.AppointmentDate).ToList();
            foreach (var appointment in ordByDate)
            {
                Console.WriteLine(appointment.GetAppointmentSummary());
            }
            Console.WriteLine();
            Console.WriteLine("Search By Patient Name");
            Console.WriteLine("---------------------------");
            var searchbyname = appointments.Where(a => a.PatientName== "Divya").ToList();
            foreach (var appointment in searchbyname)
            {
                Console.WriteLine(appointment.GetAppointmentSummary());
            }
            Console.WriteLine();
            Console.WriteLine("Group by Department");
            Console.WriteLine("---------------------------");
            var GRPbyDEPT = appointments.GroupBy(a => a.Department);
            foreach (var departmentGroup in GRPbyDEPT)
            {
                Console.WriteLine($"\nDepartment: {departmentGroup.Key}");

                foreach (var appointment in departmentGroup)
                {
                    Console.WriteLine(
                        $"Patient: {appointment.PatientName}, " +
                        $"Doctor: {appointment.DoctorName}, " +
                        $"Fee: {appointment.ConsultationFee} "+
                        $"Appointment Date: {appointment.AppointmentDate}");
                }
            }
            Console.WriteLine();
            Console.WriteLine("Appointment Count By Status");
            Console.WriteLine("---------------------------");
            var appointmentStatusCount = appointments.GroupBy(a => a.Status).Select(group => new
                            {
                                Status = group.Key,
                                Count = group.Count()
                            });
            foreach (var item in appointmentStatusCount)
            {
                Console.WriteLine($"{item.Status}: {item.Count}");
            }

            Console.WriteLine();
            Console.WriteLine("Total Revenue");
            Console.WriteLine("---------------------------");
            decimal totalRevenue = appointments
                        .Where(a => a.Status == "Completed")
                        .Sum(a => a.ConsultationFee);
            Console.WriteLine($"Total Revenue From Completed Appointments: {totalRevenue}");

            Console.WriteLine();
            Console.WriteLine("Average Consultation Fee");
            Console.WriteLine("---------------------------");
            decimal averageFee = appointments.Average(a => a.ConsultationFee);
            Console.WriteLine($"Average Consultation Fee: {averageFee:F2}");



            Console.WriteLine();
            Console.WriteLine("Upcoming Appointments");
            Console.WriteLine("---------------------------");
            var upcomingAppointments = appointments.Where(a => a.IsUpcomingAppointment()).ToList();
            foreach (var appointment in upcomingAppointments)
            {
                Console.WriteLine(appointment.GetAppointmentSummary());
            }

        }
    }
}
