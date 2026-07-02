using CourseRegistrationAPIDemo.Models;
using CourseRegistrationAPIDemo.Dtos;


namespace CourseRegistrationAPIDemo.Services
{
    public interface ICourseRegistrationService
    {

        List<CourseRegistrationResponseDto> GetAllRegistrations();

        CourseRegistrationResponseDto? GetRegistrationById(int id);

        CourseRegistrationResponseDto RegisterStudent(
            CourseRegistrationCreateDto courseRegistrationCreateDto);

        CourseRegistrationResponseDto? UpdateRegistration(
            int id,
            CourseRegistrationUpdateDto courseRegistrationUpdateDto);

        bool DeleteRegistration(int id);

        void ClearRegistrationsForTesting();

    }

}

