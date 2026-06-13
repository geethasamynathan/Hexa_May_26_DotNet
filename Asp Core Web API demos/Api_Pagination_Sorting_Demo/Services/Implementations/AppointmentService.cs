using Api_Pagination_Sorting_Demo.Dtos;
using Api_Pagination_Sorting_Demo.Models;
using Api_Pagination_Sorting_Demo.Repository.Interfaces;
using Api_Pagination_Sorting_Demo.Services.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace Api_Pagination_Sorting_Demo.Services.Implementations
{
    public class AppointmentService: IAppointmentService
    {
        private readonly IAppointmentRepository _appointmentRepository;
        private readonly ILogger<AppointmentService> _logger;
        private readonly string[] _allowedSortFields = 
            {"appointmentId",
            "appointmentdate", 
            "appointmentTime",
            "appointmentStatus",
            "doctorname", 
            "patientname",
            "createdDate" };

        public AppointmentService(IAppointmentRepository appointmentRepository, ILogger<AppointmentService> logger)
        {
            _appointmentRepository = appointmentRepository;
            _logger = logger;
        }

        public async Task<(bool Success, string Message, PagedResponseDto<AppointmentResponseDto>?
            Data)> GetPagedAppointmentsAsync(AppointmentFilterRequestDto filter)
        {
            _logger.LogInformation("AppointmentService started Pagination operation");
            if(filter.PageNumber<= 0 || filter.PageSize <= 0)
            {
                _logger.LogWarning("Invalid pagination parameters: PageNumber={PageNumber}, PageSize={PageSize}", filter.PageNumber, filter.PageSize);
                return (false, "PageNumber and PageSize must be greater than zero.", null);
            }
            if(filter.PageSize>= 100)
            {
                return (false, "PageSize must be less than 100.", null);
            }
            if(filter.FromDate.HasValue && 
                filter.ToDate.HasValue && 
                filter.FromDate.Value > filter.ToDate.Value)
            {
                return (false, "FromDate cannot be greater than ToDate.", null);
            }

            if(!IsValidSortField(filter.SortBy))
            {
                return (false, $"Invalid Sort field. Allowed fields are: {string.Join(", ", _allowedSortFields)}.", null);
            }
            if(!IsValidSortDirection(filter.SortDirection))
            {
                return (false, "Invalid Sort direction. Allowed values are: asc or desc.", null);
            }

            IQueryable<Appointment> query = _appointmentRepository.GetAllAppointmentsQueryable();
            query = ApplyFiltering(query, filter);
            query = ApplySorting(query, filter.SortBy!, filter.SortDirection!);
            int totalRecords = await query.CountAsync();
            int totalPages = (int)Math.Ceiling(totalRecords / (double)filter.PageSize);
            _logger.LogInformation(
                "Total appointments before pagination: {TotalRecords}",
                totalRecords);

            List<Appointment> appointments = await query
                .Skip((filter.PageNumber - 1) * filter.PageSize)
                .Take(filter.PageSize)
                .ToListAsync();
            _logger.LogInformation(
                $"AppointmentService completed pagination. Records returned: {appointments.Count}",
                appointments.Count);

            List<AppointmentResponseDto> appointmentDtos = appointments
                .Select(a => new AppointmentResponseDto
                {
                    AppointmentId = a.AppointmentId,
                    DoctorId = a.DoctorId,
                    DoctorName = a.Doctor.DoctorName,

                    PatientId = a.PatientId,
                    PatientName = a.Patient.PatientName,
                    PatientCity = a.Patient.City,
                    AppointmentDate = a.AppointmentDate,
                    AppointmentTime = a.AppointmentTime,
                    AppointmentStatus = a.AppointmentStatus,
                    Symptoms = a.Symptoms,
                    CreatedDate = a.CreatedDate
                }).ToList();
           

            var response=new PagedResponseDto<AppointmentResponseDto>
            {
                StatusCode=StatusCodes.Status200OK,
                Message= "Appointments retrieved successfully.",
                PageNumber = filter.PageNumber,
                PageSize = filter.PageSize,
                TotalRecords = totalRecords,
                TotalPages = totalPages,
                HasPreviousPage = filter.PageNumber > 1,
                HasNextPage = filter.PageNumber < totalPages,
               Data = appointmentDtos
            };
            return (true, "Success", response);
        
        }
        private IQueryable<Appointment> ApplyFiltering
            (IQueryable<Appointment> query,
            AppointmentFilterRequestDto filter)
        {
            if (filter.DoctorId.HasValue)
            {
                query = query.Where(a => a.DoctorId == filter.DoctorId.Value);
            }
            if (filter.PatientId.HasValue)
            {
                query = query.Where(a => a.PatientId == filter.PatientId.Value);
            }
            if (!string.IsNullOrWhiteSpace(filter.AppointmentStatus))
            {
                string status = filter.AppointmentStatus.Trim().ToLower();
                query = query.Where(a => a.AppointmentStatus.ToLower() == status);
            }
            if (filter.FromDate.HasValue)
            {
                query = query.Where(a => a.AppointmentDate >= filter.FromDate.Value);
            }
            if (filter.ToDate.HasValue)
            {
                query = query.Where(a => a.AppointmentDate <= filter.ToDate.Value);
            }
            return query;
        }

        private IQueryable<Appointment> ApplySorting
            (IQueryable<Appointment> query,
                       string? sortBy, 
                       string? sortDirection)
        {
            string[] sortFields=sortBy
                .Split(',', StringSplitOptions.RemoveEmptyEntries)
                .Select(f => f.Trim().ToLower())
                .ToArray();
           bool isDescending = sortDirection.Trim().ToLower() == "desc";
            IOrderedQueryable<Appointment>? orderedQuery = null;
            for (int i = 0; i < sortFields.Length; i++)
            {
                string field = sortFields[i];
                if (i == 0)
                {
                    orderedQuery = ApplyFirstSort(query, field, isDescending);
                }
                else
                {
                    orderedQuery = ApplyThenSort(orderedQuery!, field, isDescending);
                }
            }
            return orderedQuery ?? query.OrderBy(a =>a.AppointmentDate);
        }   
        private IOrderedQueryable<Appointment> ApplyFirstSort(
                       IQueryable<Appointment> query,
                                  string field, bool isDescending)
        {
            return field.ToLower() switch
            {
                "appointmentid" => isDescending
                ? query.OrderByDescending(a => a.AppointmentId)
                : query.OrderBy(a => a.AppointmentId),
                "appointmentdate" => isDescending
                ? query.OrderByDescending(a => a.AppointmentDate)
                : query.OrderBy(a => a.AppointmentDate),
                "appointmenttime" => isDescending
                ? query.OrderByDescending(a => a.AppointmentTime)
                : query.OrderBy(a => a.AppointmentTime),
                "appointmentstatus" => isDescending
                ? query.OrderByDescending(a => a.AppointmentStatus)
                : query.OrderBy(a => a.AppointmentStatus),
                "doctorname" => isDescending
                ? query.OrderByDescending(a => a.Doctor.DoctorName)
                : query.OrderBy(a => a.Doctor.DoctorName),
                "patientname" => isDescending
                ? query.OrderByDescending(a => a.Patient.PatientName)
                : query.OrderBy(a => a.Patient.PatientName),
                "createddate" => isDescending
                ? query.OrderByDescending(a => a.CreatedDate)
                : query.OrderBy(a => a.CreatedDate),
                _ => (IOrderedQueryable<Appointment>)query
            };
        }

        private IOrderedQueryable<Appointment> ApplyThenSort(
            IOrderedQueryable<Appointment> query,
            string field,bool isDescending)
        {
            return field.ToLower() switch
            {
                "appointmentid" => isDescending
                ? query.ThenByDescending(a => a.AppointmentId) 
                : query.ThenBy(a => a.AppointmentId),
                "appointmentdate" => isDescending 
                ? query.ThenByDescending(a => a.AppointmentDate) 
                : query.ThenBy(a => a.AppointmentDate),
                "appointmenttime" => isDescending 
                ? query.ThenByDescending(a => a.AppointmentTime) 
                : query.ThenBy(a => a.AppointmentTime),
                "appointmentstatus" => isDescending 
                ? query.ThenByDescending(a => a.AppointmentStatus) 
                : query.ThenBy(a => a.AppointmentStatus),
                "doctorname" => isDescending 
                ? query.ThenByDescending(a => a.Doctor.DoctorName) 
                : query.ThenBy(a => a.Doctor.DoctorName),
                "patientname" => isDescending 
                ? query.ThenByDescending(a => a.Patient.PatientName) 
                : query.ThenBy(a => a.Patient.PatientName),
                "createddate" => isDescending 
                ? query.ThenByDescending(a => a.CreatedDate) 
                : query.ThenBy(a => a.CreatedDate),
                _ => query
            };
        }
        private bool IsValidSortDirection(string? sortDirection)
        {
            if (string.IsNullOrWhiteSpace(sortDirection))
            {
                return true; // Use default sorting
            }
            string direction = sortDirection.Trim().ToLower();
            return direction == "asc" || direction == "desc";
        }
        private bool IsValidSortField(string? sortBy)
        {
            if(string.IsNullOrWhiteSpace(sortBy))
            {
                return true; // Use default sorting
            }
            string[] requestedFields=sortBy
                .Split(',',StringSplitOptions.RemoveEmptyEntries)
                .Select(f => f.Trim().ToLower())
                .ToArray();

            foreach (string field in requestedFields)
            {bool isAllowed = _allowedSortFields
                    .Any(allowed => allowed.Equals(field,
                    StringComparison.OrdinalIgnoreCase));
                if (!isAllowed)
                {
                    return false;
                }
            }
            return true;
        }
    }
}
