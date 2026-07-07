export function CategoryFilter({ selectedCategory, onCategoryChange }) {
  const categories = ["All", "Electronics", "Home", "Fashion", "Kitchen"];
  return (
    <select
      value={selectedCategory}
      onChange={(event) => onCategoryChange(event.target.value)}
      className="filter-select"
    >
      {categories.map((category) => (
        <option key={category} value={category}>
          {category}
        </option>
      ))}
    </select>
  );
}