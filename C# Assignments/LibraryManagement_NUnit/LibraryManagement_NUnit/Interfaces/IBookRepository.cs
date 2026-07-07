using LibraryMembershipApp.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace LibraryMembershipApp.Interfaces
{
    public interface IBookRepository
    {
        Book? GetBookById(int bookId);
        void MarkBookAsBorrowed(int bookId);
    }
}