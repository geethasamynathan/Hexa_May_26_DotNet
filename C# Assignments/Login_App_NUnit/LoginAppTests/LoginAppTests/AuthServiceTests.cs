using LoginApp.Models;
using LoginApp.Services;

namespace LoginApp.Tests;

[TestFixture]
public class AuthServiceTests
{
    private AuthService _auth = null!;
    private User _user = null!;

    [SetUp]
    public void Setup()
    {
        _auth = new AuthService();

        _user = new User
        {
            Username = "admin",
            Password = "password123"
        };
    }

    [Test]
    public void Login_ValidCredentials_ReturnsTrue()
    {
        bool result =
            _auth.Login(_user, "admin", "password123");

        Assert.That(result, Is.True);
    }

    [Test]
    public void Login_InvalidPassword_ReturnsFalse()
    {
        bool result =
            _auth.Login(_user, "admin", "wrongpass");

        Assert.That(result, Is.False);
    }

    [Test]
    public void Login_InvalidUsername_ReturnsFalse()
    {
        bool result =
            _auth.Login(_user, "wronguser", "password123");

        Assert.That(result, Is.False);
    }

    [Test]
    public void Login_EmptyUsername_ThrowsException()
    {
        Assert.Throws<ArgumentException>(() =>
            _auth.Login(_user, "", "password123"));
    }

    [Test]
    public void Login_EmptyPassword_ThrowsException()
    {
        Assert.Throws<ArgumentException>(() =>
            _auth.Login(_user, "admin", ""));
    }

    [Test]
    public void Login_NullUsername_ThrowsException()
    {
        Assert.Throws<ArgumentException>(() =>
            _auth.Login(_user, null!, "password123"));
    }

    [Test]
    public void Login_NullPassword_ThrowsException()
    {
        Assert.Throws<ArgumentException>(() =>
            _auth.Login(_user, "admin", null!));
    }
}