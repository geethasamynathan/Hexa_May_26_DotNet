import { useState } from "react";

export function LoginForm({ onLogin }) {
  const [loginData, setLoginData] = useState({
    email: "",
    password: "",
  });

  const [errorMessage, setErrorMessage] = useState("");

  function handleInputChange(event) {
    const { name, value } = event.target;

    setLoginData({
      ...loginData,
      [name]: value,
    });
  }
  function handleSubmit(event) {
    event.preventDefault();

    if (loginData.email.trim() === "") {
      setErrorMessage("email is required.");
      return;
    }
    if (loginData.password.trim() === "") {
      setErrorMessage("password is required.");
      return;
    }
    onLogin(loginData);
  }

  return (
    <>
      <div className="login-page">
        <form className="login-card" onSubmit={handleSubmit}>
          <h1>E-commerce Login</h1>
          <p>Login to view Product dashboard</p>

          {errorMessage && <div className="error-message">{errorMessage}</div>}

          <div className="form-group">
            <label htmlFor="email">Email Address</label>
            <input
              id="email"
              name="email"
              type="email"
              value={loginData.email}
              onChange={handleInputChange}
              placeholder="Enter Email"
            />
          </div>
          <div className="form-group">
            <label htmlFor="password">Password</label>
            <input
              id="password"
              name="password"
              type="password"
              value={loginData.password}
              onChange={handleInputChange}
              placeholder="Enter password"
            />
          </div>
          <button type="submit" className="login-btn">
            Login
          </button>
        </form>
      </div>
    </>
  );
}