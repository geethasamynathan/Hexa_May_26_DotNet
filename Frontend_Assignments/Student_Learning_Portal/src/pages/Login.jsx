import { useState } from "react";
import { useNavigate } from "react-router-dom";

function Login() {

    const navigate = useNavigate();

    const [username, setUsername] = useState("");
    const [password, setPassword] = useState("");
    const [error, setError] = useState("");

    function handleLogin(event) {

        event.preventDefault();
        if (username.trim() === "") {
            setError("Username is required");
            return;
        }

        if (password.trim() === "")
        {
            setError("Password is required");
            return;
        }

        if ( username === "student" && password === "student123") {
            localStorage.setItem("isLoggedIn", "true");
            navigate("/dashboard");
        } 
        else {
            setError("Invalid username or password");
        }
    }

    return (
        <div className="login">

            <h1>Login</h1>

            <form onSubmit={handleLogin}>
                <label>Username</label>
                <input  type="text" value={username}
                    onChange={(event) => setUsername(event.target.value) } />
                <br></br>
                <label>Password</label>
                <input type="password" value={password}
                    onChange={(event) => setPassword(event.target.value)} />
                <br></br>
                <button type="submit"> Login </button>
            </form>

            {
                error && ( <p style={{ color: "red" }}> {error} </p>)
            }
        </div>
    );
}

export default Login;