using EmployeeManagementAPI.Models;

namespace EmployeeManagementAPI.Repository.Interfaces
{
    public interface IDepartmentRepository
    {
        Task<List<Department>> GetAllDepartmentsAsync();

        Task<Department?> GetDepartmentByIdAsync(int departmentId);

        Task AddDepartmentAsync(Department department);

        Task<bool> DepartmentExistsAsync(int departmentId);
    }
}