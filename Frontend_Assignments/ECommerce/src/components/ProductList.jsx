import React from "react";
import { ProductCard } from "./ProductCard";

export function ProductList({
  products = [],
  loggedInUser,
  onUpdateProduct,
  onRemoveLowRatedProduct,
  isAdmin,
  isSeller,
}) {
  if (products.length === 0) {
    return <p className="empty-message">No Products found.</p>;
  }
  return (
    <div className={isSeller ? "seller-product-grid" : "product-grid"}>
      {products.map((product) => (
        <ProductCard
          key={product.id}
          product={product}
          loggedInUser={loggedInUser}
          onUpdateProduct={onUpdateProduct}
          onRemoveLowRatedProduct={onRemoveLowRatedProduct}
          isAdmin={isAdmin}
          isSeller={isSeller}
        />
      ))}
    </div>
  );
}