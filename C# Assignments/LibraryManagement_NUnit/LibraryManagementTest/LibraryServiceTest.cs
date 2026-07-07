using LibraryMembershipApp.Interfaces;
using LibraryMembershipApp.Models;
using LibraryMembershipApp.Services;
using Moq;
using NUnit.Framework;

namespace LibraryMembershipApp.Tests
{
    [TestFixture]
    public class LibraryServiceTests
    {
        private Mock<IMemberRepository> _mockMemberRepo;
        private Mock<IBookRepository> _mockBookRepo;
        private Mock<INotificationService> _mockNotificationService;
        private LibraryService _libraryService;

        [SetUp]
        public void SetUp()
        {
            _mockMemberRepo = new Mock<IMemberRepository>();
            _mockBookRepo = new Mock<IBookRepository>();
            _mockNotificationService = new Mock<INotificationService>();

            _libraryService = new LibraryService(
                _mockMemberRepo.Object,
                _mockBookRepo.Object,
                _mockNotificationService.Object
            );
        }

        [Test]
        public void BorrowBook_WhenAllConditionsAreValid_ShouldReturnSuccessMessage()
        {
            // Arrange
            var memberId = 1;
            var bookId = 101;

            _mockMemberRepo.Setup(m => m.GetMemberById(memberId)).Returns(new Member
            { MemberId = memberId, Email = "test@test.com", IsActive = true, BorrowedBookCount = 2, IsPremiumMember = false });
            _mockBookRepo.Setup(b => b.GetBookById(bookId)).Returns(new Book
            { BookId = bookId, BookTitle = "C# Guide", IsAvailable = true });

            // Act
            var result = _libraryService.BorrowBook(memberId, bookId);

            // Assert
            NUnit.Framework.Assert.That(result, Is.EqualTo("Book borrowed successfully"));
            _mockBookRepo.Verify(b => b.MarkBookAsBorrowed(bookId), Times.Once);
            _mockMemberRepo.Verify(m => m.UpdateBorrowedBookCount(memberId), Times.Once);
            _mockNotificationService.Verify(n => n.SendBorrowNotification("test@test.com", "C# Guide"), Times.Once);
        }

        [Test]
        public void BorrowBook_WhenMemberDoesNotExist_ShouldReturnMemberNotFound()
        {
            // Arrange
            var memberId = 1;
            var bookId = 101;
            _mockMemberRepo.Setup(m => m.GetMemberById(memberId)).Returns((Member)null);

            // Act
            var result = _libraryService.BorrowBook(memberId, bookId);

            // Assert
            NUnit.Framework.Assert.That(result, Is.EqualTo("Member not found"));
            _mockBookRepo.Verify(b => b.GetBookById(It.IsAny<int>()), Times.Never);
            _mockBookRepo.Verify(b => b.MarkBookAsBorrowed(It.IsAny<int>()), Times.Never);
            _mockMemberRepo.Verify(m => m.UpdateBorrowedBookCount(It.IsAny<int>()), Times.Never);
            _mockNotificationService.Verify(n => n.SendBorrowNotification(It.IsAny<string>(), It.IsAny<string>()), Times.Never);
        }

        [Test]
        public void BorrowBook_WhenMemberIsInactive_ShouldReturnMemberIsNotActive()
        {
            // Arrange
            var memberId = 1;
            var bookId = 101;
            _mockMemberRepo.Setup(m => m.GetMemberById(memberId)).Returns(new Member { IsActive = false });

            // Act
            var result = _libraryService.BorrowBook(memberId, bookId);

            // Assert
            NUnit.Framework.Assert.That(result, Is.EqualTo("Member is not active"));
            _mockBookRepo.Verify(b => b.GetBookById(It.IsAny<int>()), Times.Never);
            _mockBookRepo.Verify(b => b.MarkBookAsBorrowed(It.IsAny<int>()), Times.Never);
            _mockMemberRepo.Verify(m => m.UpdateBorrowedBookCount(It.IsAny<int>()), Times.Never);
            _mockNotificationService.Verify(n => n.SendBorrowNotification(It.IsAny<string>(), It.IsAny<string>()), Times.Never);
        }

        [Test]
        public void BorrowBook_WhenBookDoesNotExist_ShouldReturnBookNotFound()
        {
            // Arrange
            var memberId = 1;
            var bookId = 101;
            _mockMemberRepo.Setup(m => m.GetMemberById(memberId)).Returns(new Member { IsActive = true });
            _mockBookRepo.Setup(b => b.GetBookById(bookId)).Returns((Book)null);

            // Act
            var result = _libraryService.BorrowBook(memberId, bookId);

            // Assert
            NUnit.Framework.Assert.That(result, Is.EqualTo("Book not found"));
            _mockBookRepo.Verify(b => b.MarkBookAsBorrowed(It.IsAny<int>()), Times.Never);
            _mockMemberRepo.Verify(m => m.UpdateBorrowedBookCount(It.IsAny<int>()), Times.Never);
            _mockNotificationService.Verify(n => n.SendBorrowNotification(It.IsAny<string>(), It.IsAny<string>()), Times.Never);
        }

        [Test]
        public void BorrowBook_WhenBookIsNotAvailable_ShouldReturnBookIsNotAvailable()
        {
            // Arrange
            var memberId = 1;
            var bookId = 101;
            _mockMemberRepo.Setup(m => m.GetMemberById(memberId)).Returns(new Member { IsActive = true });
            _mockBookRepo.Setup(b => b.GetBookById(bookId)).Returns(new Book { IsAvailable = false });

            // Act
            var result = _libraryService.BorrowBook(memberId, bookId);

            // Assert
            NUnit.Framework.Assert.That(result, Is.EqualTo("Book is not available"));
            _mockBookRepo.Verify(b => b.MarkBookAsBorrowed(It.IsAny<int>()), Times.Never);
            _mockMemberRepo.Verify(m => m.UpdateBorrowedBookCount(It.IsAny<int>()), Times.Never);
            _mockNotificationService.Verify(n => n.SendBorrowNotification(It.IsAny<string>(), It.IsAny<string>()), Times.Never);
        }

        [Test]
        public void BorrowBook_WhenBorrowingLimitReached_ShouldReturnBorrowingLimitReached()
        {
            // Arrange
            var memberId = 1;
            var bookId = 101;
            _mockMemberRepo.Setup(m => m.GetMemberById(memberId)).Returns(new Member { IsActive = true, BorrowedBookCount = 3 });
            _mockBookRepo.Setup(b => b.GetBookById(bookId)).Returns(new Book { IsAvailable = true });

            // Act
            var result = _libraryService.BorrowBook(memberId, bookId);

            // Assert
            NUnit.Framework.Assert.That(result, Is.EqualTo("Borrowing limit reached"));
            _mockBookRepo.Verify(b => b.MarkBookAsBorrowed(It.IsAny<int>()), Times.Never);
            _mockMemberRepo.Verify(m => m.UpdateBorrowedBookCount(It.IsAny<int>()), Times.Never);
            _mockNotificationService.Verify(n => n.SendBorrowNotification(It.IsAny<string>(), It.IsAny<string>()), Times.Never);
        }

        [Test]
        public void BorrowBook_WhenNormalMemberHasThreeBooks_ShouldReturnBorrowingLimitReached()
        {
            // Arrange
            var memberId = 1;
            var bookId = 101;
            _mockMemberRepo.Setup(m => m.GetMemberById(memberId)).Returns(new Member { IsActive = true, BorrowedBookCount = 3, IsPremiumMember = false });
            _mockBookRepo.Setup(b => b.GetBookById(bookId)).Returns(new Book { IsAvailable = true });

            // Act
            var result = _libraryService.BorrowBook(memberId, bookId);

            // Assert
            NUnit.Framework.Assert.That(result, Is.EqualTo("Borrowing limit reached"));
            _mockBookRepo.Verify(b => b.MarkBookAsBorrowed(It.IsAny<int>()), Times.Never);
            _mockMemberRepo.Verify(m => m.UpdateBorrowedBookCount(It.IsAny<int>()), Times.Never);
            _mockNotificationService.Verify(n => n.SendBorrowNotification(It.IsAny<string>(), It.IsAny<string>()), Times.Never);
        }

        [Test]
        public void BorrowBook_WhenPremiumMemberHasThreeBooks_ShouldAllowBorrowing()
        {
            // Arrange
            var memberId = 1;
            var bookId = 101;
            _mockMemberRepo.Setup(m => m.GetMemberById(memberId)).Returns(new Member
            { MemberId = memberId, Email = "premium@test.com", IsActive = true, BorrowedBookCount = 3, IsPremiumMember = true });
            _mockBookRepo.Setup(b => b.GetBookById(bookId)).Returns(new Book
            { BookId = bookId, BookTitle = "C# Guide", IsAvailable = true });

            // Act
            var result = _libraryService.BorrowBook(memberId, bookId);

            // Assert
            NUnit.Framework.Assert.That(result, Is.EqualTo("Book borrowed successfully"));
        }

        [Test]
        public void BorrowBook_WhenPremiumMemberHasFiveBooks_ShouldReturnBorrowingLimitReached()
        {
            // Arrange
            var memberId = 1;
            var bookId = 101;
            _mockMemberRepo.Setup(m => m.GetMemberById(memberId)).Returns(new Member { IsActive = true, BorrowedBookCount = 5, IsPremiumMember = true });
            _mockBookRepo.Setup(b => b.GetBookById(bookId)).Returns(new Book { IsAvailable = true });

            // Act
            var result = _libraryService.BorrowBook(memberId, bookId);

            // Assert
            NUnit.Framework.Assert.That(result, Is.EqualTo("Borrowing limit reached"));
        }

        [Test]
        public void BorrowBook_WhenMemberIdIsInvalid_ShouldReturnInvalidMemberId()
        {
            // Arrange
            var memberId = 0;
            var bookId = 101;

            // Act
            var result = _libraryService.BorrowBook(memberId, bookId);

            // Assert
            NUnit.Framework.Assert.That(result, Is.EqualTo("Invalid member id"));
            _mockMemberRepo.Verify(m => m.GetMemberById(It.IsAny<int>()), Times.Never);
        }

        [Test]
        public void BorrowBook_WhenBookIdIsInvalid_ShouldReturnInvalidBookId()
        {
            // Arrange
            var memberId = 1;
            var bookId = -1;

            // Act
            var result = _libraryService.BorrowBook(memberId, bookId);

            // Assert
            NUnit.Framework.Assert.That(result, Is.EqualTo("Invalid book id"));
            _mockBookRepo.Verify(b => b.GetBookById(It.IsAny<int>()), Times.Never);
        }

        [Test]
        public void BorrowBook_WhenSuccessful_ShouldSendNotificationWithCorrectValues()
        {
            // Arrange
            var memberId = 1;
            var bookId = 101;
            var email = "student@test.com";
            var bookTitle = "Mastering C#";

            _mockMemberRepo.Setup(m => m.GetMemberById(memberId)).Returns(new Member
            { MemberId = memberId, Email = email, IsActive = true, BorrowedBookCount = 1, IsPremiumMember = false });
            _mockBookRepo.Setup(b => b.GetBookById(bookId)).Returns(new Book
            { BookId = bookId, BookTitle = bookTitle, IsAvailable = true });

            // Act
            _libraryService.BorrowBook(memberId, bookId);

            // Assert
            _mockNotificationService.Verify(n => n.SendBorrowNotification(email, bookTitle), Times.Once);
        }
    }
}