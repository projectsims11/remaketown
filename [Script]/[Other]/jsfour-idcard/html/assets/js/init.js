$(document).ready(function(){
  // LUA listener
  window.addEventListener('message', function( event ) {
    if (event.data.action == 'open') {
      var type        = event.data.type;
      var userData    = event.data.array['user'][0];
      var licenseData = event.data.array['licenses'];
      var snData = event.data.array['sn'];
      var sex         = userData.sex;
      var fecha       = userData.dateofbirth;
      var trabajo     = userData.job;
      var mes         = fecha.substr(5,2);
      var dd         = fecha.substr(8,2);
      var yy         = fecha.substr(0,4);
      var mes2;
      var trabajo2;


      if ( mes == '01') {
        mes2 = 'Jan'; //bike
      } else if ( mes == '02' ) {
        mes2 = 'Feb';
      } else if ( mes == '03' ) {
        mes2 = 'Mar'; //car
      } else if ( mes == '04' ) {
        mes2 = 'Apr'; //car
      } else if ( mes == '05' ) {
        mes2 = 'May'; //car
      } else if ( mes == '06' ) {
        mes2 = 'Jun'; //car
      } else if ( mes == '07' ) {
        mes2 = 'Jul'; //car
      } else if ( mes == '08' ) {
        mes2 = 'Aug'; //car
      } else if ( mes == '09' ) {
        mes2 = 'Sep'; //car
      } else if ( mes == '10' ) {
        mes2 = 'Oct'; //car
      } else if ( mes == '11' ) {
        mes2 = 'Nov'; //car
      } else if ( mes == '12' ) {
        mes2 = 'Dec'; //car
      }

      if ( trabajo == 'unemployed') {
        trabajo2 = 'CESANTE'; //bike
      } else if ( trabajo == 'mechanic' ) {
        trabajo2 = 'MECHANIC';
      } else if ( trabajo == 'police' ) {
        trabajo2 = 'CARABINERO';
      } else if ( trabajo == 'sheriff' ) {
        trabajo2 = 'CARABINERO';
      }else if ( trabajo == 'ambulance' ) {
        trabajo2 = 'EMS';
      }else if ( trabajo == 'fisherman' ) {
        trabajo2 = 'INFORMAL';
      }else if ( trabajo == 'fueler' ) {
        trabajo2 = 'INFORMAL';
      }else if ( trabajo == 'garbage' ) {
        trabajo2 = 'INFORMAL';
      }else if ( trabajo == 'lumberjack' ) {
        trabajo2 = 'INFORMAL';
      }else if ( trabajo == 'miner' ) {
        trabajo2 = 'INFORMAL';
      }else if ( trabajo == 'slaughterer' ) {
        trabajo2 = 'INFORMAL';
      }else if ( trabajo == 'tailor' ) {
        trabajo2 = 'INFORMAL';
      }else if ( trabajo == 'reporter' ) {
        trabajo2 = 'JOURNALIST';
      }else if ( trabajo == 'taxi' ) {
        trabajo2 = 'TAXI';
      }
      //ADD JOBS HERE 


      if ( type == 'driver' || type == null) {
        $('img').show();
        //$('#name').css('color', '#282828');
        if (sex){
          if ( sex.toLowerCase() == 'm' ) {
             $('img').attr('src', 'assets/images/male.png');
            //$('img').attr('src', link);
            $('#sex').text('Male'); // male
          } else {
             $('img').attr('src', 'assets/images/female.png');
            //$('img').attr('src', link);
            $('#sex').text('Female'); //female
          }
        }else{
          $('#sex').text('LGBT');
        }
  

        $('#name').text(userData.firstname + '\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0' + userData.lastname);
        // $('#dob').text(userData.dateofbirth);
        $('#dob').text(dd + '\xa0' + mes2 + '\xa0' + yy);
        $('#height').text(userData.height);
        $('#ocupation').text(trabajo2);
        $('#signature').text(userData.firstname + userData.lastname); //$('#signature').text(userData.firstname + ' ' + userData.lastname);

        if ( type == 'driver' ) {
          if ( licenseData != null ) {
            Object.keys(licenseData).forEach(function(key) {
              var type = licenseData[key].type;


              if ( type == 'drive_bike') {
                type = 'Motocicletas'; //bike
              } else if ( type == 'drive_truck' ) {
                type = 'Camiones y Buses'; //truck
              } else if ( type == 'drive' ) {
                type = 'Driver License'; //car
              }

              if ( type == 'Motocicletas' || type == 'Camiones y Buses' || type == 'Driver License' ) { // if ( type == 'bike' || type == 'truck' || type == 'car' ) {
                $('#licenses').append('<p>'+ type +'</p>');
                //$('p').css('font-size', '14px'); //BORRAR SI ARRUINA EL NAME
              }
            });
          }
          $('#ocupation').hide();
          $('#id-card').css('background', 'url(assets/images/license.png)');
        } else {
          $('#ocupation').show();
          $('#id-card').css('background', 'url(assets/images/idcard.png)');
        }
      } else if ( type == 'weapon' ) {
        //$('img').hide();
        $('#name').css('color', '#d9d9d9');
        //
        $('#ocupation').hide();
        $('#sex').text('');
        //
        $('#name').text(userData.firstname + '\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0' + userData.lastname);
        //$('#dob').text(userData.dateofbirth);
        var str = snData;
        var res = str.substr(6, 21);
        $('#dob').text(res);
        $('#signature').text(userData.firstname + userData.lastname); //$('#signature').text(userData.firstname + ' ' + userData.lastname);
        $('#id-card').css('background', 'url(assets/images/firearm.png)');
      }

      $('#id-card').show();
    } else if (event.data.action == 'close') {
      $('#name').text('');
      $('#dob').text('');
      $('#height').text('');
      $('#signature').text('');
      $('#sex').text('');
      $('#id-card').hide();
      $('#licenses').html('');
    }
  });
});
