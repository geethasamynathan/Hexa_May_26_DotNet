using LibraryMembershipApp.Interfaces;
using LibraryMembershipApp.Models;
using LibraryMembershipApp.Services;
using Moq;
using System.Net;

namespace LibraryMembershipApp.Tests
{
    [TestFixture]
    public class LibraryServicTests
    {
        private Mock<IMemberRepository> MemberRepoMock;
        private Mock<IBookRepository> BookRepoMock;
        private Mock<INotificationService> NotifiServiceMock;
        private LibraryService libraryService;
        [SetUp]
        public void Setup()
        {
            MemberRepoMock = new Mock<IMemberRepository>();
            BookRepoMock = new Mock<IBookRepository>();
            NotifiServiceMock = new Mock<INotificationService>();
            libraryService = new LibraryService(MemberRepoMock.Object, BookRepoMock.Object, NotifiServiceMock.Object);


        }

        [Test]
        public void BorrowBook_WhenAllConditionsAreValid_ShouldReturnSuccessMessage()
        {
            Book book = new Book
            {
                BookId = 1,
                BookTitle = "Python Version 1",
                AuthorName = "Alice",
                IsAvailable= true
            };
            Member member = new Member
            {
                MemberId = 1,
                MemberName = "John",
                Email = "John@gmail.com",
                IsActive = true,
                BorrowedBookCount=2

            };
          
            MemberRepoMock.Setup(repo => repo.GetMemberById(1)).Returns(member);
            BookRepoMock.Setup(repo => repo.GetBookById(1)).Returns(book);

            string result = libraryService.BorrowBook(member.MemberId, book.BookId);
            Assert.That(result, Is.EqualTo("Book borrowed successfully"));

            BookRepoMock.Verify(repo => repo.MarkBookAsBorrowed(book.BookId), Times.Once);
            MemberRepoMock.Verify(repo => repo.UpdateBorrowedBookCount(member.MemberId), Times.Once);
            NotifiServiceMock.Verify(repo => repo.SendBorrowNotification(member.Email, book.BookTitle),Times.Once);

        }
        [Test]
        public void BorrowBook_WhenMemberDoesNotExist_ShouldReturnMemberNotFound()
        {
           
            MemberRepoMock.Setup(repo => repo.GetMemberById(1)).Returns((Member?)null);

            string result = libraryService.BorrowBook(1,100);
            Assert.That(result, Is.EqualTo("Member not found"));

            BookRepoMock.Verify(repo => repo.GetBookById(It.IsAny<int>()), Times.Never);
            BookRepoMock.Verify(repo => repo.MarkBookAsBorrowed(It.IsAny<int>()), Times.Never);
            MemberRepoMock.Verify(repo => repo.UpdateBorrowedBookCount(It.IsAny<int>()), Times.Never);
            NotifiServiceMock.Verify(repo => repo.SendBorrowNotification(It.IsAny<string>(), It.IsAny<string>()),Times.Never);

        }

        [Test]
        public void BorrowBook_WhenMemberIsInactive_ShouldReturnMemberIsNotActive()
        {
           
            Member member = new Member
            {
                MemberId = 1,
                MemberName = "John",
                Email = "John@gmail.com",
                IsActive = false,
                BorrowedBookCount = 2

            };

            MemberRepoMock.Setup(repo => repo.GetMemberById(1)).Returns(member);
            

            string result = libraryService.BorrowBook(member.MemberId, 100);
            Assert.That(result, Is.EqualTo("Member is not active"));

            BookRepoMock.Verify(repo => repo.GetBookById(It.IsAny<int>()), Times.Never);
            BookRepoMock.Verify(repo => repo.MarkBookAsBorrowed(It.IsAny<int>()), Times.Never);
            MemberRepoMock.Verify(repo => repo.UpdateBorrowedBookCount(member.MemberId), Times.Never);
            NotifiServiceMock.Verify(repo => repo.SendBorrowNotification(member.Email, It.IsAny<string>()), Times.Never);

        }

        [Test]
        public void BorrowBook_WhenBookDoesNotExist_ShouldReturnBookNotFound()
        {

            Member member = new Member
            {
                MemberId = 1,
                MemberName = "John",
                Email = "John@gmail.com",
                IsActive = true,
                BorrowedBookCount = 2

            };
            MemberRepoMock.Setup(repo => repo.GetMemberById(1)).Returns(member);
            BookRepoMock.Setup(repo => repo.GetBookById(100)).Returns((Book?)null);


            string result = libraryService.BorrowBook(member.MemberId, 100);
            Assert.That(result, Is.EqualTo("Book not found"));

            
            BookRepoMock.Verify(repo => repo.MarkBookAsBorrowed(It.IsAny<int>()), Times.Never);
            MemberRepoMock.Verify(repo => repo.UpdateBorrowedBookCount(member.MemberId), Times.Never);
            NotifiServiceMock.Verify(repo => repo.SendBorrowNotification(member.Email, It.IsAny<string>()), Times.Never);

        }

        [Test]
        public void BorrowBook_WhenBookIsNotAvailable_ShouldReturnBookIsNotAvailable()
        {

            Member member = new Member
            {
                MemberId = 1,
                MemberName = "John",
                Email = "John@gmail.com",
                IsActive = true,
                BorrowedBookCount = 2

            };
            Book book = new Book
            {
                BookId = 1,
                BookTitle = "Python Version 1",
                AuthorName = "Alice",
                IsAvailable = false
            };
            MemberRepoMock.Setup(repo => repo.GetMemberById(1)).Returns(member);
            BookRepoMock.Setup(repo => repo.GetBookById(1)).Returns(book);


            string result = libraryService.BorrowBook(member.MemberId, book.BookId);
            Assert.That(result, Is.EqualTo("Book is not available"));


            BookRepoMock.Verify(repo => repo.MarkBookAsBorrowed(It.IsAny<int>()), Times.Never);
            MemberRepoMock.Verify(repo => repo.UpdateBorrowedBookCount(member.MemberId), Times.Never);
            NotifiServiceMock.Verify(repo => repo.SendBorrowNotification(member.Email, It.IsAny<string>()), Times.Never);

        }

        [Test]
        public void BorrowBook_WhenBorrowingLimitReached_ShouldReturnBorrowingLimitReached()
        {

            Member member = new Member
            {
                MemberId = 1,
                MemberName = "John",
                Email = "John@gmail.com",
                IsActive = true,
                BorrowedBookCount = 3

            };
            Book book = new Book
            {
                BookId = 1,
                BookTitle = "Python Version 1",
                AuthorName = "Alice",
                IsAvailable = true
            };
            MemberRepoMock.Setup(repo => repo.GetMemberById(1)).Returns(member);
            BookRepoMock.Setup(repo => repo.GetBookById(100)).Returns(book);


            string result = libraryService.BorrowBook(member.MemberId, 100);
            Assert.That(result, Is.EqualTo("Borrowing limit reached"));


            BookRepoMock.Verify(repo => repo.MarkBookAsBorrowed(It.IsAny<int>()), Times.Never);
            MemberRepoMock.Verify(repo => repo.UpdateBorrowedBookCount(member.MemberId), Times.Never);
            NotifiServiceMock.Verify(repo => repo.SendBorrowNotification(member.Email, It.IsAny<string>()), Times.Never);

        }

        [Test]
        public void BorrowBook_WhenMemberIdIsInvalid_ShouldReturnInvalidMemberId()
        {

            Member member = new Member
            {
                MemberId = 0,
                MemberName = "John",
                Email = "John@gmail.com",
                IsActive = true,
                BorrowedBookCount = 2

            };
           
            MemberRepoMock.Setup(repo => repo.GetMemberById(0)).Returns(member);
            


            string result = libraryService.BorrowBook(member.MemberId, 100);
            Assert.That(result, Is.EqualTo("Invalid member id"));
            MemberRepoMock.Verify(repo => repo.GetMemberById(member.MemberId), Times.Never);
            BookRepoMock.Verify(repo => repo.GetBookById(It.IsAny<int>()), Times.Never);
            BookRepoMock.Verify(repo => repo.MarkBookAsBorrowed(It.IsAny<int>()), Times.Never);
            MemberRepoMock.Verify(repo => repo.UpdateBorrowedBookCount(member.MemberId), Times.Never);
            NotifiServiceMock.Verify(repo => repo.SendBorrowNotification(member.Email, It.IsAny<string>()), Times.Never);

        }

        [Test]
        public void BorrowBook_WhenBookIdIsInvalid_ShouldReturnInvalidBookId()
        {
            Member member = new Member
            {
                MemberId = 1,
                MemberName = "John",
                Email = "John@gmail.com",
                IsActive = true,
                BorrowedBookCount = 2

            };
            Book book = new Book
            {
                BookId = 0,
                BookTitle = "Python Version 1",
                AuthorName = "Alice",
                IsAvailable = true
            };
            MemberRepoMock.Setup(repo => repo.GetMemberById(member.MemberId)).Returns(member);
            BookRepoMock.Setup(repo => repo.GetBookById(book.BookId)).Returns(book);



            string result = libraryService.BorrowBook(member.MemberId, book.BookId);
            Assert.That(result, Is.EqualTo("Invalid book id"));
            MemberRepoMock.Verify(repo => repo.GetMemberById(It.IsAny<int>()), Times.Never);
            BookRepoMock.Verify(repo => repo.GetBookById(It.IsAny<int>()), Times.Never);
            BookRepoMock.Verify(repo => repo.MarkBookAsBorrowed(It.IsAny<int>()), Times.Never);
            MemberRepoMock.Verify(repo => repo.UpdateBorrowedBookCount(It.IsAny<int>()), Times.Never);
            NotifiServiceMock.Verify(repo => repo.SendBorrowNotification(It.IsAny<string>(), It.IsAny<string>()), Times.Never);

        }

        [Test]
        public void BorrowBook_WhenNormalMemberHasThreeBooks_ShouldReturnBorrowingLimitReached()
        {
            Member member = new Member
            {
                MemberId = 1,
                MemberName = "John",
                Email = "John@gmail.com",
                IsActive = true,
                BorrowedBookCount = 3,
                IsPremiumMember=false

            };
            
            MemberRepoMock.Setup(repo => repo.GetMemberById(member.MemberId)).Returns(member);
            

            string result = libraryService.BorrowBook(member.MemberId, 1);
            Assert.That(result, Is.EqualTo("Borrowing limit reached"));
            BookRepoMock.Verify(repo => repo.MarkBookAsBorrowed(It.IsAny<int>()), Times.Never);
            MemberRepoMock.Verify(repo => repo.UpdateBorrowedBookCount(It.IsAny<int>()), Times.Never);
            NotifiServiceMock.Verify(repo => repo.SendBorrowNotification(It.IsAny<string>(), It.IsAny<string>()), Times.Never);

        }

        [Test]
        public void BorrowBook_WhenPremiumMemberHasThreeBooks_ShouldAllowBorrowing()
        {
            Member member = new Member
            {
                MemberId = 1,
                MemberName = "John",
                Email = "John@gmail.com",
                IsActive = true,
                BorrowedBookCount = 3,
                IsPremiumMember = true

            };
            Book book = new Book
            {
                BookId = 1,
                BookTitle = "Python Version 1",
                AuthorName = "Alice",
                IsAvailable = true
            };

            MemberRepoMock.Setup(repo => repo.GetMemberById(member.MemberId)).Returns(member);
            BookRepoMock.Setup(repo => repo.GetBookById(book.BookId)).Returns(book);


            string result = libraryService.BorrowBook(member.MemberId, 1);
            Assert.That(result, Is.EqualTo("Book borrowed successfully"));
            BookRepoMock.Verify(repo => repo.MarkBookAsBorrowed(It.IsAny<int>()), Times.Once);
            MemberRepoMock.Verify(repo => repo.UpdateBorrowedBookCount(It.IsAny<int>()), Times.Once);
            NotifiServiceMock.Verify(repo => repo.SendBorrowNotification(It.IsAny<string>(), It.IsAny<string>()), Times.Once);

        }

        [Test]
        public void BorrowBook_WhenPremiumMemberHasFiveBooks_ShouldReturnBorrowingLimitReached()
        {
            Member member = new Member
            {
                MemberId = 1,
                MemberName = "John",
                Email = "John@gmail.com",
                IsActive = true,
                BorrowedBookCount = 5,
                IsPremiumMember = true

            };

            MemberRepoMock.Setup(repo => repo.GetMemberById(member.MemberId)).Returns(member);


            string result = libraryService.BorrowBook(member.MemberId, 1);
            Assert.That(result, Is.EqualTo("Borrowing limit reached"));
            BookRepoMock.Verify(repo => repo.MarkBookAsBorrowed(It.IsAny<int>()), Times.Never);
            MemberRepoMock.Verify(repo => repo.UpdateBorrowedBookCount(It.IsAny<int>()), Times.Never);
            NotifiServiceMock.Verify(repo => repo.SendBorrowNotification(It.IsAny<string>(), It.IsAny<string>()), Times.Never);

        }

        [Test]
        public void BorrowBook_WhenAllConditionsAreValid_Should_Call_Notification()
        {
            Member member = new Member
            {
                MemberId = 1,
                MemberName = "John",
                Email = "John@gmail.com",
                IsActive = true,
                BorrowedBookCount = 3,
                IsPremiumMember = true

            };
            Book book = new Book
            {
                BookId = 1,
                BookTitle = "Python Version 1",
                AuthorName = "Alice",
                IsAvailable = true
            };

            MemberRepoMock.Setup(repo => repo.GetMemberById(member.MemberId)).Returns(member);
            BookRepoMock.Setup(repo => repo.GetBookById(book.BookId)).Returns(book);

            string result = libraryService.BorrowBook(member.MemberId, 1);
            Assert.That(result, Is.EqualTo("Book borrowed successfully"));
            NotifiServiceMock.Verify(repo => repo.SendBorrowNotification(member.Email, book.BookTitle), Times.Once);

        }

    }
}
