export function SearchBox({ searchText, onSearchChange }) {
  return (
    <input
      type="text"
      placeholder="Search product by name"
      value={searchText}
      onChange={(event) => onSearchChange(event.target.value)}
      className="search-box"
    />
  );
}