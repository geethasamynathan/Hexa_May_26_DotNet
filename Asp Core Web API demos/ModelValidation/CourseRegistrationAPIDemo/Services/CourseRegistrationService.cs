using CourseRegistrationAPIDemo.Dtos;
using CourseRegistrationAPIDemo.Models;

namespace CourseRegistrationAPIDemo.Services
{
    public class CourseRegistrationService : ICourseRegistrationService
    {
        private static readonly List<CourseRegistration> Registrations = new();

        private static int _nextId = 1;

        public List<CourseRegistrationResponseDto> GetAllRegistrations()
        {
            return Registrations
                .Select(registration => MapToResponseDto(registration))
                .ToList();
        }

        public CourseRegistrationResponseDto? GetRegistrationById(int id)
        {
            var registration = Registrations
                .FirstOrDefault(r => r.CourseRegistrationId == id);

            if (registration == null)
            {
                return null;
            }

            return MapToResponseDto(registration);
        }

        public CourseRegistrationResponseDto RegisterStudent(
            CourseRegistrationCreateDto courseRegistrationCreateDto)
        {
            var registration = new CourseRegistration
            {
                CourseRegistrationId = _nextId++,
                StudentName = courseRegistrationCreateDto.StudentName,
                Email = courseRegistrationCreateDto.Email,
                MobileNumber = courseRegistrationCreateDto.MobileNumber,
                Age = courseRegistrationCreateDto.Age,
                CourseName = courseRegistrationCreateDto.CourseName,
                PaymentAmount = courseRegistrationCreateDto.PaymentAmount,
                TrainingMode = courseRegistrationCreateDto.TrainingMode,
                Location = courseRegistrationCreateDto.Location ?? string.Empty,
                CourseStartDate = courseRegistrationCreateDto.CourseStartDate,
                RegisteredOn = DateTime.Now
            };

            Registrations.Add(registration);

            return MapToResponseDto(registration);
        }

        public CourseRegistrationResponseDto? UpdateRegistration(
            int id,
            CourseRegistrationUpdateDto courseRegistrationUpdateDto)
        {
            var registration = Registrations
                .FirstOrDefault(r => r.CourseRegistrationId == id);

            if (registration == null)
            {
                return null;
            }

            registration.StudentName = courseRegistrationUpdateDto.StudentName;
            registration.Email = courseRegistrationUpdateDto.Email;
            registration.MobileNumber = courseRegistrationUpdateDto.MobileNumber;
            registration.Age = courseRegistrationUpdateDto.Age;
            registration.CourseName = courseRegistrationUpdateDto.CourseName;
            registration.PaymentAmount = courseRegistrationUpdateDto.PaymentAmount;
            registration.TrainingMode = courseRegistrationUpdateDto.TrainingMode;
            registration.Location = courseRegistrationUpdateDto.Location ?? string.Empty;
            registration.CourseStartDate = courseRegistrationUpdateDto.CourseStartDate;

            return MapToResponseDto(registration);
        }

        public bool DeleteRegistration(int id)
        {
            var registration = Registrations
                .FirstOrDefault(r => r.CourseRegistrationId == id);

            if (registration == null)
            {
                return false;
            }

            Registrations.Remove(registration);

            return true;
        }

        public void ClearRegistrationsForTesting()
        {
            Registrations.Clear();
            _nextId = 1;
        }

        private static CourseRegistrationResponseDto MapToResponseDto(
            CourseRegistration registration)
        {
            return new CourseRegistrationResponseDto
            {
                CourseRegistrationId = registration.CourseRegistrationId,
                StudentName = registration.StudentName,
                Email = registration.Email,
                MobileNumber = registration.MobileNumber,
                Age = registration.Age,
                CourseName = registration.CourseName,
                PaymentAmount = registration.PaymentAmount,
                TrainingMode = registration.TrainingMode,
                Location = registration.Location,
                CourseStartDate = registration.CourseStartDate,
                RegisteredOn = registration.RegisteredOn
            };
        }
    }
    }
    

