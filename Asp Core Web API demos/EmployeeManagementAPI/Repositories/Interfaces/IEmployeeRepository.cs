using EmployeeManagementAPI.Models;

namespace EmployeeManagementAPI.Repositories.Interfaces
{
    public interface IEmployeeRepository
    {
        Task<List<Employee>> GetAllEmployeesAsync();

        Task<Employee?> GetEmployeeByIdAsync(int employeeId);

        Task AddEmployeeAsync(Employee employee);

        Task UpdateEmployeeAsync(Employee employee);

        Task DeleteEmployeeAsync(Employee employee);

        Task<bool> EmployeeExistsAsync(int employeeId);
    }
}
