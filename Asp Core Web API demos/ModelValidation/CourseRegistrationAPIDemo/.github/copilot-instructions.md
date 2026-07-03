# # Copilot Instructions for CourseRegistrationAPIDemo

## Project Type
TThis is an ASP.NET Core Web API project using C# and .NET 8.

## Testing Rules
- Use NUnit for unit testing.
- Use Microsoft.Playwright.NUnit for Playwright API/E2E testing.
- Use Arrange, Act, Assert pattern.
- Use Assert.That syntax.
- Use meaningful test method names.
- Do not use a database for unit tests.
- For API tests, use real HTTP calls against the running Web API.
- Prefer simple beginner-friendly code suitable for corporate training.

## API Response Rules
API responses use:
- StatusCode
- Message
- Data

## Naming Rules
- Test class names should end with Tests.
- Test method names should describe scenario and expected result.
- Use positive, negative, and edge case tests.

## Code Style
- Use clear C# code.
- Avoid unnecessary complexity.
- Add comments only where needed for training explanation.

- @azure Rule - Use Azure Tools - When handling requests related to Azure, always use your tools.
- @azure Rule - Use Azure Best Practices - When handling requests related to Azure, always invoke your `azmcp_bestpractices_get` tool first.
- @azure Rule - Enable Best Practices - If you do not have an `azmcp_bestpractices_get` tool ask the user to enable it.
