$(function(){
  $("#text").keyup(_.debounce(function(event) {
    $.ajax({
      type: "POST",
      url: "/render",
      data: {
        format: $('#format').val(),
        data: $("#text").val()
      },
      success: function(data) {
        $('#preview').empty().append(data);
      }
    });
  },300));
});
