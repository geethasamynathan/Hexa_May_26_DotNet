import courses from "../data/courses";
import CourseCard from "../components/CourseCard";

function Courses() {
return (
        <div className="courses">
            <h1> Available Courses </h1>
            {
                courses.map((course) => ( <CourseCard key={course.id}
                        course={course}  />
                )) }
        </div>
    ); }
export default Courses;