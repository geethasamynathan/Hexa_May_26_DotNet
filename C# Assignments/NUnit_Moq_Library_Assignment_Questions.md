# Assignment Questions Only: NUnit + Moq Testing in C# Console Application

## Application Theme

**Library Membership Management Console Application**

You need to create a console-based application for a library. The application should allow library members to borrow books based on member status, book availability, and borrowing limit rules.

The main purpose of this assignment is to practice:

```text
NUnit Testing
Moq Framework
Mocking Repository Dependencies
Mocking Notification Service
Positive Test Cases
Negative Test Cases
Verify Method Calls
```

---

# Assignment 1: Create the Console Application

## Requirement

Create a C# Console Application with the following name:

```text
LibraryMembershipApp
```

Create a separate NUnit Test Project with the following name:

```text
LibraryMembershipApp.Tests
```

## Required Solution Structure

```text
LibraryMembershipSolution
│
├── LibraryMembershipApp
│   │
│   ├── Models
│   │   ├── Member.cs
│   │   └── Book.cs
│   │
│   ├── Interfaces
│   │   ├── IMemberRepository.cs
│   │   ├── IBookRepository.cs
│   │   └── INotificationService.cs
│   │
│   ├── Services
│   │   └── LibraryService.cs
│   │
│   └── Program.cs
│
└── LibraryMembershipApp.Tests
    └── LibraryServiceTests.cs
```

## Tasks

1. Create a console application named `LibraryMembershipApp`.
2. Create an NUnit test project named `LibraryMembershipApp.Tests`.
3. Add a project reference from the test project to the console application.
4. Install the `Moq` NuGet package in the test project.
5. Follow proper folder structure and naming conventions.

---

# Assignment 2: Create the Member Model

## Requirement

Create a model class named:

```text
Member
```

Inside the folder:

```text
Models
```

## Required Properties

| Property Name | Data Type | Description |
|---|---|---|
| `MemberId` | `int` | Unique id of the library member |
| `MemberName` | `string` | Name of the member |
| `Email` | `string` | Email address of the member |
| `IsActive` | `bool` | Indicates whether the member is active |
| `BorrowedBookCount` | `int` | Number of books currently borrowed by the member |

## Question

Create the `Member` class with the above properties using proper C# naming conventions.

---

# Assignment 3: Create the Book Model

## Requirement

Create a model class named:

```text
Book
```

Inside the folder:

```text
Models
```

## Required Properties

| Property Name | Data Type | Description |
|---|---|---|
| `BookId` | `int` | Unique id of the book |
| `BookTitle` | `string` | Title of the book |
| `AuthorName` | `string` | Author name of the book |
| `IsAvailable` | `bool` | Indicates whether the book is available for borrowing |

## Question

Create the `Book` class with the above properties using proper C# naming conventions.

---

# Assignment 4: Create Member Repository Interface

## Requirement

Create an interface named:

```text
IMemberRepository
```

Inside the folder:

```text
Interfaces
```

## Required Methods

| Method Name | Return Type | Parameters | Description |
|---|---|---|---|
| `GetMemberById` | `Member?` | `int memberId` | Returns member details by member id |
| `UpdateBorrowedBookCount` | `void` | `int memberId` | Updates the borrowed book count after successful borrowing |

## Question

Create the `IMemberRepository` interface with the required methods.

---

# Assignment 5: Create Book Repository Interface

## Requirement

Create an interface named:

```text
IBookRepository
```

Inside the folder:

```text
Interfaces
```

## Required Methods

| Method Name | Return Type | Parameters | Description |
|---|---|---|---|
| `GetBookById` | `Book?` | `int bookId` | Returns book details by book id |
| `MarkBookAsBorrowed` | `void` | `int bookId` | Marks the book as borrowed after successful borrowing |

## Question

Create the `IBookRepository` interface with the required methods.

---

# Assignment 6: Create Notification Service Interface

## Requirement

Create an interface named:

```text
INotificationService
```

Inside the folder:

```text
Interfaces
```

## Required Method

| Method Name | Return Type | Parameters | Description |
|---|---|---|---|
| `SendBorrowNotification` | `void` | `string email, string bookTitle` | Sends borrow confirmation notification to the member |

## Question

Create the `INotificationService` interface with the required method.

---

# Assignment 7: Create Library Service

## Requirement

Create a service class named:

```text
LibraryService
```

Inside the folder:

```text
Services
```

The `LibraryService` class should depend on the following interfaces:

```text
IMemberRepository
IBookRepository
INotificationService
```

## Constructor Requirement

Create a constructor that receives all three dependencies:

```text
IMemberRepository
IBookRepository
INotificationService
```

## Method Requirement

Create a method named:

```csharp
BorrowBook(int memberId, int bookId)
```

Return type:

```csharp
string
```

---

# Assignment 8: Implement Borrow Book Business Rules

## Requirement

Implement the following business rules inside the `BorrowBook()` method.

| Condition | Expected Return Message |
|---|---|
| Member does not exist | `Member not found` |
| Member is inactive | `Member is not active` |
| Book does not exist | `Book not found` |
| Book is not available | `Book is not available` |
| Member already borrowed 3 books | `Borrowing limit reached` |
| All validations passed | `Book borrowed successfully` |

## Additional Behavior

When all validations pass:

1. Call `MarkBookAsBorrowed(bookId)` from `IBookRepository`.
2. Call `UpdateBorrowedBookCount(memberId)` from `IMemberRepository`.
3. Call `SendBorrowNotification(email, bookTitle)` from `INotificationService`.
4. Return `Book borrowed successfully`.

## Question

Implement the complete `BorrowBook()` method according to the above rules.

---

# Assignment 9: Set Up NUnit and Moq

## Requirement

In the test project:

```text
LibraryMembershipApp.Tests
```

Install and configure the required packages.

## Required Packages

```text
NUnit
NUnit3TestAdapter
Microsoft.NET.Test.Sdk
Moq
```

## Tasks

1. Install the Moq package.
2. Add project reference to `LibraryMembershipApp`.
3. Create a test class named `LibraryServiceTests`.
4. Use `[TestFixture]` for the test class.
5. Use `[SetUp]` to initialize mocks before every test case.

---

# Assignment 10: Create Mock Objects in Test Class

## Requirement

Inside `LibraryServiceTests`, create mock objects for:

```text
IMemberRepository
IBookRepository
INotificationService
```

## Required Mock Fields

```csharp
Mock<IMemberRepository>
Mock<IBookRepository>
Mock<INotificationService>
LibraryService
```

## Question

Create the mock fields and initialize them inside the `[SetUp]` method.

---

# Assignment 11: Test Borrow Book Success Scenario

## Test Method Name

```csharp
BorrowBook_WhenAllConditionsAreValid_ShouldReturnSuccessMessage
```

## Scenario

Create mock data where:

```text
Member exists
Member is active
Member borrowed book count is less than 3
Book exists
Book is available
```

## Expected Result

```text
Book borrowed successfully
```

## Mock Setup Requirement

Set up `IMemberRepository.GetMemberById(memberId)` to return a valid active member.

Set up `IBookRepository.GetBookById(bookId)` to return an available book.

## Verify Requirement

Verify that:

```text
MarkBookAsBorrowed(bookId) is called once.
UpdateBorrowedBookCount(memberId) is called once.
SendBorrowNotification(email, bookTitle) is called once.
```

## Question

Write an NUnit test case using Moq for the success scenario.

---

# Assignment 12: Test Member Not Found Scenario

## Test Method Name

```csharp
BorrowBook_WhenMemberDoesNotExist_ShouldReturnMemberNotFound
```

## Scenario

Set up the member repository to return `null`.

## Expected Result

```text
Member not found
```

## Verify Requirement

Verify that:

```text
GetBookById(bookId) is never called.
MarkBookAsBorrowed(bookId) is never called.
UpdateBorrowedBookCount(memberId) is never called.
SendBorrowNotification(email, bookTitle) is never called.
```

## Question

Write an NUnit test case using Moq for the member not found scenario.

---

# Assignment 13: Test Member Inactive Scenario

## Test Method Name

```csharp
BorrowBook_WhenMemberIsInactive_ShouldReturnMemberIsNotActive
```

## Scenario

Set up the member repository to return a member where:

```text
IsActive = false
```

## Expected Result

```text
Member is not active
```

## Verify Requirement

Verify that:

```text
GetBookById(bookId) is never called.
MarkBookAsBorrowed(bookId) is never called.
UpdateBorrowedBookCount(memberId) is never called.
SendBorrowNotification(email, bookTitle) is never called.
```

## Question

Write an NUnit test case using Moq for the inactive member scenario.

---

# Assignment 14: Test Book Not Found Scenario

## Test Method Name

```csharp
BorrowBook_WhenBookDoesNotExist_ShouldReturnBookNotFound
```

## Scenario

Set up the member repository to return a valid active member.

Set up the book repository to return `null`.

## Expected Result

```text
Book not found
```

## Verify Requirement

Verify that:

```text
MarkBookAsBorrowed(bookId) is never called.
UpdateBorrowedBookCount(memberId) is never called.
SendBorrowNotification(email, bookTitle) is never called.
```

## Question

Write an NUnit test case using Moq for the book not found scenario.

---

# Assignment 15: Test Book Not Available Scenario

## Test Method Name

```csharp
BorrowBook_WhenBookIsNotAvailable_ShouldReturnBookIsNotAvailable
```

## Scenario

Set up the member repository to return a valid active member.

Set up the book repository to return a book where:

```text
IsAvailable = false
```

## Expected Result

```text
Book is not available
```

## Verify Requirement

Verify that:

```text
MarkBookAsBorrowed(bookId) is never called.
UpdateBorrowedBookCount(memberId) is never called.
SendBorrowNotification(email, bookTitle) is never called.
```

## Question

Write an NUnit test case using Moq for the book not available scenario.

---

# Assignment 16: Test Borrowing Limit Reached Scenario

## Test Method Name

```csharp
BorrowBook_WhenBorrowingLimitReached_ShouldReturnBorrowingLimitReached
```

## Scenario

Set up the member repository to return a valid active member where:

```text
BorrowedBookCount = 3
```

Set up the book repository to return an available book.

## Expected Result

```text
Borrowing limit reached
```

## Verify Requirement

Verify that:

```text
MarkBookAsBorrowed(bookId) is never called.
UpdateBorrowedBookCount(memberId) is never called.
SendBorrowNotification(email, bookTitle) is never called.
```

## Question

Write an NUnit test case using Moq for the borrowing limit reached scenario.

---

# Assignment 17: Add Validation for Invalid Member Id

## Requirement

Modify the `BorrowBook()` method.

If:

```csharp
memberId <= 0
```

Return:

```text
Invalid member id
```

## Test Method Name

```csharp
BorrowBook_WhenMemberIdIsInvalid_ShouldReturnInvalidMemberId
```

## Verify Requirement

Verify that:

```text
GetMemberById(memberId) is never called.
GetBookById(bookId) is never called.
MarkBookAsBorrowed(bookId) is never called.
UpdateBorrowedBookCount(memberId) is never called.
SendBorrowNotification(email, bookTitle) is never called.
```

## Question

Implement the validation and write an NUnit test case using Moq.

---

# Assignment 18: Add Validation for Invalid Book Id

## Requirement

Modify the `BorrowBook()` method.

If:

```csharp
bookId <= 0
```

Return:

```text
Invalid book id
```

## Test Method Name

```csharp
BorrowBook_WhenBookIdIsInvalid_ShouldReturnInvalidBookId
```

## Verify Requirement

Verify that:

```text
GetMemberById(memberId) is never called.
GetBookById(bookId) is never called.
MarkBookAsBorrowed(bookId) is never called.
UpdateBorrowedBookCount(memberId) is never called.
SendBorrowNotification(email, bookTitle) is never called.
```

## Question

Implement the validation and write an NUnit test case using Moq.

---

# Assignment 19: Add Premium Member Rule

## Requirement

Add a new property to the `Member` class:

```csharp
public bool IsPremiumMember { get; set; }
```

## Business Rule

```text
Normal member can borrow maximum 3 books.
Premium member can borrow maximum 5 books.
```

## Expected Messages

| Condition | Expected Message |
|---|---|
| Normal member already borrowed 3 books | `Borrowing limit reached` |
| Premium member borrowed less than 5 books | `Book borrowed successfully` |
| Premium member already borrowed 5 books | `Borrowing limit reached` |

## Questions

Write test cases for the following:

```csharp
BorrowBook_WhenNormalMemberHasThreeBooks_ShouldReturnBorrowingLimitReached
```

```csharp
BorrowBook_WhenPremiumMemberHasThreeBooks_ShouldAllowBorrowing
```

```csharp
BorrowBook_WhenPremiumMemberHasFiveBooks_ShouldReturnBorrowingLimitReached
```

---

# Assignment 20: Verify Notification Is Sent Correctly

## Requirement

In the success scenario, verify that notification is sent with correct values.

## Expected Values

```text
Email should be member email.
Book title should be borrowed book title.
```

## Question

Write a test case to verify that `SendBorrowNotification()` is called exactly once with the correct member email and correct book title.

---

# Assignment 21: Verify Repository Methods Are Not Called in Failure Scenarios

## Requirement

For each failure scenario, verify that repository update methods are not called.

## Failure Scenarios

```text
Member not found
Member inactive
Book not found
Book not available
Borrowing limit reached
Invalid member id
Invalid book id
```

## Methods That Should Not Be Called

```text
MarkBookAsBorrowed()
UpdateBorrowedBookCount()
SendBorrowNotification()
```

## Question

Write proper `Verify()` statements using `Times.Never` for all failure scenarios.

---

# Assignment 22: Use Proper Test Naming Convention

## Requirement

All test methods should follow this pattern:

```text
MethodName_WhenCondition_ShouldExpectedResult
```

## Examples

```csharp
BorrowBook_WhenAllConditionsAreValid_ShouldReturnSuccessMessage
BorrowBook_WhenMemberDoesNotExist_ShouldReturnMemberNotFound
BorrowBook_WhenBookIsNotAvailable_ShouldReturnBookIsNotAvailable
```

## Question

Rename all test methods using the above naming convention.

---

# Assignment 23: Use Arrange, Act, Assert Pattern

## Requirement

Every test case must clearly follow the AAA pattern.

```text
Arrange
Act
Assert
```

## Question

Rewrite all test cases using proper comments:

```csharp
// Arrange
// Act
// Assert
```

---

# Assignment 24: Final Test Coverage Requirement

## Requirement

At the end of the assignment, the test project should contain test cases for:

| No. | Scenario |
|---:|---|
| 1 | Success scenario |
| 2 | Member not found |
| 3 | Member inactive |
| 4 | Book not found |
| 5 | Book not available |
| 6 | Borrowing limit reached |
| 7 | Invalid member id |
| 8 | Invalid book id |
| 9 | Normal member borrowing limit |
| 10 | Premium member allowed borrowing |
| 11 | Premium member borrowing limit |
| 12 | Notification verification |

## Expected Result

```text
Minimum 12 test cases should pass successfully.
```

---

# Assignment 25: Final Submission Requirements

Learners should submit the following:

```text
1. Complete Console Application project
2. Complete NUnit Test project
3. Member model
4. Book model
5. Repository interfaces
6. Notification service interface
7. LibraryService class
8. LibraryServiceTests class
9. Screenshot of Test Explorer showing all tests passed
10. Short explanation of where Moq is used and why
```

---

# Assignment 26: Viva Questions

Answer the following questions:

1. What is NUnit?
2. What is Moq?
3. Why do we use Moq in unit testing?
4. What is the difference between NUnit and Moq?
5. What is the purpose of `Mock<T>`?
6. What is the purpose of `.Setup()`?
7. What is the purpose of `.Returns()`?
8. What is the purpose of `.Verify()`?
9. What is the use of `Times.Once`?
10. What is the use of `Times.Never`?
11. What is the use of `It.IsAny<T>()`?
12. Why do we use interfaces while working with Moq?
13. Why should we avoid real database calls in unit tests?
14. What is the Arrange, Act, Assert pattern?
15. What is dependency injection?
16. Why should we not mock the class that we are testing?
17. What is the difference between unit testing and integration testing?
18. In this assignment, which dependencies are mocked?
19. In this assignment, which class is under test?
20. What happens if `SendBorrowNotification()` is called in a failure scenario?
