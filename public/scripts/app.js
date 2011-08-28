$(function(){
  function resize() {
    var height = $(window).height() - $("#header").outerHeight() - 20;
    $("#text").height(height);
    $("#preview").height(height);
  }
  resize();
  $(window).resize(_.debounce(resize,300));

  function syncScroll() {
    var textarea = {
      size: $('#text')[0].scrollHeight,
      visibleSize: $('#text').height(),
      position: $('#text').scrollTop()
    };
    var preview = {
      size: $('#preview')[0].scrollHeight,
      visibleSize: $('#preview').height(),
      position: $('#preview').scrollTop()
    }
    var ratio = textarea.position / (textarea.size - textarea.visibleSize);
    $('#preview').scrollTop((preview.size - preview.visibleSize) * ratio);
  }
  $('#text').scroll(syncScroll);

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
        syncScroll();
      }
    });
  }
  $("#format").change(render);
  $("#text").bind('input',_.debounce(render,300));
});
