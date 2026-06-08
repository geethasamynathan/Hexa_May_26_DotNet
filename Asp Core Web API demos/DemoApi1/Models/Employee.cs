namespace DemoApi1.Models
{
    public class Employee
    {
        public int EmployeeId { get; set; }
        public string Name { get; set; } = string.Empty;
        public string Gender  { get; set; }=string.Empty;
        public decimal Salary { get; set; }
        public string  City { get; set; }=string.Empty;
    }
}
