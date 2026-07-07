import { useNavigate } from "react-router-dom";

function NotFound() {
    const navigate = useNavigate();
    function goHome() {
        navigate("/");
    }

    return (
        <div className="not-found">
            <h1>404 - Page Not Found</h1>
            <p> The page you are looking for does not exist. </p>
            <button onClick={goHome}> Go to Home </button>
        </div>
    );
}
export default NotFound;