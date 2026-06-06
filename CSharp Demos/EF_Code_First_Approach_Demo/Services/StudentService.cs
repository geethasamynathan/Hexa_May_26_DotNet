using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EF_Code_First_Approach_Demo.Models;
using EF_Code_First_Approach_Demo.Repository;
namespace EF_Code_First_Approach_Demo.Services
{
    public class StudentService
    {
        private readonly IStudentRepository _studentRepository;
        public StudentService(IStudentRepository studentRepository)
        {
            _studentRepository = studentRepository;
        }
        public List<Student> GetAllStudents()
        {
            return _studentRepository.GetAllStudents();
        }
        public Student GetStudentById(int studentId)
        {
            return _studentRepository.GetStudentById(studentId);
        }
        public void AddStudent(Student student)
        {
            _studentRepository.AddStudent(student);

        }
        public void DeleteStudent(int studentId)
        {
            _studentRepository.DeleteStudent(studentId);
        }
        public void UpdateStudent(Student student)
        {
            _studentRepository.UpdateStudent(student);
        }
    }
}
