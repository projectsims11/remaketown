$(function() {


	window.addEventListener('message', function(event) {
		if (event.data.type == "enableui") {
			document.body.style.display = event.data.enable ? "block" : "none";
		}
		
	});

	document.onkeyup = function (data) {
		if (data.which == 27) { // Escape key
			$.post('http://esx_identity/escape', JSON.stringify({}));
		}
	};
	
	
	$("#register").submit(function(event) {
		event.preventDefault(); // Prevent form from submitting

		Swal.fire({
			title: 'กรุณากดยืนยันอีกครั้ง',
			text: "หากยืนยันแล้วจะไม่สามารถแก้ไขได้ !",
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#001bbe',
			cancelButtonColor: '#001bbe',
			confirmButtonText: 'CONFIRM',
			cancelButtonText: 'CANCLE',
		  }).then((result) => {
			if (result.isConfirmed) {
				Swal.fire({
					title: 'ลงทะเบียนเสร็จสิ้น',
					text: "ขอให้สนุกกับการสวมบทบาท IC",
					icon: 'success',
					confirmButtonColor: '#001bbe',
				}).then((result1) => {
					$.post('http://esx_identity/register', JSON.stringify({
						firstname: $('#firstname').val(),
						lastname: $('#lastname').val(),
						dateofbirth: $('#dateofbirth').val(),
						height: $('#height').val(),
						sex: $('input[name="sex"]:checked').val()
					}));
					if (result1.isConfirmed) {
						document.getElementById("register").reset();
						document.body.style.display = "none";
					}

				});
			};
		});
	});
});
