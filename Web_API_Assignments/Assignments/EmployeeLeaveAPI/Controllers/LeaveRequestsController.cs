using Microsoft.AspNetCore.Mvc;
using EmployeeLeaveAPI.DTOs;
using EmployeeLeaveAPI.Services;

namespace EmployeeLeaveAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LeaveRequestsController : ControllerBase
    {
        private readonly ILeaveRequestService _service;

        public LeaveRequestsController(ILeaveRequestService service)
        {
            _service = service;
        }

        [HttpPost]
        public IActionResult Create([FromBody] LeaveRequestCreateDto dto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (dto.EndDate < dto.StartDate)
            {
                return BadRequest(new { message = "End date cannot be before start date" });
            }

            var result = _service.CreateLeaveRequest(dto);
            return CreatedAtAction(nameof(GetById), new { id = result.LeaveRequestId }, result);
        }

        [HttpGet]
        public IActionResult GetAll()
        {
            var results = _service.GetAllLeaveRequests();
            return Ok(results);
        }

        [HttpGet("{id}")]
        public IActionResult GetById(int id)
        {
            var result = _service.GetLeaveRequestById(id);

            if (result == null)
            {
                return NotFound(new { message = $"Leave request with id {id} not found" });
            }

            return Ok(result);
        }
    }
}