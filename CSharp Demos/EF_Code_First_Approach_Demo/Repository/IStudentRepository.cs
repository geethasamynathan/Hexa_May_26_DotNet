using EF_Code_First_Approach_Demo.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EF_Code_First_Approach_Demo.Repository
{
    public interface IStudentRepository
    {
        List<Student> GetAllStudents();
        Student GetStudentById(int student);
        void AddStudent(Student student);
        void UpdateStudent(Student student); void DeleteStudent(int studentId);
    }
}
