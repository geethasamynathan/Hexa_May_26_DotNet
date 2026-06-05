using ECommerceCompany.Models;
using ECommerceCompany.Services;
using System;
using System.Collections.Generic;
using System.Security.Cryptography;
using System.Text;

namespace ECommerceCompany.Tests
{
    [TestFixture]
    public class ServiceTests
    {
        private Order _order;
        private OrderBillingService _billingService;

        [SetUp]
        public void Setup()
        {
            _order = new Order(1000, 4);
            _billingService = new OrderBillingService();
        }

        [Test]
        public void When_Invalid_Input_Calc_SubTotal()
        {
            ArgumentException exception = Assert.Throws<ArgumentException>(() =>
            _billingService.CalculateSubTotal(0, 100));

            Assert.That(exception.Message, Is.EqualTo("Product Price or Quantity should not be zero or negative"));

        }

        [TestCase(50000, 5000)]
        [TestCase(5000, 500)]
        [TestCase(3000, 150)]
        [TestCase(500, 0)]
        public void When_CalculateDiscount_Return(decimal subtotal,decimal discount)
        {
            decimal dis = _billingService.CalculateDiscount(subtotal);
            Assert.That(dis, Is.EqualTo(discount));
        }

        [TestCase(1500,0)]
        [TestCase(2000,0)]
        [TestCase(999,100)]
        [TestCase(500,100)]
        public void When_CalculateDeliveryCharge_Return(decimal amount, decimal deliveryCharge) {

            decimal delivery = _billingService.CalculateDeliveryCharge(amount);
            Assert.That(delivery, Is.EqualTo(deliveryCharge));
        }
        [TestCase(100,7,800)]
        [TestCase(1000,5,4500)]
        [TestCase(900, 7,5670)]
        [TestCase(500,2,1000)]
        public void When_CalculateFinalAmount_Return(decimal productPrice,int Quantity,decimal finalAmount)
        {
            decimal fullamount = _billingService.CalculateFinalAmount(productPrice, Quantity);
            Assert.That(fullamount, Is.EqualTo(finalAmount));

        }

        [Test]
        public void When_CalculateFinalAmount_Invalid_Input_Return()
        {
            ArgumentException exception = Assert.Throws<ArgumentException>(()=>
                _billingService.CalculateFinalAmount(0, 6));
            Assert.That(exception.Message, Is.EqualTo("Product Price or Quantity should not be zero or negative"));
        }

        [TestCase(100,5,500)]
        [TestCase(1000,2,2000)]
        [TestCase(500,4,2000)]
        public void When_CalculateSubtotal_Return(decimal productPrice, int Quantity, decimal Subtotal)
        {
            decimal subtotalamount = _billingService.CalculateSubTotal(productPrice, Quantity);
            Assert.That(subtotalamount, Is.EqualTo(Subtotal));

        }

        [TestCase(100,0)]
        [TestCase(100,-5)]
        [TestCase(-100,5)]
        public void When_CalculateFinalAmount_Negative_Input_Return(decimal price, int qty)
        {
            ArgumentException exception = Assert.Throws<ArgumentException>(() =>
                _billingService.CalculateFinalAmount(0, 6));
            Assert.That(exception.Message, Is.EqualTo("Product Price or Quantity should not be zero or negative"));
        }

    }

}
