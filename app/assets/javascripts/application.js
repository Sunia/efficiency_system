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
    data = '<tr>'
    data +=  '<td class="font_size-10"><input type="number" name="passage[][lat_degree]" id="passage_lat_degree" required="required" min="0" max="90" style="width: 140px;"></td>'
    data += '<td class="font_size-10"> <input type="number" name="passage[][lat_min]" id="passage_lat_min" required="required" step="0.01" min="0.00" max="59.99" style="width: 140px;"> </td>'

    data += '<td class="font_size-10"><select name="passage[][lat_dir]" style ="width: 80px;">'

    data += '<option value="N">North</option><option value="S">South</option></select></td>'

    data += '<td class="font_size-10"><input type="number" name="passage[][long_degree]" id="passage_long_degree" required="required" min="0" max="90" style="width: 140px;"></td>'
    data += '<td class="font_size-10"> <input type="number" name="passage[][long_min]" id="passage_long_min" required="required" step="0.01" min="0.00" max="59.99" style="width: 140px;"> </td>'

    data += '<td class="font_size-10"><select name="passage[][long_dir]"  style ="width: 80px;">'
    data += '<option value="E">East</option><option value="W">West</option></select></td>'

    data += "<td><img src='/assets/delete.png' style='height: 10%;' onClick='deleteRow(this)'> </td>"
    data += '</tr>'
    $('#passage_table tr:last').after(data);

  });
});
