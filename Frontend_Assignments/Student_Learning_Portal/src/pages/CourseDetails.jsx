import { useParams, useNavigate } from "react-router-dom";
import courses from "../data/courses";

function CourseDetails() {

    const { courseId } = useParams();
    const navigate = useNavigate();
    const course = courses.find( (item) => item.id === Number(courseId) );

    if (course==null) {
        return (   <h2>Course not found</h2>  );
    }
    function goBack() {
        navigate("/courses");
    }

    return (
        <div className="course-details">

            <h1>Course Details</h1>

            <p>  <strong>Course ID :</strong> {course.id}  </p>

            <p>  <strong>Title :</strong> {course.title}  </p>
            <p> <strong>Category :</strong> {course.category} </p>
            
            <p> <strong>Duration :</strong> {course.duration} </p>
            <p> <strong>Trainer :</strong> {course.trainer} </p>
            <p> <strong>Description :</strong> {course.description}</p>
            <button onClick={goBack}> Back to Courses</button>
        </div>
    );}

export default CourseDetails;