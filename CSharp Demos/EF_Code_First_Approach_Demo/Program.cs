using EF_Code_First_Approach_Demo.Repository;
using EF_Code_First_Approach_Demo.Services;
using EF_Code_First_Approach_Demo.Models;
namespace EF_Code_First_Approach_Demo
{
    internal class Program
    {
        static void Main(string[] args)
        {
            StudentService studentService = new StudentService(new StudentRepository());
            Console.WriteLine("Enter the new student Details");
            Console.WriteLine("Enter the student name:");
            Student student=new Student();
            //student.StudentName = Console.ReadLine();
            //Console.WriteLine("Enter the student email:");
            //student.Email = Console.ReadLine();
            //Console.WriteLine("Enter the student mobile number:");
            //student.MobileNumber = Console.ReadLine();

            //studentService.AddStudent(student);

            //var students = studentService.GetAllStudents();
            //foreach (Student stu in students)
            //{
            //    Console.WriteLine($"ID: {stu.StudentId}, Name: {stu.StudentName}, Email: {stu.Email}, Mobile: {stu.MobileNumber}");
            //}
            //Console.WriteLine();
            //Console.WriteLine("Entrer the student ID to delete:");
            //int studentId =Convert.ToInt32(Console.ReadLine());

            //studentService.DeleteStudent(studentId);
            //Console.WriteLine("After Delete:");
            //var existingStudents = studentService.GetAllStudents();
            //foreach (Student stu in existingStudents)
            //{
            //    Console.WriteLine($"ID: {stu.StudentId}, Name: {stu.StudentName}, Email: {stu.Email}, Mobile: {stu.MobileNumber}");
            //}
            Console.WriteLine();

            Console.WriteLine("Enter the student Id to update:");
            student.StudentId = Convert.ToInt32(Console.ReadLine());
            Console.WriteLine("Ente the  student name to update");
            student.StudentName = Console.ReadLine();
            Console.WriteLine("Enter the student email to update:");
            student.Email = Console.ReadLine();
            Console.WriteLine("Enter the student mobile number to update:");
            student.MobileNumber = Console.ReadLine();
            studentService.UpdateStudent(student);

            Console.WriteLine("After Update:");
            var updatedStudents = studentService.GetAllStudents();
            foreach (Student stu in updatedStudents)
            {
                Console.WriteLine($"ID: {stu.StudentId}, Name: {stu.StudentName}, Email: {stu.Email}, Mobile: {stu.MobileNumber}");
            }

            Console.ReadLine();
        }
    }
}
