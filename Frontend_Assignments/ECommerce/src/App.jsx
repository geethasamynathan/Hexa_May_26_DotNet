import { useState } from "react";
import reactLogo from "./assets/react.svg";
import viteLogo from "./assets/vite.svg";
import heroImg from "./assets/hero.png";
import "./App.css";
import { ProductList } from "./components/ProductList.jsx";
import { products as intialProducts } from "./data/products.js";
import { ProductCard } from "./components/ProductCard.jsx";
import { SearchBox } from "./components/SearchBox.jsx";
import { CategoryFilter } from "./components/CategoryFilter.jsx";
import { SortDropdown } from "./components/SortDropdown.jsx";
import { users } from "./data/users.js";
import { Header } from "./components/Header.jsx";
import { Dashboard } from "./components/Dashboard.jsx";
import { LoginForm } from "./components/LoginForm.jsx";
function App() {
  const [loggedInUser, setLoggedInUser] = useState(null);
  const [loginError, setLoginError] = useState("");

  const [productItems, setProductItems] = useState(intialProducts);

  const [searchText, setSearchText] = useState("");
  const [selectedCategory, setSelectedCategory] = useState("All");
  const [sortBy, setSortBy] = useState("");

  function handleLogin(loginData) {
    const matchedUser = users.find(
      (user) =>
        user.email.toLowerCase() === loginData.email.toLowerCase() &&
        user.password === loginData.password,
    );

    if (!matchedUser) {
      setLoginError("Invalid email or password");
      return;
    }

    setLoggedInUser(matchedUser);
    setLoginError("");
  }

  function handleLogout() {
    setLoggedInUser(null);
    setSearchText("");
    setSelectedCategory("All");
    setSortBy("");
  }

  function handleAddProduct(newProduct) {
    setProductItems((currentProducts) => [
      ...currentProducts,
      {
        ...newProduct,
        id: Date.now(),
      },
    ]);
  }

  function handleUpdateProduct(updatedProduct) {
    setProductItems((currentProducts) => {
      currentProducts.map((product) =>
        product.id === updatedProduct.id ? updatedProduct : product,
      );
    });
  }

  function handleRemoveLowRatedProduct(productId) {
    setProductItems((currentProducts) =>
      currentProducts.filter((product) => product.id !== productId),
    );
  }

  const filteredProducts = productItems.filter((product) => {
    const matchesSearch = product.name
      .toLowerCase()
      .includes(searchText.toLowerCase());

    const matchesCategory =
      selectedCategory === "All" || product.category === selectedCategory;
    return matchesCategory && matchesSearch;
  });

  const sortedProducts = [...filteredProducts].sort((a, b) => {
    if (sortBy === "priceLowHigh") {
      return a.price - b.price;
    }

    if (sortBy === "priceHighLow") {
      return b.price - a.price;
    }
    if (sortBy === "ratingHighLow") {
      return b.rating - a.rating;
    }

    if (sortBy === "stockHighLow") {
      return b.stock - a.stock;
    }
    return 0;
  });

  if (!loggedInUser) {
    return (
      <>
        <LoginForm onLogin={handleLogin} />
        {loginError && <p className="global-error">{loginError}</p>}
      </>
    );
  }

  return (
    <div className={`app role-${loggedInUser.role.toLowerCase()}`}>
      <Header loggedInUser={loggedInUser} onLogout={handleLogout} />
      <Dashboard
        loggedInUser={loggedInUser}
        searchText={searchText}
        selectedCategory={selectedCategory}
        sortBy={sortBy}
        onSearchChange={setSearchText}
        onCategoryChange={setSelectedCategory}
        onSortChange={setSortBy}
        products={sortedProducts}
        onAddProduct={handleAddProduct}
        onUpdateProduct={handleUpdateProduct}
        onRemoveLowRatedProduct={handleRemoveLowRatedProduct}
      />
      {/* <h1> Product Gallery</h1>
      <SearchBox searchText={searchText} onSearchChange={setSearchText} />
      <CategoryFilter
        selectedCategory={selectedCategory}
        onCategoryChange={setSelectedCategory}
      />

      <SortDropdown soryBy={sortBy} onSortChange={setSortBy} />
      <ProductList products={sortedProducts} /> */}
    </div>
  );
}

export default App;