const _e = {};
const container = document.querySelector('.container');

window.addEventListener('message', e => {
    let data = e.data;
    let type = data.type;

    _e[type](data);
});

_e['isBlank'] = (text) => {
    return (!text || /^\s*$/.test(text));
};

_e['dom'] = (textHtml) => {
    let div = document.createElement('div');
    div.innerHTML = textHtml.trim();
    
    return div.firstChild;
};

_e['open'] = () => {
    container.style.opacity = 1;
};

_e['close'] = () => {
    container.style.opacity = 0;
};

_e['setup'] = (data) => {
    let locations = data.locations;
    for(const nameLocation in locations) {
        let current = locations[nameLocation];
        let label = current.Label;
        let html = `
            <option value="${nameLocation}">${label}</option>
        `;

        document.getElementById('location-selector').append(_e['dom'](html));
    }
};

_e['getNearestPlayer'] = (data) => {
    let playerId = data.id;

    document.getElementById('playerid-text').value = playerId;
};

document.getElementById('submit').addEventListener('click', e => {
    e.preventDefault();
    let announce = document.getElementById('announce-text');
    let time = document.getElementById('timer-selector');
    let playerId = document.getElementById('playerid-text');
    let location = document.getElementById('location-selector');
    let locationOption = location.options[location.selectedIndex];

    let verifyAnnounce, verifyTime, verifyPlayer = false;

    if(_e['isBlank'](announce.value)) {
        announce.classList.toggle('not-input');
        setTimeout(() => announce.classList.toggle('not-input'), 2000);
        verifyAnnounce = false;
    } else {
        verifyAnnounce = true;
    }

    if(_e['isBlank'](playerId.value)) {
        playerId.classList.toggle('not-input');
        setTimeout(() => playerId.classList.toggle('not-input'), 2000);
        verifyPlayer = false;
    } else {
        verifyPlayer = true;
    }

    if(_e['isBlank'](time.value)) {
        time.classList.toggle('not-input');
        setTimeout(() => time.classList.toggle('not-input'), 2000);
        verifyTime = false;
    } else {
        verifyTime = true;
    }

    if(verifyAnnounce && verifyTime && verifyPlayer) {
        navigator.sendBeacon(`https://Fewthz_Jail/close`, JSON.stringify({}));
        navigator.sendBeacon(`https://Fewthz_Jail/submit`, JSON.stringify({
            announce: announce.value,
            time: parseInt(time.value),
            location: locationOption.value,
            playerId: parseInt(playerId.value)
        }));

        document.getElementById('announce-text').value = '';
        document.getElementById('timer-selector').value = '';
        document.getElementById('playerid-text').value = '';
    }
});

document.getElementById('cancel').addEventListener('click', e => {
    e.preventDefault();
    document.getElementById('announce-text').value = '';
    document.getElementById('timer-selector').value = '';
    document.getElementById('playerid-text').value = '';

    navigator.sendBeacon(`https://Fewthz_Jail/close`, JSON.stringify({}));
});

document.getElementById('select-nearest-player').addEventListener('click', e => {
    e.preventDefault();

    navigator.sendBeacon(`https://Fewthz_Jail/getNearestPlayer`, JSON.stringify({}));
});

tippy('.btn-selector', {
    content: 'ระบบจะทำการเลือกผู้เล่นที่ใกล้ที่สุดให้โดยอัตโนมัติ',
    placement: 'right'
});