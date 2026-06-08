using DemoApi1.Models;

namespace DemoApi1.Services
{
    public interface IEmployeeService
    {
        List<Employee> GetAllEmployees();
        Employee? GetEmployeeById(int id);
        List<Employee> GetEmployeeByName(string name);
        List<Employee> GetEmployeeByCity(string city);
        string AddEmployee(Employee employee);
        string DeleteEmployee(int id);
        string UpdateEmployee(int id, Employee employee);
    }
}
