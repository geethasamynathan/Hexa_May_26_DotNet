using DemoApi1.Models;
using DemoApi1.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace DemoApi1.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EmployeeController : ControllerBase
    {
        private readonly IEmployeeService _employeeService;
        public EmployeeController(IEmployeeService employeeService)
        {
            _employeeService = employeeService;
        }

        [HttpGet]
        public IActionResult GetAllEmployees()
        {
            List<Employee> employees = _employeeService.GetAllEmployees();

            return Ok(employees);
        }

        [HttpGet("{id}")]
        public IActionResult GetEmployeeById(int id)
        {
            Employee? employee = _employeeService.GetEmployeeById(id);

            if (employee == null)
            {
                return NotFound("Employee not found.");
            }

            return Ok(employee);
        }

        [HttpGet("search-by-name/{name}")]
        public IActionResult GetEmployeeByName(string name)
        {
            List<Employee> employees = _employeeService.GetEmployeeByName(name);

            if (employees.Count == 0)
            {
                return NotFound("No employee found with this name.");
            }

            return Ok(employees);
        }

        [HttpGet("search-by-city/{city}")]
        public IActionResult GetEmployeeByCity(string city)
        {
            List<Employee> employees = _employeeService.GetEmployeeByCity(city);

            if (employees.Count == 0)
            {
                return NotFound("No employee found in this city.");
            }

            return Ok(employees);
        }

        [HttpPost]
        public IActionResult AddEmployee(Employee employee)
        {
            string result = _employeeService.AddEmployee(employee);

            if (result != "Employee Addedd succussfully")
            {
                return BadRequest(result);
            }

            return Ok(result);
        }

        [HttpPut("{id}")]
        public IActionResult UpdateEmployee(int id, Employee employee)
        {
            string result = _employeeService.UpdateEmployee(id, employee);

            if (result == "Employee not found.")
            {
                return NotFound(result);
            }

            if (result != "Employee updated successfully.")
            {
                return BadRequest(result);
            }

            return Ok(result);
        }

        [HttpDelete("{id}")]
        public IActionResult DeleteEmployee(int id)
        {
            string result = _employeeService.DeleteEmployee(id);

            if (result == "Employee not found.")
            {
                return NotFound(result);
            }

            return Ok(result);
        }
    }
}
