using EF_Code_First_Approach_Demo.Data;
using EF_Code_First_Approach_Demo.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EF_Code_First_Approach_Demo.Repository
{
    public class StudentRepository : IStudentRepository
    {
        private readonly TrainingInstituteDbContext _dbContext;
        public StudentRepository()
        {
            _dbContext = new TrainingInstituteDbContext();
        }
        void AddStudent(Student student)
        {
            try
            {
                _dbContext.Students.Add(student);
                _dbContext.SaveChanges();
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error adding student: {ex.Message}");
            }
           
        }

        void IStudentRepository.AddStudent(Student student)
        {
            AddStudent(student);
        }

        void DeleteStudent(int studentId)
        {
            try
            {
                Student student = GetStudentById(studentId);
                if (student != null)
                {
                    _dbContext.Students.Remove(student);
                    _dbContext.SaveChanges();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error deleting student: {ex.Message}");
            }

               
            }

        void IStudentRepository.DeleteStudent(int studentId)
        {
            DeleteStudent(studentId);
        }

        List<Student> GetAllStudents()
        {
            try
            {
                return _dbContext.Students.ToList();
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error retrieving students: {ex.Message}");
                return new List<Student>();
            }
        }

        List<Student> IStudentRepository.GetAllStudents()
        {
            return GetAllStudents();
        }

        Student GetStudentById(int studentId)
        {
            try
            {
                return _dbContext.Students.Find(studentId);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error retrieving student: {ex.Message}");
                return null;
            }
        }

        Student IStudentRepository.GetStudentById(int student)
        {
            return GetStudentById(student);
        }

        void UpdateStudent(Student student)
        {
            try
            {
                if(student!=null)
                {
                    _dbContext.Entry(student).State = Microsoft.EntityFrameworkCore.EntityState.Modified;
                    _dbContext.SaveChanges();
                }
            }
            catch (Exception ex)
            {

                Console.WriteLine("Error updating student.",ex.Message);
            }
        }

        void IStudentRepository.UpdateStudent(Student student)
        {
            UpdateStudent(student);
        }
    }
}
