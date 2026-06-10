using EmployeeLeaveRequestAPI.DTOs;

namespace EmployeeLeaveRequestAPI.Services
{
    public interface ILeaveRequestService
    {
        LeaveRequestResponseDto CreateLeaveRequest(LeaveRequestCreateDto leaveRequestCreateDto);

        List<LeaveRequestResponseDto> GetAllLeaveRequests();

        LeaveRequestResponseDto? GetLeaveRequestById(int id);
    }
}
