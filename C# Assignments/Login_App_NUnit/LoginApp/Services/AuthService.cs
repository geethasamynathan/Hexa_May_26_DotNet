using LoginApp.Models;

namespace LoginApp.Services;

public class AuthService
{
    public bool Login(User user, string username, string password)
    {
        if (string.IsNullOrWhiteSpace(username))
            throw new ArgumentException("Username cannot be empty");

        if (string.IsNullOrWhiteSpace(password))
            throw new ArgumentException("Password cannot be empty");

        return user.Username == username &&
               user.Password == password;
    }
}