function OnChangeQuantity(id){
  product_id = id;
  var quantity = $(".quantity_" + product_id).val();
  $.ajax({
      url: "/carts/update",
      method: "put",
      dataType: "json",
      data: {"quantity": quantity, "product_id": product_id},
      success: function(data)
      {
        if(data.message != "Invalid quantity")
        {
          var total= 0;
          for (var i=0; i < data.order_details.length; i++)
          {
            if(data.order_details[i]["product_id"] == product_id)
            {
              data.order_details[i]["quantity"] = data.result.quantity;
            }
            total += ((data.order_details[i]["quantity"])*(data.order_details[i]["price"]));
          }
          $(".total_price").html("$ " + total + ".0");
          $(".total_"+product_id).html("$ "+data.result["quantity"] * data.product[
            "price"] + ".0");
        }
        else
        {
          alert(data.message);
          $(".quantity_" + product_id).val(data.quantity_product);
        }
      }
  });
}
