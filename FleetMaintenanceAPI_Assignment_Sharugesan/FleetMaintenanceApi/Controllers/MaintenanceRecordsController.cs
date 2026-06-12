using FleetMaintenanceApi.DTOs;
using FleetMaintenanceApi.Services.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace FleetMaintenanceApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MaintenanceRecordsController : ControllerBase
    {
        private readonly IMaintenanceService _maintenanceService;
        public MaintenanceRecordsController(IMaintenanceService maintenanceService)
        {
            _maintenanceService = maintenanceService;
        }
        [HttpGet]
        public async Task<IActionResult> GetMaintenanceRecords(
    [FromQuery] MaintenanceFilterRequestDto filter)
        {
            var result =
                await _maintenanceService
                    .GetPagedMaintenanceRecordsAsync(filter);

            if (!result.Success)
            {
                return BadRequest(new
                {
                    StatusCode = 400,
                    Message = result.Message
                });
            }

            return Ok(result.Data);
        }

        [HttpPost]
        public async Task<IActionResult> AddMaintenanceRecord(
    MaintenanceCreateDto maintenanceCreateDto)
        {
            var result =
                await _maintenanceService
                    .AddMaintenanceRecordAsync(maintenanceCreateDto);

            if (!result.Success)
            {
                return BadRequest(new
                {
                    StatusCode = 400,
                    Message = result.Message
                });
            }

            return Ok(new
            {
                StatusCode = 200,
                Message = result.Message
            });
        }
    }
}