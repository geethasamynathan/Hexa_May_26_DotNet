using EmployeeLeaveAPI.DTOs;
using EmployeeLeaveAPI.Models;

namespace EmployeeLeaveAPI.Services
{
    public class LeaveRequestService : ILeaveRequestService
    {
        private static List<LeaveRequest> _requests = new List<LeaveRequest>();
        private static int _nextId = 1;

        public LeaveRequestResponseDto CreateLeaveRequest(LeaveRequestCreateDto dto)
        {
            int totalDays = (dto.EndDate - dto.StartDate).Days + 1;

            var request = new LeaveRequest
            {
                LeaveRequestId = _nextId++,
                EmployeeName = dto.EmployeeName,
                EmployeeEmail = dto.EmployeeEmail,
                MobileNumber = dto.MobileNumber,
                LeaveType = dto.LeaveType,
                StartDate = dto.StartDate,
                EndDate = dto.EndDate,
                Reason = dto.Reason,
                TotalDays = totalDays,
                Status = "Pending",
                CreatedOn = DateTime.Now
            };

            _requests.Add(request);

            var response = new LeaveRequestResponseDto
            {
                LeaveRequestId = request.LeaveRequestId,
                EmployeeName = request.EmployeeName,
                EmployeeEmail = request.EmployeeEmail,
                LeaveType = request.LeaveType,
                StartDate = request.StartDate,
                EndDate = request.EndDate,
                Reason = request.Reason,
                TotalDays = request.TotalDays,
                Status = request.Status,
                CreatedOn = request.CreatedOn
            };

            return response;
        }

        public List<LeaveRequestResponseDto> GetAllLeaveRequests()
        {
            var result = new List<LeaveRequestResponseDto>();

            foreach (var r in _requests)
            {
                result.Add(new LeaveRequestResponseDto
                {
                    LeaveRequestId = r.LeaveRequestId,
                    EmployeeName = r.EmployeeName,
                    EmployeeEmail = r.EmployeeEmail,
                    LeaveType = r.LeaveType,
                    StartDate = r.StartDate,
                    EndDate = r.EndDate,
                    Reason = r.Reason,
                    TotalDays = r.TotalDays,
                    Status = r.Status,
                    CreatedOn = r.CreatedOn
                });
            }

            return result;
        }

        public LeaveRequestResponseDto GetLeaveRequestById(int id)
        {
            var request = _requests.FirstOrDefault(r => r.LeaveRequestId == id);

            if (request == null)
            {
                return null;
            }

            return new LeaveRequestResponseDto
            {
                LeaveRequestId = request.LeaveRequestId,
                EmployeeName = request.EmployeeName,
                EmployeeEmail = request.EmployeeEmail,
                LeaveType = request.LeaveType,
                StartDate = request.StartDate,
                EndDate = request.EndDate,
                Reason = request.Reason,
                TotalDays = request.TotalDays,
                Status = request.Status,
                CreatedOn = request.CreatedOn
            };
        }
    }
}