import { useNavigate } from "react-router-dom";

function Contact() {

    const navigate = useNavigate();
    function goBack() {
        navigate(-1);
    }

    return (
        <div className="contact">

            <h1>Contact Us</h1>

            <p> <strong>Email :</strong> support@studentlearningportal.com </p>
            <p> <strong>Phone :</strong> 9344966969 </p>
            <p> Location : Coimbatore, India </p>

            <button onClick={goBack}> Go Back </button>
        </div>
    );}
export default Contact;