using LoginApp.Models;
using LoginApp.Services;

namespace LoginApp.Tests;

[TestFixture]
public class RegistrationServiceTests
{
    private List<User> _users = null!;
    private RegistrationService _registration = null!;

    [SetUp]
    public void Setup()
    {
        _users = new List<User>();

        _registration =
            new RegistrationService(_users);
    }

    [Test]
    public void Register_ValidUser_ReturnsTrue()
    {
        bool result =
            _registration.Register(
                "sugan",
                "password123");

        Assert.That(result, Is.True);
    }

    [Test]
    public void Register_DuplicateUser_ReturnsFalse()
    {
        _registration.Register(
            "sugan",
            "password123");

        bool result =
            _registration.Register(
                "sugan",
                "password123");

        Assert.That(result, Is.False);
    }

    [Test]
    public void Register_EmptyUsername_ThrowsException()
    {
        Assert.Throws<ArgumentException>(() =>
            _registration.Register(
                "",
                "password123"));
    }

    [Test]
    public void Register_EmptyPassword_ThrowsException()
    {
        Assert.Throws<ArgumentException>(() =>
            _registration.Register(
                "sugan",
                ""));
    }

    [Test]
    public void Register_ShortPassword_ThrowsException()
    {
        Assert.Throws<ArgumentException>(() =>
            _registration.Register(
                "sugan",
                "123"));
    }

    [Test]
    public void Register_NullUsername_ThrowsException()
    {
        Assert.Throws<ArgumentException>(() =>
            _registration.Register(
                null!,
                "password123"));
    }

    [Test]
    public void Register_NullPassword_ThrowsException()
    {
        Assert.Throws<ArgumentException>(() =>
            _registration.Register(
                "sugan",
                null!));
    }
}