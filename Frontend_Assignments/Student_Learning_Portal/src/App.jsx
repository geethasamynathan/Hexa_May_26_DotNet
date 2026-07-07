import { BrowserRouter, Routes, Route, Navigate } from "react-router-dom";

import Navbar from "./components/Navbar";
import ProtectedRoute from "./components/ProtectedRoute";

import Home from "./pages/Home";
import About from "./pages/About";
import Courses from "./pages/Courses";
import CourseDetails from "./pages/CourseDetails";
import Contact from "./pages/Contact";
import Login from "./pages/Login";

import Dashboard from "./pages/Dashboard";
import Profile from "./pages/Profile";
import MyCourses from "./pages/MyCourses";
import Settings from "./pages/Settings";

import NotFound from "./pages/NotFound";
import "./App.css";


function App() {
    return (
        <BrowserRouter>
            <Navbar />
            <Routes>
                {/* Public Routes */}

                <Route path="/" element={<Home />} />
                <Route path="/about" element={<About />} />
                <Route path="/courses" element={<Courses />} />
                <Route path="/courses/:courseId" element={<CourseDetails />} />
                <Route path="/contact" element={<Contact />} />
                <Route path="/login" element={<Login />} />

                {/* Protected Routes */}

                <Route path="/dashboard"  element={ <ProtectedRoute> <Dashboard /> </ProtectedRoute>}>

                    <Route index element={<Navigate to="profile" replace />} />
                    <Route path="profile" element={<Profile />} />
                    <Route path="my-courses" element={<MyCourses />} />
                    <Route path="settings" element={<Settings />} />

                </Route>

                {/* 404 Route */}

                <Route path="*" element={<NotFound />} />
            </Routes>
        </BrowserRouter>
    );
}

export default App;