var _Config = {};
_Config['ContainerID'] = '#notifications';
_Config['URL_NUI_Images'] = 'nui://Fewthz_inventory/html/img/items/';
_Config['TimeOut'] = 0x5 * 0x3e8;
_Config['Layout'] = 'layout-uptodown';
_Config['Prefix'] = {
    'added': '+ Add',
    'remove': '- remove',
    'use_weapon': '# ใช้อาวุธ'
};

$(document).ready(function(){
    window.addEventListener('message', event => {
        let data = event['data'];
        if (data['action'] === 'notify') {
            xZC_Notify(data['item_label'], data['item_name'], data['item_count'], data['type']);
            return;
        } else if (data['action'] === 'Config_Settings') {
            _Config['URL_NUI_Images'] = data['URL_NUI_Images'];
            _Config['TimeOut'] = data['TimeOut'];
            _Config['Prefix'] = data['Prefix'];
            _Config['Layout'] = data['Layout'];
            $('#notifications').attr('class', 'xZR-Notify ' + _Config['Layout']);
            return;
        }
    });
});

var Icount = 0

xZC_Notify = function(label, name, count, type) {
    Icount = Icount + 1
    let _0x237e32 = $(_Config['ContainerID']);
    let _0x21c762 = '<div class="box-item type-' + type + ' fade-in-bottom box-id-' + Icount + '">';
    _0x21c762 += '<div class="item-img">';
    _0x21c762 += '<img src="' + _Config['URL_NUI_Images'] + name + '.png">';
    _0x21c762 += '</div>';
    _0x21c762 += '<div class="item-info">';
    _0x21c762 += '<div class="item-info-type"><p>';
    if (_Config["Prefix"][type]) {
        _0x21c762 += _Config["Prefix"][type];
    }
    _0x21c762 += '</p></div>';
    _0x21c762 += '<div class="item-info-name">';
    _0x21c762 += (count > 0x0) ? '<p>' + label + ' จำนวน ' + count + ' ชิ้น </p>' : '<p>' + label + '</p>';
    _0x21c762 += "</div>";
    _0x21c762 += '</div>';
    _0x21c762 += '</div>';
    let _0x14aeb9 = $(_0x21c762);
    _0x237e32['append'](_0x14aeb9);

    setInterval(function () {
        _0x14aeb9['remove']();
    }, _Config['TimeOut']);
};