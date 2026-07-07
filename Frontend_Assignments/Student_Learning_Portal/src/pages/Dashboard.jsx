import { NavLink, Outlet } from "react-router-dom";

function Dashboard() {
    return (
        <div className="dashboard">
            <h1>Welcome to Student Dashboard</h1>
            <nav>
                <NavLink to="profile"> Profile </NavLink>

                {" | "}
                <NavLink to="my-courses"> My Courses </NavLink>

                {" | "}
                <NavLink to="settings"> Settings </NavLink>
            </nav>
        <Outlet />
        </div>
    );
}
export default Dashboard;