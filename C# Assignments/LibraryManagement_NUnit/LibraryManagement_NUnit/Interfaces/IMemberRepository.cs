using LibraryMembershipApp.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace LibraryMembershipApp.Interfaces
{
    public interface IMemberRepository
    {
        Member? GetMemberById(int memberId);
        void UpdateBorrowedBookCount(int memberId);
    }
}