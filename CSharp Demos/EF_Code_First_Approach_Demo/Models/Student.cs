using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EF_Code_First_Approach_Demo.Models
{
    public class Student
    {
       // [Key]
        public int StudentId { get; set; }
        public string StudentName { get; set; } = string.Empty;
        public string Email { get; set; }
        public string MobileNumber { get; set; } = string.Empty;

        public List<Enrollment> Enrollments { get; set; }
    }
}
