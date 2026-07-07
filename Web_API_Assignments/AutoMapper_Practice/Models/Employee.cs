namespace EmployeeManagementAPI.Models
{
    public class Employee
    {
        public int EmployeeId { get; set; }

        public string EmployeeName { get; set; } = string.Empty;

        public string Gender { get; set; } = string.Empty;

        public decimal Salary { get; set; }

        public string City { get; set; } = string.Empty;

        public int DepartmentId { get; set; }

        public Department? Department { get; set; }

    }
}