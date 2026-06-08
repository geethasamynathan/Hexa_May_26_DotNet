using DemoApi1.Models;

namespace DemoApi1.Services
{
    public class EmployeeService:IEmployeeService
    {
        private static List<Employee> employees = new List<Employee>
        {
            new Employee
            {
                EmployeeId=1,Name="Arun",Gender="Male",Salary=35000,City="Chennai"
            },
            new Employee
            {
                EmployeeId=2,Name="Priya",Gender="Female",Salary=50000,City="Mumbai"

            },
            new Employee
            {
                EmployeeId=3,Name="Meena",Gender="Female",Salary=40000,City="Chennai"
            },
            new Employee
            {
                EmployeeId=4,Name="Vishal",Gender="Male",Salary=70000,City="Coimbatore"
            }
        };
        public List<Employee> GetAllEmployees()
        {
            return employees;
        }

        public Employee? GetEmployeeById(int id)
        {
            Employee? employee = employees.FirstOrDefault(emp => emp.EmployeeId == id);
            return employee;
        }
        public List<Employee> GetEmployeeByName(string name)
        {
            List<Employee> result = employees.Where(e => e.Name.ToLower().Contains(name.ToLower())).ToList();
            return result;
        }

        public List<Employee> GetEmployeeByCity(string city)
        {
            List<Employee> result = employees.Where(e => e.City.ToLower().Contains(city.ToLower())).ToList();
            return result;
        }

        public string AddEmployee(Employee employee)
        {
            if (string.IsNullOrWhiteSpace(employee.Name))
            {
                return "Employee name is Required.";
            }
            if(string.IsNullOrWhiteSpace(employee.Gender))
            { return "Employee Gender is Required. ";
            }
            if(employee.Salary<=0)
            {
                return "Salary must be greater than 0.";
            }
            if(string.IsNullOrWhiteSpace(employee.City))
            {
                return "City is Required";
            }
            int newEmployeeId;
            if(employees.Count==0)
            {
                newEmployeeId = 1;
            }
            else
            { newEmployeeId = employees.Max(e => e.EmployeeId)+1;
            }

            employee.EmployeeId = newEmployeeId;
            employees.Add(employee);
            return "Employee Addedd succussfully";
        }
        public string UpdateEmployee(int id, Employee employee)
        {
            Employee? existingEmployee = employees.FirstOrDefault(e => e.EmployeeId == id);

            if (existingEmployee == null)
            {
                return "Employee not found.";
            }

            if (string.IsNullOrWhiteSpace(employee.Name))
            {
                return "Employee name is required.";
            }

            if (string.IsNullOrWhiteSpace(employee.Gender))
            {
                return "Gender is required.";
            }

            if (employee.Salary <= 0)
            {
                return "Salary must be greater than zero.";
            }

            if (string.IsNullOrWhiteSpace(employee.City))
            {
                return "City is required.";
            }

            existingEmployee.Name = employee.Name;
            existingEmployee.Gender = employee.Gender;
            existingEmployee.Salary = employee.Salary;
            existingEmployee.City = employee.City;

            return "Employee updated successfully.";
        }

        public string DeleteEmployee(int id)
        {
            Employee? employee = employees.FirstOrDefault(e => e.EmployeeId == id);

            if (employee == null)
            {
                return "Employee not found.";
            }

            employees.Remove(employee);

            return "Employee deleted successfully.";
        }

    }
}
