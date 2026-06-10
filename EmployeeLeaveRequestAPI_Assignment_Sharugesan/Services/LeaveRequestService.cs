using EmployeeLeaveRequestAPI.DTOs;
using EmployeeLeaveRequestAPI.Models;

namespace EmployeeLeaveRequestAPI.Services
{
    public class LeaveRequestService : ILeaveRequestService
    {
        private static readonly List<LeaveRequest> leaveRequests = new();

        private LeaveRequestResponseDto MapToResponseDto(LeaveRequest leaveRequest)
        {

            return new LeaveRequestResponseDto
            {
                LeaveRequestId = leaveRequest.LeaveRequestId,
                EmployeeName = leaveRequest.EmployeeName,
                EmployeeEmail = leaveRequest.EmployeeEmail,
                LeaveType = leaveRequest.LeaveType,
                StartDate = leaveRequest.StartDate,
                EndDate = leaveRequest.EndDate,
                Reason = leaveRequest.Reason,
                TotalDays = leaveRequest.TotalDays,
                Status = leaveRequest.Status,
                CreatedOn = leaveRequest.CreatedOn
            };
        }

        public LeaveRequestResponseDto CreateLeaveRequest(LeaveRequestCreateDto dto)
        {
            
            var leaveRequest = new LeaveRequest
            {
                LeaveRequestId = leaveRequests.Count + 1,
                EmployeeName = dto.EmployeeName,
                EmployeeEmail = dto.EmployeeEmail,
                MobileNumber = dto.MobileNumber,
                LeaveType = dto.LeaveType,
                StartDate = dto.StartDate,
                EndDate = dto.EndDate,
                Reason = dto.Reason,
                TotalDays = (dto.EndDate.Date - dto.StartDate.Date).Days + 1,
                Status = "Pending",
                CreatedOn = DateTime.Now
            };

            leaveRequests.Add(leaveRequest);

            return MapToResponseDto(leaveRequest);
        }

        public List<LeaveRequestResponseDto> GetAllLeaveRequests()
        {
            return leaveRequests
                .Select(MapToResponseDto)
                .ToList();
        }

        public LeaveRequestResponseDto? GetLeaveRequestById(int id)
        {
            var leaveRequest = leaveRequests
                .FirstOrDefault(lr => lr.LeaveRequestId == id);

            if (leaveRequest == null)
            {
                return null;
            }

            return MapToResponseDto(leaveRequest);
        }
    }
}