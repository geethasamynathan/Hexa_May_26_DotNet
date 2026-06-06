using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EF_Code_First_Approach_Demo.Models
{
    public class Enrollment
    {
        public int EnrollmentId { get; set; }
        public int StudentId { get; set; }
        public Student? Student { get; set; }

        public int CourseId { get; set; }
        public Course? Course { get; set; }
        public DateTime EnrollmentDate { get; set; }
        public string Status { get; set; } = string.Empty;
    }
}
