let selectedVehicle = null;
let menuType = null;
let garage = null;
let garageList = [];
let vehicles = [];

let setBar = async (targetBar, percentage) => {
  let roundedPercentage = percentage;
  if (percentage.toString().length >= 2) {
    if (percentage.toString().slice(1, 2) >= 5) {
      roundedPercentage =
        percentage + (10 - parseInt(percentage.toString().slice(1, 2)));
    } else
      roundedPercentage =
        percentage - parseInt(percentage.toString().slice(1, 2));
  } else {
    if (percentage >= 5) roundedPercentage = 10;
    else roundedPercentage = 0;
  }

  $(targetBar).siblings(":nth-child(3)").text(percentage);

  $(targetBar).children().removeClass("long-info-small-bar-filled");

  for (
    let i = 0;
    i <
    (roundedPercentage?.toString().length == 2
      ? parseInt(roundedPercentage.toString().slice(0, 1))
      : roundedPercentage?.toString().length == 1
      ? -1
      : 10);
    i++
  ) {
    $(targetBar)
      .children(`:nth-child(${i + 1})`)
      .addClass("long-info-small-bar-filled");
  }
};

let findGarageName = (garageId) => {
  return garageList.find((x) => x.id === garageId)?.name || "Unknown";
};

let onVehicleSelect = (vehicle) => {
  if (vehicle) {
    $("#license_plate").text(vehicle.plate);
    $("#park_status").text(vehicle.stored ? "Parked" : "Outside");
    $("#park_location").text(findGarageName(vehicle.garage));
    $("#worth").html(
      vehicle.price?.toString()?.replace(/\B(?=(\d{3})+(?!\d))/g, ".") +
        "&nbsp;$"
    );

    setBar("#engine_bar", ((vehicle.properties?.modEngine || 0) * 2 + 1) * 10);
    setBar(
      "#engine-health_bar",
      Math.round(
        vehicle.properties.engineHealth > 0
          ? (vehicle.properties?.engineHealth || 1000) / 10
          : 0
      )
    );
    setBar("#break_bar", ((vehicle.properties?.modBreak || 0) * 2 + 1) * 10);
    setBar(
      "#suspension_bar",
      ((vehicle.properties?.modSuspension || 0) * 2 + 1) * 10
    );

    setBar(
      "#max-speed_bar",
      Math.round((vehicle.properties?.max_speed / 150) * 100)
    );
    setBar("#fuel_bar", vehicle?.fuel || 100);
  } else {
    $("#license_plate").html("&nbsp;");
    $("#park_status").html("&nbsp;");
    $("#park_location").html("&nbsp;");
    $("#worth").html("&nbsp;");

    setBar("#engine_bar", 0);
    setBar("#engine-health_bar", 0);
    setBar("#break_bar", 0);
    setBar("#suspension_bar", 0);
    setBar("#max-speed_bar", 0);
    setBar("#fuel_bar", 0);
  }
};

let findImageForTargetVehicle = async (vehicle) => {
  let imageTypes = ["png", "jpg", "jpeg", "svg"];
  let targetImage = null;

  for (let i = 0; i < imageTypes.length; i++) {
    let image = `vehicles/${vehicle}.${imageTypes[i]}`;
    let imageExists = await fetch(image)
      .then((res) => {
        if (res.ok) return true;
        else return false;
      })
      .catch(() => false);

    if (imageExists) {
      targetImage = image;
      break;
    }
  }

  if (targetImage) return targetImage;
  else return null;
};

let appendVehicleToUI = (vehicle) => {
  $(".vehicles").append(`
    <div data-id="${vehicle?.id}" class="vehicle">
      <div class="vehicle-bg ${
        !vehicle?.stored ? "vehicle-notstored-bg" : ""
      }"></div>
      <div class="vehicle-upper">
        <p style="font-family: Joyride">${vehicle?.category?.toUpperCase()}</p>
        <p>${vehicle?.name}</p>
      </div>
      <div class="vehicle-mid">
        <img src="https://raw.githubusercontent.com/MericcaN41/gta5carimages/main/images/${vehicle?.model?.toLowerCase()}.png" />
      </div>
      <div class="vehicle-lower">
        <div onclick="vehicleSelectBtnClick(this)" class="vehicle-select-btn">Select Vehicle</div>
      </div>
    </div>
  `);

  $(".vehicle-mid img")
    .off("error")
    .on("error", async function () {
      const id = $(this).parent().parent().attr("data-id");
      const vehicle = vehicles.find((x) => x.id == id);

      if (vehicle) {
        const image = await findImageForTargetVehicle(vehicle.displayName);

        if (image) {
          $(this).attr("src", image);
        } else {
          $(this).css("display", "none");
        }
      }
    });
};

const vehicleSelectBtnClick = function (el) {
  const vehicleId = $(el).parent().parent().attr("data-id");

  if (vehicleId && vehicleId != selectedVehicle) {
    $(".vehicles")
      .children()
      .children(".vehicle-bg")
      .removeClass("vehicle-selected");
    $(".vehicles")
      .children()
      .children(".vehicle-lower")
      .children()
      .text("Select Vehicle");

    selectedVehicle = vehicleId;

    $(el).text("Selected");

    $(el).parent().siblings(".vehicle-bg").addClass("vehicle-selected");

    onVehicleSelect(vehicles.find((x) => x.id === vehicleId));
  } else if (vehicleId && vehicleId == selectedVehicle) {
    selectedVehicle = null;

    $(el).text("Select Vehicle");

    $(el).parent().siblings(".vehicle-bg").removeClass("vehicle-selected");

    onVehicleSelect(null);
  }
};

const searchVehicleInput = function () {
  const newValue = $("#search_vehicle").val().trim()?.toLowerCase();

  $(".vehicles").children().remove();

  if (!newValue) {
    for (let i = 0; i < vehicles.length; i++) {
      appendVehicleToUI(vehicles[i]);
    }
  } else {
    let matchingVehicles = vehicles.filter(
      (x) =>
        x?.name?.toLowerCase().includes(newValue) ||
        x?.plate?.toLowerCase().includes(newValue) ||
        x?.category?.toLowerCase().includes(newValue)
    );

    for (let i = 0; i < matchingVehicles.length; i++) {
      appendVehicleToUI(matchingVehicles[i]);
    }
  }
};

const quitBtnClick = function () {
  $.post(`https://${GetParentResourceName()}/hideMenu`);

  selectedVehicle = null;
  onVehicleSelect(null);
};

const spawnVehicleBtnClick = function () {
  if (
    !selectedVehicle &&
    vehicles.find((x) => x.id === selectedVehicle)?.stored
  )
    return;

  $.post(
    `https://${GetParentResourceName()}/spawnVehicle`,
    JSON.stringify({
      vehicle: vehicles.find((x) => x.id === selectedVehicle),
      garage,
      payBill: menuType == "impound" ? true : false,
    })
  );
};

const repairVehicleBtnClick = function () {
  const vehicle = vehicles.find((x) => x.id == selectedVehicle);

  if (!vehicle) return;

  fetch(`https://${GetParentResourceName()}/repairVehicleEngine`, {
    method: "POST",
    body: JSON.stringify({
      plate: vehicle.plate,
      garage,
    }),
  })
    .then((res) => res.json())
    .then((success) => {
      if (success) {
        setBar("#engine-health_bar", 100);
        for (let i = 0; i < vehicles.length; i++) {
          if (vehicles[i].id == vehicle.id) {
            vehicles[i].properties.engineHealth = 1000;
          }
        }
      }
    });
};

$(document).ready(() => {
  $("#quit_btn").off("click").on("click", quitBtnClick);
  $("#repair-vehicle_btn").off("click").on("click", repairVehicleBtnClick);
  $("#spawn-vehicle_btn").off("click").on("click", spawnVehicleBtnClick);
  $("#search_vehicle").off("input").on("input", searchVehicleInput);
});

window.addEventListener("message", (msg) => {
  switch (msg.data?.action) {
    case "show":
      $(".container").css("opacity", 1);
      break;

    case "hide":
      $(".container").css("opacity", 0);

      selectedVehicle = null;
      onVehicleSelect(null);
      break;
  }

  if (msg.data.garage) garage = msg.data.garage;
  if (msg.data.garageList) garageList = msg.data.garageList;

  if (msg.data.vehicles) {
    $(".vehicles").children().remove();

    vehicles = msg.data.vehicles;

    for (let i = 0; i < vehicles.length; i++) {
      let vehicle = vehicles[i];

      appendVehicleToUI(vehicle);
    }
  }

  if (msg.data?.type) {
    $("#menu_type").text(msg.data?.type?.toUpperCase());
    menuType = msg.data.type;
  }

  if (msg.data?.engineRepairCost) {
    $("#spawn-vehicle_cost").css("display", "block");
    $("#engine-repair_cost").text(`${msg.data?.engineRepairCost}$`);
  } else {
    $("#spawn-vehicle_cost").css("display", "none");
  }

  if (msg.data?.spawnVehicleCost) {
    $("#spawn-vehicle_cost").css("display", "block");
    $("#spawn-vehicle_cost").text(`${msg.data?.spawnVehicleCost}$`);
  } else {
    $("#spawn-vehicle_cost").css("display", "none");
  }
});

window.addEventListener("keydown", (e) => {
  if (e.key == "Escape") $("#quit_btn").trigger("click");
});

//window.postMessage({ action: "show" });
