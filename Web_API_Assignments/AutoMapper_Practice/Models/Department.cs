using EmployeeManagementAPI.Models;

namespace EmployeeManagementAPI.Models
{
    public class Department
    {
        public int DepartmentId { get; set; }

        public string DepartmentName { get; set; } = string.Empty;

        public string Location { get; set; } = string.Empty;

        public List<Employee> Employees { get; set; } = new List<Employee>();
    }
}