using EmployeeManagementAPI.DTOs;

namespace EmployeeManagementAPI.Services
{
    public interface IDepartmentService
    {
        Task<List<DepartmentResponseDto>> GetAllDepartmentsAsync();

        Task<DepartmentResponseDto?> GetDepartmentByIdAsync(int departmentId);

        Task<DepartmentResponseDto> AddDepartmentAsync(DepartmentCreateDto departmentCreateDto);
    }
}
