using EmployeeManagementAPI.DTOs;
using EmployeeManagementAPI.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace EmployeeManagementAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EmployeesController : ControllerBase
    {
        private readonly IEmployeeService _employeeService;
        public EmployeesController(IEmployeeService employeeService)
        {
            _employeeService = employeeService;
        }

        [HttpGet]
        public async Task<IActionResult> GetAllEmployees()
        {
            var employees = await _employeeService.GetAllEmployeesAsync();
            if (employees == null)
            {
                return NotFound(new
                {
                    statusCode = StatusCodes.Status404NotFound,
                    Message = "No employees found"
                });
            }
            return Ok(new
            {
                statusCode = StatusCodes.Status200OK,
                Message = "Employees retrieved successfully",
                Data = employees
            });
        }
        [HttpGet("{id}")]
        public async Task<IActionResult> GetEmployeeById(int id)
        {
            if (id <= 0)
            {
                return BadRequest(new
                {
                    statusCode = StatusCodes.Status400BadRequest,
                    Message = "Invalid employee ID"
                });
            }
            var employee = await _employeeService.GetEmployeeByIdAsync(id);
            if (employee == null)
            {
                return NotFound(new
                {
                    statusCode = StatusCodes.Status404NotFound,
                    Message = "Employee not found"
                });
            }
            return Ok(new
            {
                statusCode = StatusCodes.Status200OK,
                Message = "Employee retrieved successfully",
                Data = employee
            });
        }

        [HttpPost]
        public async Task<IActionResult> CreateEmployee([FromBody] EmployeeCreateDto employeeCreateDto)
        {
            if (string.IsNullOrWhiteSpace(employeeCreateDto.EmployeeName))
            {
                return BadRequest(new
                {
                    StatusCode = StatusCodes.Status400BadRequest,
                    Message = "Employee name is required"
                });
            }

            if (string.IsNullOrWhiteSpace(employeeCreateDto.Gender))
            {
                return BadRequest(new
                {
                    StatusCode = StatusCodes.Status400BadRequest,
                    Message = "Gender is required"
                });
            }

            if (string.IsNullOrWhiteSpace(employeeCreateDto.City))
            {
                return BadRequest(new
                {
                    StatusCode = StatusCodes.Status400BadRequest,
                    Message = "City is required"
                });
            }

            var result = await _employeeService.AddEmployeeAsync(employeeCreateDto);

            if (!result.Success)
            {
                if (result.Message == "Department not found")
                {
                    return NotFound(new
                    {
                        StatusCode = StatusCodes.Status404NotFound,
                        Message = result.Message
                    });
                }

                return BadRequest(new
                {
                    StatusCode = StatusCodes.Status400BadRequest,
                    Message = result.Message
                });
            }

            return CreatedAtAction(
                nameof(GetEmployeeById),
                new { id = result.Data!.EmployeeId },
                new
                {
                    StatusCode = StatusCodes.Status201Created,
                    Message = result.Message,
                    Data = result.Data
                });
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateEmployee(int id, EmployeeUpdateDto employeeUpdateDto)
        {
            if (id <= 0)
            {
                return BadRequest(new
                {
                    StatusCode = StatusCodes.Status400BadRequest,
                    Message = "Invalid employee ID"
                });
            }
            var result = await _employeeService.UpdateEmployeeAsync(id, employeeUpdateDto);

            if (!result.Success)
            {
                if (result.Message == "Employee not found" ||
                    result.Message == "Department not found")
                {
                    return NotFound(new
                    {
                        StatusCode = StatusCodes.Status404NotFound,
                        Message = result.Message
                    });
                }

                return BadRequest(new
                {
                    StatusCode = StatusCodes.Status400BadRequest,
                    Message = result.Message
                });
            }

            return Ok(new
            {
                StatusCode = StatusCodes.Status200OK,
                Message = result.Message,
                Data = result.Data
            });
        }
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteEmployee(int id)
        {
            if (id <= 0)
            {
                return BadRequest(new
                {
                    StatusCode = StatusCodes.Status400BadRequest,
                    Message = "Invalid employee id"
                });
            }

            var result = await _employeeService.DeleteEmployeeAsync(id);

            if (!result.Success)
            {
                return NotFound(new
                {
                    StatusCode = StatusCodes.Status404NotFound,
                    Message = result.Message
                });
            }

            return Ok(new
            {
                StatusCode = StatusCodes.Status200OK,
                Message = result.Message
            });
        }
    }
}
