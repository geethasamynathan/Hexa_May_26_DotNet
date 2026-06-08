using EmployeeManagementAPI.DTOs;
using EmployeeManagementAPI.Models;
using EmployeeManagementAPI.Repositories.Interfaces;

namespace EmployeeManagementAPI.Services
{
    public class EmployeeService : IEmployeeService
    {
        private readonly IEmployeeRepository _employeeRepository;
        private readonly IDepartmentRepository _departmentRepository;

        public EmployeeService(
            IEmployeeRepository employeeRepository,
            IDepartmentRepository departmentRepository)
        {
            _employeeRepository = employeeRepository;
            _departmentRepository = departmentRepository;
        }

        public async Task<List<EmployeeResponseDto>> GetAllEmployeesAsync()
        {
            var employees = await _employeeRepository.GetAllEmployeesAsync();

            return employees.Select(e => new EmployeeResponseDto
            {
                EmployeeId = e.EmployeeId,
                EmployeeName = e.EmployeeName,
                Gender = e.Gender,
                Salary = e.Salary,
                City = e.City,
                DepartmentId = e.DepartmentId,
                DepartmentName = e.Department?.DepartmentName ?? string.Empty
            }).ToList();
        }

        public async Task<EmployeeResponseDto?> GetEmployeeByIdAsync(int employeeId)
        {
            var employee = await _employeeRepository.GetEmployeeByIdAsync(employeeId);

            if (employee == null)
            {
                return null;
            }

            return new EmployeeResponseDto
            {
                EmployeeId = employee.EmployeeId,
                EmployeeName = employee.EmployeeName,
                Gender = employee.Gender,
                Salary = employee.Salary,
                City = employee.City,
                DepartmentId = employee.DepartmentId,
                DepartmentName = employee.Department?.DepartmentName ?? string.Empty
            };
        }

        public async Task<(bool Success, string Message, EmployeeResponseDto? Data)> AddEmployeeAsync(EmployeeCreateDto employeeCreateDto)
        {
            if (employeeCreateDto.DepartmentId <= 0)
            {
                return (false, "Invalid department id", null);
            }

            bool departmentExists = await _departmentRepository
                .DepartmentExistsAsync(employeeCreateDto.DepartmentId);

            if (!departmentExists)
            {
                return (false, "Department not found", null);
            }

            if (employeeCreateDto.Salary <= 0)
            {
                return (false, "Salary must be greater than zero", null);
            }

            var employee = new Employee
            {
                EmployeeName = employeeCreateDto.EmployeeName,
                Gender = employeeCreateDto.Gender,
                Salary = employeeCreateDto.Salary,
                City = employeeCreateDto.City,
                DepartmentId = employeeCreateDto.DepartmentId
            };

            await _employeeRepository.AddEmployeeAsync(employee);

            var department = await _departmentRepository
                .GetDepartmentByIdAsync(employee.DepartmentId);

            var response = new EmployeeResponseDto
            {
                EmployeeId = employee.EmployeeId,
                EmployeeName = employee.EmployeeName,
                Gender = employee.Gender,
                Salary = employee.Salary,
                City = employee.City,
                DepartmentId = employee.DepartmentId,
                DepartmentName = department?.DepartmentName ?? string.Empty
            };

            return (true, "Employee created successfully", response);
        }

        public async Task<(bool Success, string Message, EmployeeResponseDto? Data)> UpdateEmployeeAsync(
            int employeeId,
            EmployeeUpdateDto employeeUpdateDto)
        {
            var employee = await _employeeRepository.GetEmployeeByIdAsync(employeeId);

            if (employee == null)
            {
                return (false, "Employee not found", null);
            }

            bool departmentExists = await _departmentRepository
                .DepartmentExistsAsync(employeeUpdateDto.DepartmentId);

            if (!departmentExists)
            {
                return (false, "Department not found", null);
            }

            if (employeeUpdateDto.Salary <= 0)
            {
                return (false, "Salary must be greater than zero", null);
            }

            employee.EmployeeName = employeeUpdateDto.EmployeeName;
            employee.Gender = employeeUpdateDto.Gender;
            employee.Salary = employeeUpdateDto.Salary;
            employee.City = employeeUpdateDto.City;
            employee.DepartmentId = employeeUpdateDto.DepartmentId;

            await _employeeRepository.UpdateEmployeeAsync(employee);

            var department = await _departmentRepository
                .GetDepartmentByIdAsync(employee.DepartmentId);

            var response = new EmployeeResponseDto
            {
                EmployeeId = employee.EmployeeId,
                EmployeeName = employee.EmployeeName,
                Gender = employee.Gender,
                Salary = employee.Salary,
                City = employee.City,
                DepartmentId = employee.DepartmentId,
                DepartmentName = department?.DepartmentName ?? string.Empty
            };

            return (true, "Employee updated successfully", response);
        }

        public async Task<(bool Success, string Message)> DeleteEmployeeAsync(int employeeId)
        {
            var employee = await _employeeRepository.GetEmployeeByIdAsync(employeeId);

            if (employee == null)
            {
                return (false, "Employee not found");
            }

            await _employeeRepository.DeleteEmployeeAsync(employee);

            return (true, "Employee deleted successfully");
        }
    }
    
    }

