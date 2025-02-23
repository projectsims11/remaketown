$(document).ready(function () {
    let loaded = 0;
    let rowCount = 0; // Track number of rows in the current column

    window.addEventListener('message', function (event) {
        // console.log("Received :", event.data);  

        if (loaded == 0){
            if (Array.isArray(event.data.textData)) {
                event.data.textData.forEach(data => {
                    if (data.Key) {
                        loaded = loaded + 1;
                        addRow(data);
                    }
                });
            } else {
                console.error("No textData received or it's not an array.");
            }
        }

        if (event.data.type === true) {
            $(".main-context").css("transform", "translateX(10%)"); // Show the UI
        } else if (event.data.type === false) {
            $(".main-context").css("transform", "translateX(-200%)"); // Hide the UI
        }
    });

    function addRow(data) {
        if (rowCount === 0) {
            // Create the first column when the first row is added
            $('<div class="column"></div>').appendTo('.main-context');
        }

        if (rowCount === 11) {
            // Create a new column after 13 rows
            $('<div class="column"></div>').appendTo('.main-context');
            rowCount = 0; // Reset row count for new column
        }

        // Add the row to the last column
        const row = template(data);
        const currentColumn = $('.main-context .column').last();
        currentColumn.append(row);

        rowCount++; // Increment the row count for the current column
    }

    function template(data) {
        return `
            <div class="row">
                <div class="col col-1">${data.Key}</div>
                <div class="col"> - ${data.Description}</div>
            </div>
        `;
    }
});
