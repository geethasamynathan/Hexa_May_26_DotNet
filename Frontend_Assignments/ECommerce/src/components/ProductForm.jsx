import { useState } from "react";

const emptyProduct = {
  name: "",
  price: "",
  category: "",
  stock: "",
  rating: "",
  seller: "",
  image: "",
  description: "",
};

export function ProductForm({
  mode = "add",
  productToEdit = null,
  onSubmitProduct,
  onCancel,
  loggedInUser,
}) {
  const [productData, setProductData] = useState(
    productToEdit || {
      ...emptyProduct,
      seller: loggedInUser?.name || "",
      image: "https://picsum.photos/seed/new-product/600/400",
    },
  );

  const [errorMessage, seterrorMessage] = useState("");
  const [successMessage, setSuccessMessage] = useState("");

  function handleInputChange(event) {
    const { name, value } = event.target;

    setProductData({
      ...productData,
      [name]: value,
    });
  }
  function validateProduct() {
    if (productData.name.trim() === "") {
      return "product name is required.";
    }

    if (productData.description.trim() === "") {
      return "product description is required.";
    }
    if (productData.category.trim() === "") {
      return "category  is required.";
    }
    if (productData.price === "" || Number(productData.price) <= 0) {
      return "Price must be greater than 0.";
    }
    if (productData.stock === "" || Number(productData.stock) < 0) {
      return "Stock cannot be negative.";
    }

    if (
      productData.rating === "" ||
      Number(productData.rating) < 1 ||
      Number(productData.rating) > 5
    ) {
      return "Rating must be between 1-5.";
    }
    if (productData.seller.trim() === "") {
      return "seller name is required.";
    }
    if (productData.image.trim() === "") {
      return "Image URL  is required.";
    }
    return "";
  }

  function handleSubmit(event) {
    event.preventDefault();

    const validationError = validateProduct();
    if (validationError) {
      seterrorMessage(validationError);
      setSuccessMessage("");
      return;
    }
    const finalProduct = {
      ...productData,
      price: Number(productData.price),
      stock: Number(productData.stock),
      rating: Number(productData.rating),
    };
    onSubmitProduct(finalProduct);
    seterrorMessage("");
    setSuccessMessage(
      mode === "add"
        ? "Product Added Successfully."
        : "Product Updated Successfully.",
    );

    if (mode === "add") {
      setProductData({
        ...emptyProduct,
        seller: loggedInUser.name || "",
        image: "https://picsum.photos/seed/new-product/600/400",
      });
    }

    if (mode === "edit" && onCancel) {
      onCancel();
    }
  }

  return (
    <>
      <section className="product-form-card">
        <h2>{mode === "add" ? "Add New Product" : "Update Product"}</h2>
      </section>

      <form className="product-form" onSubmit={handleSubmit}>
        {errorMessage && <p className="form-error">{errorMessage}</p>}
        {successMessage && <p className="form-success">{successMessage}</p>}
        <div className="form-row">
          <div className="form-group">
            <label htmlFor={`${mode}-name`}>Product Name</label>
            <input
              type="text"
              id={`${mode}-name`}
              name="name"
              value={productData.name}
              onChange={handleInputChange}
              placeholder="Enter  Product name"
            />
          </div>
          <div className="form-group">
            <label htmlFor={`${mode}-category`}>Category</label>
            <select
              id={`${mode}-category`}
              name="category"
              value={productData.category}
              onChange={handleInputChange}
            >
              <option value="Electronics">Electronics</option>
              <option value="Home">Home</option>
              <option value="Fashion">Fashion</option>
              <option value="Kitchen">Kitchen</option>
            </select>
          </div>
        </div>
        <div className="form-row">
          <div className="form-group">
            <label htmlFor={`${mode}-price`}>Price</label>
            <input
              id={`${mode}-price`}
              name="price"
              type="number"
              value={productData.price}
              onChange={handleInputChange}
              placeholder="Enter price"
            />
          </div>
          <div className="form-group">
            <label htmlFor={`${mode}-stock`}>Stock</label>
            <input
              id={`${mode}-stock`}
              name="stock"
              type="number"
              value={productData.stock}
              onChange={handleInputChange}
              placeholder="Enter stock"
            />
          </div>
          <div className="form-group">
            <label htmlFor={`${mode}-rating`}>Rating</label>
            <input
              id={`${mode}-rating`}
              name="rating"
              type="number"
              step="0.1"
              min="1"
              max="5"
              value={productData.rating}
              onChange={handleInputChange}
              placeholder="1 to 5"
            />
          </div>
          <div className="form-group">
            <label htmlFor={`${mode}-seller`}>Seller</label>
            <input
              id={`${mode}-seller`}
              name="seller"
              type="text"
              value={productData.seller}
              onChange={handleInputChange}
              placeholder="Enter seller name"
            />
          </div>
          <div className="form-group">
            <label htmlFor={`${mode}-description`}>Description</label>
            <input
              id={`${mode}-description`}
              name="description"
              type="text"
              value={productData.description}
              onChange={handleInputChange}
              placeholder="Enter product description"
            />
          </div>
          <div className="form-actions">
            <button type="submit" className="primary-btn">
              {mode === "add" ? "Add Product" : "Save changes"}
            </button>
            {mode === "edit" && (
              <button
                type="button"
                className="secondary-btn"
                onClick={onCancel}
              >
                Cancel
              </button>
            )}
          </div>
        </div>
      </form>
    </>
  );
}