using FleetMaintenanceApi.DTOs;
using FleetMaintenanceApi.Services.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace FleetMaintenanceApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class VehiclesController : ControllerBase
    {
        private readonly IVehicleService _vehicleService;
        public VehiclesController(IVehicleService vehicleService)
        {
            _vehicleService = vehicleService;
        }
        [HttpGet]
        public async Task<IActionResult> GetAllVehicles()
        {
            var vehicles = await _vehicleService.GetAllVehiclesAsync();

            return Ok(new
            {
                StatusCode = 200,
                Message = "Vehicles retrieved successfully",
                Data = vehicles
            });
        }
        [HttpGet("{id}")]
        public async Task<IActionResult> GetVehicleById(int id)
        {
            if (id <= 0)
            {
                return BadRequest(new
                {
                    StatusCode = 400,
                    Message = "Invalid vehicle id"
                });
            }

            var vehicle = await _vehicleService.GetVehicleByIdAsync(id);

            if (vehicle == null)
            {
                return NotFound(new
                {
                    StatusCode = 404,
                    Message = "Vehicle not found"
                });
            }

            return Ok(new
            {
                StatusCode = 200,
                Data = vehicle
            });
        }
        [HttpPost]
        public async Task<IActionResult> AddVehicle(
    VehicleCreateDto vehicleCreateDto)
        {
            var result =
                await _vehicleService.AddVehicleAsync(vehicleCreateDto);

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
