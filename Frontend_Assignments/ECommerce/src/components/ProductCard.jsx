import React, { useState } from "react";
import { ProductForm } from "./ProductForm";

export function ProductCard({
  product,
  loggedInUser,
  onUpdateProduct,
  onRemoveLowRatedProduct,
  isAdmin,
  isSeller,
}) {
  const [isEditiing, setIsEditing] = useState(false);
  //implementing Destructuring
  const { name, price, category, stock, rating, seller, image, description } =
    product;

  function handleUpdateProduct(updatedProduct) {
    onUpdateProduct({
      ...updatedProduct,
      id: product.id,
    });
    setIsEditing(false);
    if (isEditiing) {
      retrun(
        <ProductForm
          mode="edit"
          productToEdit={product}
          onSubmitProduct={handleUpdateProduct}
          onCancel={() => setIsEditing(false)}
          loggedInUser={loggedInUser}
        />,
      );
    }
  }
  return (
    <>
      <article className={isSeller ? "seller-product-card" : "product-card"}>
        <img src={image} alt={name} />
        <div className="product-content">
          <span className="category-badge">{category}</span>

          <h3>{name}</h3>
          <p>{description}</p>
          <p>
            <strong>Selelr:</strong> {seller}
          </p>
          <p>
            <strong>Rating:</strong> {rating}
          </p>
          <h3> Price: {price}</h3>

          {stock === 0 ? (
            <p className="out-stock">Out Of Stock</p>
          ) : stock <= 5 ? (
            <p className="low-stock">Only {stock} left.</p>
          ) : (
            <p className="in-stock">In Stock: {stock}</p>
          )}

          <button type="button" disabled={stock === 0}>
            {stock === 0 ? "Unavailable" : "Add To Cart"}
          </button>

          {isSeller && (
            <button
              type="button"
              className="seller-edit-button"
              onClick={() => setIsEditing(true)}
            >
              Update Product
            </button>
          )}

          {isAdmin && rating <= 1 && (
            <button
              type="button"
              className="admin-remove-btn"
              onClick={() => onRemoveLowRatedProduct(product.id)}
            >
              Remove Low Rated Product
            </button>
          )}
        </div>
      </article>
      {/* <div className="product-card">
        <img src={image} alt={name} />
        <div className="product-content">
          <p className="category">{category}</p>
          <h2>{name}</h2>
          <p>{description}</p>
        </div>

        <div className="product-info">
          <span>Seller : {seller}</span>
          <span>Rating : ⭐ {rating}</span>
        </div>

        <h3>Price: {price}</h3>

        {stock === 0 ? (
          <p className="out-stock">Out of Stock</p>
        ) : stock <= 5 ? (
          <p className="low-stock"> Only {stock} left </p>
        ) : (
          <p className="in-stock">In Stock :{stock}</p>
        )}

        <button disabled={stock === 0}>
          {stock === 0 ? "Unavailable" : "Add to Cart"}
        </button>
      </div> */}
    </>
  );
}