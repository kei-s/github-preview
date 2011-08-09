$(function(){
  function resize() {
    var height = $(window).height() - $("#header").outerHeight() - 20;
    $("#text").height(height);
    $("#readme").height(height);
  }
  resize();
  $(window).resize(_.debounce(resize,300));

  function render() {
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
  }
  $("#format").change(render);
  $("#text").keyup(_.debounce(render,300));
});
