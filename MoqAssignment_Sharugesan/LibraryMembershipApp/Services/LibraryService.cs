using LibraryMembershipApp.Interfaces;
using LibraryMembershipApp.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace LibraryMembershipApp.Services
{
    public class LibraryService
    {
        private readonly IMemberRepository _memberRepo;
        private readonly IBookRepository _bookRepo;
        private readonly INotificationService _notificationService;

        public LibraryService(IMemberRepository memberRepo, IBookRepository bookRepo, INotificationService notificationService)
        {
            _memberRepo= memberRepo;
            _bookRepo= bookRepo;
            _notificationService= notificationService;
        }

        public string BorrowBook(int memberId, int bookId)
        {
            if (memberId <= 0)
            {
                return "Invalid member id";
            }
            if (bookId <= 0)
            {
                return "Invalid book id";
            }
            Member? member =  _memberRepo.GetMemberById(memberId);
            if(member == null)
            {
                return "Member not found";
            }
            if(member.IsActive == false)
            {
                return "Member is not active";
            }
            if (member.BorrowedBookCount >= 3 && !member.IsPremiumMember)
            {
                return "Borrowing limit reached";
            }
            if (member.IsPremiumMember && member.BorrowedBookCount >= 5)
            {
                return "Borrowing limit reached";
            }

            Book? book = _bookRepo.GetBookById(bookId);
            if (book == null)
            {
                return "Book not found";
            }
            if (book.IsAvailable == false)
            {
                return "Book is not available";
            }
            
            

            _bookRepo.MarkBookAsBorrowed(bookId);
            _memberRepo.UpdateBorrowedBookCount(memberId);
            _notificationService.SendBorrowNotification(member.Email, book.BookTitle);
            return "Book borrowed successfully";

        }

    }
}
