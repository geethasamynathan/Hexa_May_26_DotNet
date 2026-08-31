using FleetMaintenanceApi.DTOs;
using FleetMaintenanceApi.Services.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace FleetMaintenanceApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DriversController : ControllerBase
    {
        private readonly IDriverService _driverService;

        public DriversController(IDriverService driverService)
        {
            _driverService = driverService;
        }

        
        [HttpGet]
        public async Task<IActionResult> GetAllDrivers()
        {
            var drivers = await _driverService.GetAllDriversAsync();

            return Ok(new
            {
                StatusCode = 200,
                Message = "Drivers retrieved successfully",
                Data = drivers
            });
        }

        
        [HttpGet("{id}")]
        public async Task<IActionResult> GetDriverById(int id)
        {
            if (id <= 0)
            {
                return BadRequest(new
                {
                    StatusCode = 400,
                    Message = "Invalid driver id"
                });
            }

            var driver = await _driverService.GetDriverByIdAsync(id);

            if (driver == null)
            {
                return NotFound(new
                {
                    StatusCode = 404,
                    Message = "Driver not found"
                });
            }

            return Ok(new
            {
                StatusCode = 200,
                Data = driver
            });
        }

        
        [HttpPost]
        public async Task<IActionResult> AddDriver(
            DriverCreateDto driverCreateDto)
        {
            var result = await _driverService
                .AddDriverAsync(driverCreateDto);

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
                Message = result.Message,
                Data = result.Data
            });
        }
    }
}
