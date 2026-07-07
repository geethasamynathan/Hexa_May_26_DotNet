using EmployeeManagementAPI.Dtos;

namespace EmployeeManagementAPI.Services.Interfaces
{
    public interface IEmployeeService
    {
        Task<List<EmployeeResponseDto>> GetAllEmployeesAsync();

        Task<EmployeeResponseDto?> GetEmployeeByIdAsync(int employeeId);

        Task<(bool Success, string Message, EmployeeResponseDto? Data)> AddEmployeeAsync(EmployeeCreateDto employeeCreateDto);

        Task<(bool Success, string Message, EmployeeResponseDto? Data)> UpdateEmployeeAsync(int employeeId, EmployeeUpdateDto employeeUpdateDto);

        Task<(bool Success, string Message)> DeleteEmployeeAsync(int employeeId);
    }
}