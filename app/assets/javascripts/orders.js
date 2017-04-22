$(document).ready(function() {
	setTimeout(function() {
		if ($('#order_order_products_id').val()) {
			updateOrderForm($('#order_order_products_id').val());
		}
		$('#order_order_products_id').change(function() {
			updateOrderForm($('#order_order_products_id').val());
		});
		$('#order_order_products_product_count').change(function() {
			var number = parseFloat($('#order_order_products_product_count').val());
			var price = parseFloat($('#order_order_products_price').val());
			var total_cost = (Math.round(number * price * 100)/100).toFixed(2);
			$('#order_payment_total').text('$'+total_cost.toString()).val(total_cost);
		});
	}, 300);
});

function updateOrderForm(id) {
	$.ajax({
	  method: "GET",
	  dataType: 'json',
	  url: $('#order_order_products_id').data('url'),
	  data: { id: id }
	})
	  .done(function(result) {
	    updateProductCountOptions(result['count'], 'order_order_products_product_count');
	    $('#order_order_products_price').val(result['price']);
	  });
}

function updateProductCountOptions(count, id) {
	var newOptions = {};
	for (var i = 1; i <= count; i++) {
		newOptions[i] = i;
	}
	
	var firstOption = $('#'+id+' option:first').text();
	var $element = $("#"+id);
	$element.empty(); // remove old options
	$element.append($("<option></option>")
	     .attr("value", '').text(firstOption));
	$.each(newOptions, function(key,value) {
	  $element.append($("<option></option>")
	     .attr("value", value).text(key));
	});
	
	if ($('#order_order_products_product_count').data('count')) {
		$('#order_order_products_product_count').val($('#order_order_products_product_count').data('count'));
	}
}
