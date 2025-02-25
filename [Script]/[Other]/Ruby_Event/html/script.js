$(document).ready(function () {
    let audio = new Audio("estart.mp3"); // Load the audio file
    TimeEventlog = "0"
    window.addEventListener('message', function (event) {
        let UImsg = event.data
        
        
        if (UImsg.Open == true) {
           
            if (TimeEventlog != UImsg.TimeTrig){
                TimeEventlog = UImsg.TimeTrig
                // console.log("Start "+UImsg.eventdata + " at -> " +TimeEventlog)
        
                $("#container").css("display", "block"); // Show the UI    
                $("#poster-img").attr("src","images/" + UImsg.eventdata + ".png");

                audio.play().then(() => {
                    // console.log("Audio played successfully.");
                }).catch(error => {
                    console.error("Audio playback failed:", error);
                });

                countdownTime = 300; // Set countdown time in seconds
                updateClock(countdownTime); // Start countdown
            }
        } 
    });

    function updateClock(time) {
        if (time >= 0) {
            let minutes = Math.floor(time / 60);
            let seconds = time % 60;
            $("#countdown-clock").text(
                `${minutes} : ${seconds.toString().padStart(2, "0")}`
            );

            // Call updateClock again after 1 second with updated time
            setTimeout(() => updateClock(time - 1), 1000);
        } else {
            $("#container").css("display", "none"); // Hide the UI when countdown ends
        }
    }
});

// document.addEventListener("DOMContentLoaded", function() {
//     setTimeout(() => {
//         window.postMessage({
//             Open: true, 
//             eventdata: "flag"
//         }, "*");
//     }, 2000); // Delays the fake event by 2 seconds
// });


