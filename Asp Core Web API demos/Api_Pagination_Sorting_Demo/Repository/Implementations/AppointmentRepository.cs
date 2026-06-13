using Api_Pagination_Sorting_Demo.Data;
using Api_Pagination_Sorting_Demo.Models;
using Api_Pagination_Sorting_Demo.Repository.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace Api_Pagination_Sorting_Demo.Repository.Implementations
{
    public class AppointmentRepository: IAppointmentRepository
    {
        private readonly HospitalAppointmentDbContext _context;
        private readonly ILogger<AppointmentRepository> _logger;
        public AppointmentRepository(HospitalAppointmentDbContext context, ILogger<AppointmentRepository> logger)
        {
            _context = context;
            _logger = logger;
        }

        public IQueryable<Appointment> GetAllAppointmentsQueryable()
        {
            _logger.LogInformation(
              "Preparing appointment query with Doctor and Patient includes.");
            return _context.Appointments
                .Include(a => a.Doctor)
                .Include(a => a.Patient)
                .AsQueryable();
        }
    }
}
