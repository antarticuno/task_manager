// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.scss"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"
import jQuery from 'jquery';

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"
//
window.jQuery = window.$ = jQuery;
import "bootstrap";

//console.log(window.current_time_block);

$(function () {
  $("button.edit-time-block").click((ev) => {
    let tbid = $(ev.target).data('time-block-id');
    let date = $('#date-'+tbid)[0].value;
    let time = $('#time-'+tbid)[0].value;
    let end_time = new Date(date + ' ' + time);
    let text = JSON.stringify({
      time_block: {
        assign_id: $("#time-button").data('assign-id'),
        end_time: end_time, 
      },
    });
    console.log(text);

    $.ajax("/ajax/time_blocks/" + tbid, {
      method: "put",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: text,
      success: (resp) => {
        location.reload();
      },
    });

  });
});

$(function () {
  $("button.delete-time-block").click((ev) => {
    let tbid = $(ev.target).data('time-block-id');
    $.ajax("/ajax/time_blocks/" + tbid, {
      method: "delete",
      success: (resp) => {
	if (window.current_time_block == tbid) window.current_time_block = -1;
	//$(".container").load(window.location.pathname);
	location.reload();
      },
    });

  });
});

$(function () {
  $('#time-button').click((ev) => {
    if (window.current_time_block) {
      stop_working();
    }
    else {
      start_working();
    }
  });
});

function start_working() {
    let start_time = new Date();
    let assign_id = $("#time-button").data('assign-id');
    let end_time = null;

    let text = JSON.stringify({
      time_block: {
        assign_id: assign_id,
        end_time: end_time,
        start_time: start_time,
      },
    });

    $.ajax("/ajax/time_blocks", {
      method: "post",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: text,
      success: (resp) => {
        window.current_time_block = resp.data.id;
        $('#time-button').text("Close Time Block");
	$('#time-button').attr('class', 'btn btn-danger');
      },
    });

}

function stop_working() {
  let end_time = new Date();
  let assign_id = $('#time-button').data('assign-id');
  let text = JSON.stringify({
    time_block: {
      assign_id: assign_id,
      end_time: end_time,
    }
  });

  $.ajax("/ajax/time_blocks/" + window.current_time_block, {
    method: "put",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => {
      window.current_time_block = -1;
      location.reload();
      //$('#time-block-text').text("Finished Time Block Successfully!");
    },
  });
}
