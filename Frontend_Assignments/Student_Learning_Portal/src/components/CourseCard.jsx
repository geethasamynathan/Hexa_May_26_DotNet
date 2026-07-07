import { useNavigate } from "react-router-dom";

function CourseCard({ course }) {
    const navigate = useNavigate();
    function viewDetails() {
        navigate(`/courses/${course.id}`);
    }

    return (
        <div className="course-card">
            <h2>{course.title}</h2>

            <p> <strong>Category:</strong> {course.category} </p>

            <p> <strong>Duration:</strong> {course.duration} </p>
            <p> <strong>Trainer:</strong> {course.trainer} </p>
            <button onClick={viewDetails}> View Details </button>
        </div>
    );
}
export default CourseCard;