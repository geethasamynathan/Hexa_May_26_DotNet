import { useNavigate } from "react-router-dom";

function Home() {
    const navigate = useNavigate();
    function gotoCourses() {
        navigate("/courses");
    }
    function gotoDashboard() {
        navigate("/dashboard");
    }

    return (
        <div className="home">
            <h1>Welcome to the Student learning portal</h1>

            <p> Learn react, Web API, and Full stack development from one place</p>

            <button onClick={gotoCourses}> View Courses </button>
            <button onClick={gotoDashboard}> Go to Dashboard </button>
        </div>
    );
}

export default Home;