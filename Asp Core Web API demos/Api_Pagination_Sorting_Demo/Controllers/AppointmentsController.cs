using Api_Pagination_Sorting_Demo.Dtos;
using Api_Pagination_Sorting_Demo.Models;
using Api_Pagination_Sorting_Demo.Services.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Drawing.Printing;

namespace Api_Pagination_Sorting_Demo.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AppointmentsController : ControllerBase
    {
        private readonly IAppointmentService _appointmentService;
        private readonly ILogger<AppointmentsController> _logger;
        public AppointmentsController(IAppointmentService appointmentService, 
            ILogger<AppointmentsController> logger)
        {
            _appointmentService = appointmentService;
            _logger = logger;
        }
        [HttpGet]
        public async Task<IActionResult> GetAppointments([FromQuery] AppointmentFilterRequestDto filter)
        {
            _logger.LogInformation($"GetAppointments API called with PageNumber: {filter.PageNumber}, " +
                $"PageSize: {filter.PageSize}, DoctorId: {filter.DoctorId}, PatientId: {filter.PatientId}," +
                $" Status: {filter.AppointmentStatus}");

            var result = await _appointmentService.GetPagedAppointmentsAsync(filter);
            if (!result.Success)
            {
                _logger.LogWarning($"GetAppointments Validation failed: {result.Message}");
                return BadRequest(new
                {
                    StatusCode = StatusCodes.Status400BadRequest,
                    Message = result.Message
                });
            }
            _logger.LogInformation($"GetAppointments API successful. Returned {result.Data?.Data.Count ?? 0} records.");
            return Ok(result.Data);
        }
    }
}
