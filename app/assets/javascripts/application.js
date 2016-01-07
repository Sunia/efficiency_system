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

  $( "#new_row" ).on( "click", function( event ) {

    waypoints = $(".way_point_no")
    waypoint_string = waypoints.last()[0].value.split("t")[1]
    waypoint_count = parseInt(waypoint_string) + 1

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
    data += '<td class="font_size-10"> <input type="text" name="passage[][way_point_no]" class="way_point_no" value=Waypoint'+ waypoint_count +' style="width: 70px;"> </td>'

    // Start/End of Sea Passage
    data += '<td class="font_size-10"> <input type="radio" name="passage[][start_point]" id="passage__start_point_true" value="true"></td>'
    data += '<td class="font_size-10"> <input type="radio" name="passage[][end_point]" id="passage__end_point" value="true"></td>'

    // Delete image
    data += "<td><img src='/assets/delete.png' style='height: 10%;' onClick='deleteRow(this)'> </td>"

    data += '</tr>'
    $('#passage_table tr:last').after(data);

  });

  // Click Start point of passage plan
  $( "#start_point" ).on( "click", function( event ) {
    debugger;
    end_point_checked = $(this).parent().parent().find("#end_point")[0].checked

     alert("I am in");
    
    if (end_point_checked == true){
      alert("Start point and end point cannot be same") ;
      $(this)[0].checked = "false";
      return;
    }

  });







});

