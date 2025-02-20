const convertValue = (value, oldMin, oldMax, newMin, newMax) => {
	const oldRange = oldMax - oldMin
	const newRange = newMax - newMin
	const newValue = ((value - oldMin) * newRange) / oldRange + newMin
	return newValue
}

let keyboardBox = true;
let newsBox = true;
let authorBox = true;

$(async function () {
    $(window).ready(() => {
        $(".left .bottom, .right .bottom, .left .top, .right .top").css("transition", "opacity 0.5s, transform 1s")
        $(".left .bottom, .right .bottom, .left .top, .right .top").css("opacity", 1)
        $(".left .bottom, .right .bottom, .left .top, .right .top").css("transform", "translateX(0)")

		$(".center").css("transition", "opacity 0.5s, transform 1s")
        $(".center").css("opacity", 1)
        $(".center").css("transform", "translateX(0)")
    });

	$("#keyboard").click(() => {
		if(keyboardBox){
			keyboardBox = false;
			$("#keyboard").removeClass("active")
			$(".center").css("opacity", 0)
			$(".center").css("transform", "translateY(-300px)")
		}else{
			keyboardBox = true;
			$("#keyboard").addClass("active")
			$(".center").css("opacity", 1)
			$(".center").css("transform", "translateY(0)")
		}
	});

	$("#author").click(() => {
		if(authorBox){
			authorBox = false;
			$("#author").removeClass("active")
			$(".right .top").css("opacity", 0)
			$(".right .top").css("transform", "translateX(300px)")
		}else{
			authorBox = true;
			$("#author").addClass("active")
			$(".right .top").css("opacity", 1)
			$(".right .top").css("transform", "translateX(0)")
		}
	});

	$("#news").click(() => {
		if(newsBox){
			newsBox = false;
			$("#news").removeClass("active")
			$(".left .top").css("opacity", 0)
			$(".left .top").css("transform", "translateX(-300px)")
		}else{
			newsBox = true;
			$("#news").addClass("active")
			$(".left .top").css("opacity", 1)
			$(".left .top").css("transform", "translateX(0)")
		}
	});

	const Config = await fetch(`../../config.json`).then((res) => res.json())

	const news = Config.News

	news.forEach((neww) => {
		$("#new-wrapper").prepend(`
		<div class="new">
			<div class="title-sec">
				<div class="title">${neww.title}</div>
				<div class="subtitle">${neww.subtitle}</div>
			</div>
			<div class="desc">${neww.description}</div>
			<div class="new-img">
				<img src="assets/img/news-images/${neww.image}">
			</div>
		</div>
		`)

		$("#newCounter").text(news.length + " News")
	})

	const authors = Config.Authors

	authors.forEach((author) => {
		$("#author-wrapper").append(`
		<div class="author">
			<svg class="author-bg" width="401" height="59" viewBox="0 0 401 59" fill="none" xmlns="http://www.w3.org/2000/svg">
				<rect x="0.807956" y="0.807956" width="399.384" height="57.3841" rx="3.23183" fill="url(#paint0_linear_13_38)" fill-opacity="0.04" stroke="url(#paint1_linear_13_38)" stroke-width="1.61591"/>
				<defs>
				<linearGradient id="paint0_linear_13_38" x1="384.384" y1="24.9409" x2="93.3607" y2="152.904" gradientUnits="userSpaceOnUse">
				<stop stop-color="#ffffff"/>
				<stop offset="1" stop-color="#ffffff" stop-opacity="0"/>
				</linearGradient>
				<linearGradient id="paint1_linear_13_38" x1="423.155" y1="25.2091" x2="0.418727" y2="38.9221" gradientUnits="userSpaceOnUse">
				<stop stop-color="#242226"/>
				<stop offset="1" stop-color="#242226" stop-opacity="0"/>
				</linearGradient>
				</defs>
			</svg>

			<div class="author-pp"><img src="assets/img/author-images/${author.image}"></div>

			<div class="author-desc">
				<div class="name">${author.name}</div>
				<div class="rank">${author.rank}</div>
			</div>
		</div>
		`)

		$("#authorCounter").text(authors.length + " Authors")
	})

	const keys = Config.Keys

	keys.forEach((key) => {
		$("#keys").append(`
		<div class="key-wrap">
			<div class="key">${key.key}</div>
			<div class="cont">
				<div class="title">${key.title}</div>
				<div class="desc">${key.description}</div>
			</div>
		</div>
		`)

		$("#keyCounter").text(keys.length + " Keys")
	})
	
	function secondsToDuration(sec) {
		return `${Math.floor(sec / 60)
			.toString()
			.padStart(2, "0")}:${Math.round(sec % 60)
			.toString()
			.padStart(2, "0")}`
	}
	
	let audio = null
	let audioId = -1
	let audioInterval = null
	let audioTime = 0
	
	function stopAudio() {
		if (audio) {
			audio.stop()
	
			clearInterval(audioInterval)
	
			audio = null
			audioId = -1
			audioInterval = null
	
			$(".music-name").text("Not Playing")
			$(".music-owner").text("Unknown")
		}
	}
	
	function playAudio(id) {
		stopAudio()
	
		const music = Config.Music[id]
	
		if (music) {
			audio = new Howl({
				src: music.path,
				volume: 0.1,
				onend: () => nextSong(),
			})
	
			resumeAudio()
			audioId = id
			audioInterval = setInterval(() => {
				if (audio.playing()) {
					$(".music-bar .prog").css("width", (audio.seek() / audio.duration()) * 100 + "%")
				}
			}, 1000)
	
			$(".music-name").text(music.songname)
			$(".music-owner").text(music.owner)
		}
	}
	
	function pauseAudio() {
		if (audio) {
			audio.pause()
	
			$("#play").show()
			$("#stop").hide()
		}
	}
	
	function resumeAudio() {
		if (audio) {
			audio.play()
	
			$("#play").hide()
			$("#stop").show()
		}
	}
	
	function nextSong(prev) {
		if (audio) {
			prev ? audioId-- : audioId++
	
			if (audioId >= Config.Music.length) audioId = 0
			else if (audioId < 0) audioId = Config.Music.length - 1
	
			playAudio(audioId)
		}
	}
	
	$(function () {
		$("#play").click(() => resumeAudio())
		$("#stop").click(() => pauseAudio())
		$("#next").click(() => nextSong())
		$("#prev").click(() => nextSong(true))
	
		playAudio(0)
	})

	// $(window).on("message", function ({ originalEvent: e }) {
	// 	$(".wrapper .subtitle").text("Loading: " + e.data.name)
	// 	switch (e.data.eventName) {
	// 		case 'loadProgress':
	// 			$(".topper").css("stroke-dashoffset",  convertValue((e.data.loadFraction * 100).toFixed(0), 0, 100, 226, 0))
	// 			$(".percent span").text((e.data.loadFraction * 100).toFixed(0))
	// 			break;
	// 	}
	// })


	let fakeProgress = 0; // Initialize the fake progress value

$(document).ready(function() {
    // Simulate progress every second
    simulateFakeLoadProgress();
});

function simulateFakeLoadProgress() {
    const interval = setInterval(function () {
        if (fakeProgress >= 1) {
            clearInterval(interval); // Stop once progress reaches 100%
        } else {
            fakeProgress += 0.1; // Increase progress by 10% every second
            updateProgressUI(fakeProgress);
        }
    }, 1000); // Update every second
}

function updateProgressUI(progress) {
    const progressPercentage = (progress * 100).toFixed(0);

    // Update the percentage display
    $(".percent span").text(progressPercentage);

    // Update the progress bar (stroke-dashoffset)
    const strokeOffset = convertValue(progressPercentage, 0, 100, 226, 0); // Assuming 226 is the full circumference of the circle
    $(".topper").css("stroke-dashoffset", strokeOffset);
}

// Function to convert percentage to stroke-dashoffset value for the progress bar
function convertValue(value, min1, max1, min2, max2) {
    // Map the value from the first range to the second range
    return (value - min1) * (max2 - min2) / (max1 - min1) + min2;
}


})