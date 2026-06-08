using EmployeeManagementAPI.DTOs;
using EmployeeManagementAPI.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace EmployeeManagementAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DepartmentsController : ControllerBase
    {
        private readonly IDepartmentService _departmentsService;
        public DepartmentsController(IDepartmentService departmentsService)
        {
            _departmentsService = departmentsService;
        }
        [HttpGet]
        public async Task<IActionResult> GetAllDepartments()
        {
            var departments = await _departmentsService.GetAllDepartmentsAsync();
            return Ok(new
            {
                statusCode = StatusCodes.Status200OK,
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
                    statusCode = StatusCodes.Status400BadRequest,
                    Message = "Invalid department ID"
                });
            }
            var department = await _departmentsService.GetDepartmentByIdAsync(id);
            if (department == null)
            {
                return NotFound(new
                {
                    statusCode = StatusCodes.Status404NotFound,
                    Message = "Department not found"
                });
            }
            return Ok(new
            {
                statusCode = StatusCodes.Status200OK,
                Message = "Department retrieved successfully",
                Data = department
            });
        }

        [HttpPost]
        public async Task<IActionResult> CreateDepartment([FromBody] DepartmentCreateDto departmentCreateDto)
        {
            if (departmentCreateDto == null || string.IsNullOrEmpty(departmentCreateDto.DepartmentName) || string.IsNullOrEmpty(departmentCreateDto.Location))
            {
                return BadRequest(new
                {
                    statusCode = StatusCodes.Status400BadRequest,
                    Message = "Invalid department data"
                });
            }
            var createdDepartment = await _departmentsService.AddDepartmentAsync(departmentCreateDto);

            return CreatedAtAction(nameof(GetDepartmentById), new { id = createdDepartment.DepartmentId }, new
            {
                statusCode = StatusCodes.Status201Created,
                Message = "Department created successfully",
                Data = createdDepartment
            });
        }
           
        
    }
}
