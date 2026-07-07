export function Header({ loggedInUser, onLogout }) {
  return (
    <header className="app-header">
      <div>
        <h1> E-Commerce </h1>
        <p> welcome {loggedInUser.name}</p>
        <span className="role-badge">{loggedInUser.role}</span>
      </div>
      <button type="button" className="logout-btn" onClick={onLogout}>
        Logout
      </button>
    </header>
  );
}