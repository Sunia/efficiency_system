// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require dataTables/jquery.dataTables
//= require dataTables/extras/TableTools
//= require dataTables/extras/ZeroClipboard.js
//= require_tree .


$(document).ready(function(){

  // Add new waypoint on the list of passage plan
  $( "#new_waypoint" ).on( "click", function( event ) {

    waypoints = $(".way_point_no")
    waypoint_string = waypoints.last()[0].innerHTML.trim()
    waypoint_count = parseInt(waypoint_string) + 1

    data = make_waypoint_row(waypoint_count);

    $('#passage_table tr:last').after(data);

  });

  // Insert fields of passage plan in a row
  function make_waypoint_row(waypoint_count){
    data = '<tr>'

    // Latitude
    data +=  '<td class="font_size-10"><input type="number" name="passage[][lat_degree]" id="passage_lat_degree" required="required" min="0" max="90" style="width: 60px;"></td>'
    data += '<td class="font_size-10"> <input type="number" name="passage[][lat_min]" id="passage_lat_min" required="required" step="0.01" min="0.00" max="59.99" style="width: 60px;"> </td>'
    data += '<td class="font_size-10"><select name="passage[][lat_dir]" style ="width: 50px;">'
    data += '<option value="N">North</option><option value="S">South</option></select></td>'

    // Longitude
    data += '<td class="font_size-10"><input type="number" name="passage[][long_degree]" id="passage_long_degree" required="required" min="0" max="90" style="width: 60px;"></td>'
    data += '<td class="font_size-10"> <input type="number" name="passage[][long_min]" id="passage_long_min" required="required" step="0.01" min="0.00" max="59.99" style="width: 60px;"> </td>'
    data += '<td class="font_size-10"><select name="passage[][long_dir]"  style ="width: 50px;">'
    data += '<option value="E">East</option><option value="W">West</option></select></td>'

    // RL/GC
    data += '<td class="font_size-10"><select name="passage[][rl_gc]" style="width: 50px;">'
    data += '<option value="RL">RL</option><option value="GC">GC</option></select></td>'

    // Waypoint number
    data += '<td class="font_size-10 way_point_no">' +waypoint_count + '</td>'
    data += '<input type="hidden" name="passage[][waypoint_no]" id="passage__waypoint_no" value="'+ waypoint_count +'">'

    // Start/End of Sea Passage
    data += '<td class="font_size-10"> <input type="radio" name="passage[][start_point]" id="passage__start_point_true" value="true" class="start_point" onClick="match_endpoints(this)"></td>'
    data += '<td class="font_size-10"> <input type="radio" name="passage[][end_point]" id="passage__end_point_true" value="true" class="end_point" onClick="match_startpoints(this)"></td>'

    // Delete image
    data += "<td><img src='/assets/delete.png' style='height: 10%;' onClick='deleteRow(this)'> </td>"

    data += '</tr>'
    return data;
  }

  // $( "#sea_report_zone_time" ).on( "click", function( event ) {
  //   alert("hello");
  //   e = document.getElementById("sea_report_zone_time");
  //   zone_time = e.options[e.selectedIndex].value;

  //   alert(zone_time);
  // });

    $("#sea_report_zone_time").bind("change", function(e){ 

      last_zone_time = $("#hidden_zone_time")[0].value;
      last_zone_time = parseInt(last_zone_time);
      changed_time = parseInt(this.value);

      if (last_zone_time < changed_time){
        hrs = changed_time - last_zone_time;
        var msg = "Ship clocks advanced by " + hrs + " hours";
      }

      else if (last_zone_time > changed_time){
        hrs = last_zone_time - changed_time;
        var msg = "Ship clocks retarded by " + hrs + " hours";
      }
      else {
        var msg = "Ship clock has the same time";
      }

      changeConfirmation = confirm("Are You Sure?");
      if (changeConfirmation) {
        alert(msg);
        $("#sea_report_description")[0].value = msg;
      } else {
       $(this).val(last_zone_time);
      }
    });

  // $(".close_report").on( "click", function( event ) {
  //   e = document.getElementById("sea_report_zone_time");
  //   zone_time = e.options[e.selectedIndex].value;
  //   alert(zone_time);
  // });

});

