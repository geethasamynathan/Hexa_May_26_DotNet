﻿using LoginApp.Models;

namespace LoginApp.Services;

public class RegistrationService
{
    private readonly List<User> _users;

    public RegistrationService(List<User> users)
    {
        _users = users;
    }

    public bool Register(string username, string password)
    {
        if (string.IsNullOrWhiteSpace(username))
            throw new ArgumentException("Username cannot be empty");

        if (string.IsNullOrWhiteSpace(password))
            throw new ArgumentException("Password cannot be empty");

        if (password.Length < 8)
            throw new ArgumentException("Password must be at least 8 characters");

        if (_users.Any(u =>
            u.Username.Equals(username, StringComparison.OrdinalIgnoreCase)))
        {
            return false;
        }

        _users.Add(new User
        {
            Username = username,
            Password = password
        });

        return true;
    }
}