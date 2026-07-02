using CourseRegistrationAPIDemo.Dtos;
using Microsoft.AspNetCore.Mvc;
using CourseRegistrationAPIDemo.Services;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace CourseRegistrationAPIDemo.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CourseRegistrationsController : ControllerBase
    {
        private readonly ICourseRegistrationService _courseRegistrationService;

        public CourseRegistrationsController(
            ICourseRegistrationService courseRegistrationService)
        {
            _courseRegistrationService = courseRegistrationService;
        }

        [HttpGet]
        public IActionResult GetAllRegistrations()
        {
            var registrations = _courseRegistrationService.GetAllRegistrations();

            return Ok(new
            {
                StatusCode = StatusCodes.Status200OK,
                Message = "Course registrations retrieved successfully",
                Data = registrations
            });
        }

        [HttpGet("{id}")]
        public IActionResult GetRegistrationById(int id)
        {
            if (id <= 0)
            {
                return BadRequest(new
                {
                    StatusCode = StatusCodes.Status400BadRequest,
                    Message = "Invalid course registration id"
                });
            }

            var registration = _courseRegistrationService.GetRegistrationById(id);

            if (registration == null)
            {
                return NotFound(new
                {
                    StatusCode = StatusCodes.Status404NotFound,
                    Message = "Course registration not found"
                });
            }

            return Ok(new
            {
                StatusCode = StatusCodes.Status200OK,
                Message = "Course registration retrieved successfully",
                Data = registration
            });
        }

        [HttpPost]
        public IActionResult CreateRegistration(
            [FromBody] CourseRegistrationCreateDto courseRegistrationCreateDto)
        {
            var createdRegistration = _courseRegistrationService
                .RegisterStudent(courseRegistrationCreateDto);

            return CreatedAtAction(
                nameof(GetRegistrationById),
                new { id = createdRegistration.CourseRegistrationId },
                new
                {
                    StatusCode = StatusCodes.Status201Created,
                    Message = "Course registration created successfully",
                    Data = createdRegistration
                });
        }

        [HttpPut("{id}")]
        public IActionResult UpdateRegistration(
            int id,
            [FromBody] CourseRegistrationUpdateDto courseRegistrationUpdateDto)
        {
            if (id <= 0)
            {
                return BadRequest(new
                {
                    StatusCode = StatusCodes.Status400BadRequest,
                    Message = "Invalid course registration id"
                });
            }

            var updatedRegistration = _courseRegistrationService
                .UpdateRegistration(id, courseRegistrationUpdateDto);

            if (updatedRegistration == null)
            {
                return NotFound(new
                {
                    StatusCode = StatusCodes.Status404NotFound,
                    Message = "Course registration not found"
                });
            }

            return Ok(new
            {
                StatusCode = StatusCodes.Status200OK,
                Message = "Course registration updated successfully",
                Data = updatedRegistration
            });
        }

        [HttpDelete("{id}")]
        public IActionResult DeleteRegistration(int id)
        {
            if (id <= 0)
            {
                return BadRequest(new
                {
                    StatusCode = StatusCodes.Status400BadRequest,
                    Message = "Invalid course registration id"
                });
            }

            bool isDeleted = _courseRegistrationService.DeleteRegistration(id);

            if (!isDeleted)
            {
                return NotFound(new
                {
                    StatusCode = StatusCodes.Status404NotFound,
                    Message = "Course registration not found"
                });
            }

            return Ok(new
            {
                StatusCode = StatusCodes.Status200OK,
                Message = "Course registration deleted successfully"
            });
        }
    }
}

