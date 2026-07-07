export function SortDropdown({ sortBy, onSortChange }) {
  return (
    <select
      value={sortBy}
      onChange={(event) => onSortChange(event.target.value)}
      className="filter-select"
    >
      <option value="">Sort By</option>
      <option value="priceLowHigh">Price: Low to High</option>
      <option value="priceHighLow">Price: High to Low</option>
      <option value="ratingHighLow">Rating: High to Low</option>
      <option value="stockHighLow">Stock: High to Low</option>
    </select>
  );
}