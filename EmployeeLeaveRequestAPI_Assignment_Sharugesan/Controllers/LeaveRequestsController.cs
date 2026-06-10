using EmployeeLeaveRequestAPI.DTOs;
using EmployeeLeaveRequestAPI.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace EmployeeLeaveRequestAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LeaveRequestsController : ControllerBase
    {
        private readonly ILeaveRequestService _leaveRequestService;
        public LeaveRequestsController(ILeaveRequestService leaveRequestService)
        {
            _leaveRequestService = leaveRequestService;
        }

        [HttpPost]
        public IActionResult CreateLeaveRequest([FromBody] LeaveRequestCreateDto leaveRequest)
        {
            var result =_leaveRequestService.CreateLeaveRequest(leaveRequest);
            return Created("", new
            {
                Message = "Leave request created successfully.",
                Data = result
            });
        }


        [HttpGet]
        public IActionResult GetAllLeaveRequests()
        {
            var result = _leaveRequestService.GetAllLeaveRequests();
            return Ok(result);
        }

        [HttpGet("{id}")]
        public IActionResult GetLeaveRequestById(int id) 
        {
            var result = _leaveRequestService.GetLeaveRequestById(id);
            if (result == null)
            {
                return NotFound(new
                {
                    Message = "Request Not Found."
                });
            }
            return Ok(result);
        }
    }
}
