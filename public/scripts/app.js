$(function(){
  function resize() {
    var height = $(window).height() - $("#header").outerHeight() - 20;
    $("#text").height(height);
    $("#readme").height(height);
  }
  resize();
  $(window).resize(_.debounce(resize,300));
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
