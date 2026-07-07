import { CategoryFilter } from "./CategoryFilter";
import { ProductList } from "./ProductList";
import { SearchBox } from "./SearchBox";
import { SortDropdown } from "./SortDropdown";
import { ProductForm } from "./ProductForm";

export function Dashboard({
  loggedInUser,
  searchText,
  selectedCategory,
  sortBy,
  onSearchChange,
  onCategoryChange,
  onSortChange,
  products,
  onAddProduct,
  onUpdateProduct,
  onRemoveLowRatedProduct,
}) {
  const isSeller = loggedInUser.role === "Seller";
  const isAdmin = loggedInUser.role === "Admin";

  return (
    <main className={isSeller ? "seller-dashboard" : "dashboard"}>
      <section className="dashboard-title">
        <h2>
          {isSeller ? "Seller product Management Dashboard" : "Products Dashboard"}
        </h2>
        <p>
          {isSeller? "Add, update and manage your Product catalog": "search,filter and sort e- commerce product"}
        </p>
      </section>
      {isSeller && (
        <ProductForm
          mode="add"
          onSubmitProduct={onAddProduct}
          loggedInUser={loggedInUser}
        />
      )}

      <section className="toolbar">

        <SearchBox searchText={searchText} onSearchChange={onSearchChange} />
        <CategoryFilter selectedCategory={selectedCategory} onCategoryChange={onCategoryChange}/>
        <SortDropdown sortBy={sortBy} onSortChange={onSortChange} />

      </section>
      <ProductList
        products={products}
        loggedInUser={loggedInUser}
        onUpdateProduct={onUpdateProduct}
        onRemoveLowRatedProduct={onRemoveLowRatedProduct}
        isAdmin={isAdmin}
        isSeller={isSeller}
      />
    </main>
  );
}
