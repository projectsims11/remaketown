var toastrs= {};

$(function(){
	window.onload = (e) => { 
		window.addEventListener('message', (event) => {	            
			if(event.data.action == 'notify'){
				
				var inventor_url = 'nui://Fewthz_inventory/html/img/items/';
				var options = event.data;

				options.label = event.data.label;
				options.name = event.data.name;
				options.count = event.data.count;
				options.image = inventor_url + event.data.name + '.png';
				imageExists(options.image, function(exists) {
					if(exists == false){
						options.image = 'no-image.png'
					}
					
					sendNotify(options);
				});

				
			} else if (event.data.type == 'clear'){
				toastr.clear(toastrs[event.data.number], { force: true });
			}

			if(event.data.action == 'printJson'){
				console.log(JSON.stringify(event.data.text))
			}

		});
	};
});

function imageExists(url, callback) {
	var img = new Image();
	img.onload = function() { callback(true); };
	img.onerror = function() { callback(false); };
	img.src = url;
}

function sendNotify(options){
	var toastr_options = {
		timeOut: options.timeout, 
		action: options.action
	};

	let id_number = 0

	id_number = id_number + 1

	if (options.type=='added') {
		
		var html_items = 	`<div class="box-item add" id="item-${options.name}">
								<div class="box-left add">
								<div class="header addheader">
									<p>Add</p>
								</div>
								<div class="item-img"><img src="nui://Fewthz_inventory/html/img/items/${options.name}.png"></div>
								<div class="Box-info">
									<div class="item-info-name">
										<p>${options.name}</p><i class='bx bx-radio-circle-marked iconadd'></i>
									</div>
									<div class="item-info">
										<p>Amount x</p><p>${options.count}</p><i class='bx bx-radio-circle-marked iconadd'></i>
									</div>
								</div>
							</div>`

						if ($("#item_list .box-item").length >= 5) {
							$("#item_list .box-item:first").remove();
						}

						$("#item_list").append(html_items);
						$(`#item-${options.name}`).css('animation', `moveIn 0.3s forwards`)


		setTimeout(function () {
			$(`#item-${options.name}`).css('animation', `moveOut 0.3s forwards`)


			setTimeout(function () {
				$(`#item-${options.name}`).remove();

			}, 100)

		}, 4000)

	} else if (options.type=='remove') {

		var html_items = 	`<div class="box-item remove" id="item-${options.name}">
								<div class="box-left remove">
								<div class="header removeheader">
									<p>Remove</p>
								</div>
									
								<div class="item-img"><img src="nui://Fewthz_inventory/html/img/items/${options.name}.png"></div>
								<div class="Box-info">
									<div class="item-info-name">
										<p>${options.label}</p><i class='bx bx-radio-circle-marked iconremove'></i>
									</div>
									<div class="item-info">
										<p>Amount x</p><p>${options.count}</p><i class='bx bx-radio-circle-marked iconremove'></i>
									</div>
								</div>
							</div>`

						if ($("#item_list .box-item").length >= 5) {
							$("#item_list .box-item:first").remove();
						}

						$("#item_list").append(html_items);
						$(`#item-${options.name}`).css('animation', `moveIn 0.3s forwards`)

						setTimeout(function () {
							$(`#item-${options.name}`).css('animation', `moveOut 0.3s forwards`)
				
							setTimeout(function () {

								$(`#item-${options.name}`).remove();
				
							}, 100)
				
						}, 4000)

	} else if (options.type == 'use') {
		// var $toast = toastr.warning(options.name, options.image, toastr_options); 

		var html_items = $(`<div class="zil_panel_item w3-animate-left" id="item-${options.name}">
								<span class="zil_text_panel"><img class="zil_image_panel" src="${options.image}">${options.name} × ${options.count}</span></span>
							</div>`).appendTo("#item_list")

		// $("#item_list").append(html_items);

		setTimeout(function(){
			// $(`.zil_panel_item`).hide();
			setTimeout(function(){
				$(`#item-${options.name}`).fadeOut(1000).remove();
			}, 800)
		}, 3000)

	}
}