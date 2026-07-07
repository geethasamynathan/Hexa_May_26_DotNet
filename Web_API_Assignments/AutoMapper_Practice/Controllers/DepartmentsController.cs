using EmployeeManagementAPI.Dtos;
using EmployeeManagementAPI.Services.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace EmployeeManagementAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DepartmentsController : ControllerBase
    {
        private readonly IDepartmentService _departmentService;

        public DepartmentsController(IDepartmentService departmentService)
        {
            _departmentService = departmentService;
        }

        [HttpGet]
        public async Task<IActionResult> GetAllDepartments()
        {
            var departments = await _departmentService.GetAllDepartmentsAsync();

            return Ok(new
            {
                StatusCode = StatusCodes.Status200OK,
                Message = "Departments retrieved successfully",
                Data = departments
            });
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetDepartmentById(int id)
        {
            if (id <= 0)
            {
                return BadRequest(new
                {
                    StatusCode = StatusCodes.Status400BadRequest,
                    Message = "Invalid department id"
                });
            }

            var department = await _departmentService.GetDepartmentByIdAsync(id);

            if (department == null)
            {
                return NotFound(new
                {
                    StatusCode = StatusCodes.Status404NotFound,
                    Message = "Department not found"
                });
            }

            return Ok(new
            {
                StatusCode = StatusCodes.Status200OK,
                Message = "Department retrieved successfully",
                Data = department
            });
        }

        [HttpPost]
        public async Task<IActionResult> AddDepartment([FromBody] DepartmentCreateDto departmentCreateDto)
        {
            if (departmentCreateDto == null)
            {
                return BadRequest(new
                {
                    StatusCode = StatusCodes.Status400BadRequest,
                    Message = "Department data is required"
                });
            }

            if (string.IsNullOrWhiteSpace(departmentCreateDto.DepartmentName))
            {
                return BadRequest(new
                {
                    StatusCode = StatusCodes.Status400BadRequest,
                    Message = "Department name is required"
                });
            }

            if (string.IsNullOrWhiteSpace(departmentCreateDto.Location))
            {
                return BadRequest(new
                {
                    StatusCode = StatusCodes.Status400BadRequest,
                    Message = "Department location is required"
                });
            }

            var createdDepartment = await _departmentService.AddDepartmentAsync(departmentCreateDto);

            return CreatedAtAction(
                nameof(GetDepartmentById),
                new { id = createdDepartment.DepartmentId },
                new
                {
                    StatusCode = StatusCodes.Status201Created,
                    Message = "Department created successfully",
                    Data = createdDepartment
                });
        }
    }
}