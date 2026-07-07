using AutoMapper;
using EmployeeManagementAPI.Dtos;
using EmployeeManagementAPI.Models;
using EmployeeManagementAPI.Repository.Interfaces;
using EmployeeManagementAPI.Services.Interfaces;

namespace EmployeeManagementAPI.Services.Implementations
{
    public class EmployeeService : IEmployeeService
    {
        private readonly IEmployeeRepository _employeeRepository;
        private readonly IDepartmentRepository _departmentRepository;
        private readonly IMapper _mapper;
        public EmployeeService(
            IEmployeeRepository employeeRepository,
            IDepartmentRepository departmentRepository, IMapper mapper)
        {
            _employeeRepository = employeeRepository;
            _departmentRepository = departmentRepository;
            _mapper = mapper;
        }

        public async Task<List<EmployeeResponseDto>> GetAllEmployeesAsync()
        {
            var employees = await _employeeRepository.GetAllEmployeesAsync();

            //var employeeResponseDtos = employees.Select(employee => new EmployeeResponseDto
            //{
            //    EmployeeId = employee.EmployeeId,
            //    EmployeeName = employee.EmployeeName,
            //    Gender = employee.Gender,
            //    Salary = employee.Salary,
            //    City = employee.City,
            //    DepartmentId = employee.DepartmentId,
            //    DepartmentName = employee.Department != null
            //        ? employee.Department.DepartmentName
            //        : string.Empty
            //}).ToList();

            //return employeeResponseDtos;
            return _mapper.Map<List<EmployeeResponseDto>>(employees);
        }

        public async Task<EmployeeResponseDto?> GetEmployeeByIdAsync(int employeeId)
        {
            var employee = await _employeeRepository.GetEmployeeByIdAsync(employeeId);

            if (employee == null)
            {
                return null;
            }

            //var employeeResponseDto = new EmployeeResponseDto
            //{
            //    EmployeeId = employee.EmployeeId,
            //    EmployeeName = employee.EmployeeName,
            //    Gender = employee.Gender,
            //    Salary = employee.Salary,
            //    City = employee.City,
            //    DepartmentId = employee.DepartmentId,
            //    DepartmentName = employee.Department != null
            //        ? employee.Department.DepartmentName
            //        : string.Empty
            //};

            //return employeeResponseDto;

            return _mapper.Map<EmployeeResponseDto>(employee);
        }

        public async Task<(bool Success, string Message, EmployeeResponseDto? Data)> AddEmployeeAsync(
            EmployeeCreateDto employeeCreateDto)
        {
            if (string.IsNullOrWhiteSpace(employeeCreateDto.EmployeeName))
            {
                return (false, "Employee name is required", null);
            }

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

            //var employee = new Employee
            //{
            //    EmployeeName = employeeCreateDto.EmployeeName,
            //    Gender = employeeCreateDto.Gender,
            //    Salary = employeeCreateDto.Salary,
            //    City = employeeCreateDto.City,
            //    DepartmentId = employeeCreateDto.DepartmentId
            //};

            var employee = _mapper.Map<Employee>(employeeCreateDto);
            await _employeeRepository.AddEmployeeAsync(employee);

            var savedEmployee = await _employeeRepository.GetEmployeeByIdAsync(employee.EmployeeId);

            if (savedEmployee == null)
            {
                return (false, "Employee creation failed", null);
            }

            //var employeeResponseDto = new EmployeeResponseDto
            //{
            //    EmployeeId = savedEmployee.EmployeeId,
            //    EmployeeName = savedEmployee.EmployeeName,
            //    Gender = savedEmployee.Gender,
            //    Salary = savedEmployee.Salary,
            //    City = savedEmployee.City,
            //    DepartmentId = savedEmployee.DepartmentId,
            //    DepartmentName = savedEmployee.Department != null
            //        ? savedEmployee.Department.DepartmentName
            //        : string.Empty
            //};

            //return (true, "Employee created successfully", employeeResponseDto);
            return _mapper.Map<EmployeeResponseDto>(savedEmployee) is EmployeeResponseDto employeeResponseDto
                ? (true, "Employee created successfully", employeeResponseDto)
                : (false, "Employee creation failed", null);
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

            if (string.IsNullOrWhiteSpace(employeeUpdateDto.EmployeeName))
            {
                return (false, "Employee name is required", null);
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
            _mapper.Map(employeeUpdateDto, employee);
            //employee.EmployeeName = employeeUpdateDto.EmployeeName;
            //employee.Gender = employeeUpdateDto.Gender;
            //employee.Salary = employeeUpdateDto.Salary;
            //employee.City = employeeUpdateDto.City;
            //employee.DepartmentId = employeeUpdateDto.DepartmentId;

            await _employeeRepository.UpdateEmployeeAsync(employee);

            var updatedEmployee = await _employeeRepository.GetEmployeeByIdAsync(employee.EmployeeId);

            if (updatedEmployee == null)
            {
                return (false, "Employee update failed", null);
            }

            //var employeeResponseDto = new EmployeeResponseDto
            //{
            //    EmployeeId = updatedEmployee.EmployeeId,
            //    EmployeeName = updatedEmployee.EmployeeName,
            //    Gender = updatedEmployee.Gender,
            //    Salary = updatedEmployee.Salary,
            //    City = updatedEmployee.City,
            //    DepartmentId = updatedEmployee.DepartmentId,
            //    DepartmentName = updatedEmployee.Department != null
            //        ? updatedEmployee.Department.DepartmentName
            //        : string.Empty
            //};

            //return (true, "Employee updated successfully", employeeResponseDto);

            var response = _mapper.Map<EmployeeResponseDto>(updatedEmployee);
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